Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSKNBbl>; Wed, 13 Nov 2002 20:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSKNBbk>; Wed, 13 Nov 2002 20:31:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7175 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261364AbSKNBbd>; Wed, 13 Nov 2002 20:31:33 -0500
Date: Wed, 13 Nov 2002 17:38:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: local APIC may cause XFree86 hang
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000F866078@fmsmsx103.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0211131735490.6810-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Nov 2002, Nakajima, Jun wrote:
> 
> The one instance I saw was that the BIOS was reading 8254 in a tight loop
> for a calibration purpose, and it was assuming the time proceeded in a
> constant speed, to exit the loop. In other words, it never assumed it could
> get interrupts. To vm86, interrupts are invisible, but they have impacts on
> the actual speed. 

That sound slike a perfectly ok thing to do - apart from the hw latching
which might confuse the kernel.

When enabling the local APIC, Linux doesn't actually disable legacy PIT
interrupts, so again I don't really see what the apparent connection
between the hang and the APIC is. So I'd still suspect it's more
timing-related than anything else.

		Linus

