Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSKNAlT>; Wed, 13 Nov 2002 19:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSKNAlT>; Wed, 13 Nov 2002 19:41:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2067 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264697AbSKNAlS>; Wed, 13 Nov 2002 19:41:18 -0500
Date: Wed, 13 Nov 2002 16:48:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: local APIC may cause XFree86 hang
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000F866009@fmsmsx103.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0211131645540.6810-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Nov 2002, Nakajima, Jun wrote:
> 
> Are we disabling vm86 code to access to PIT or PIC? I saw some video ROM
> code (either BIOS call or far call) did access PIT, confusing the OS.

Well, the kernel itself doesn't actually disable/enable anything, it 
leaves that decision to the caller. 

XFree86 obviously does have IO rights, and I suspect it may allow the 
video BIOS to do just about anything, simply because it doesn't have much 
choise (the video bios clearly needs a lot of IO privileges too). So yes, 
that could easily confuse the OS if it happens, but it should be 
independent of IO-APIC vs not.

		Linus

