Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUCSO37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUCSO37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:29:59 -0500
Received: from styx.suse.cz ([82.208.2.94]:1152 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261582AbUCSO35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:29:57 -0500
Date: Fri, 19 Mar 2004 15:30:14 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
Message-ID: <20040319143014.GA749@ucw.cz>
References: <20040316182409.54329.qmail@web80508.mail.yahoo.com> <20040318203717.GA4430@ucw.cz> <200403190005.36956.dtor_core@ameritech.net> <20040319135819.GB658@ucw.cz> <405B01E7.5000809@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405B01E7.5000809@stesmi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 03:21:27PM +0100, Stefan Smietanowski wrote:
> Hi.
> 
> >So far on every machine I've got a report from it was caused by BIOS
> >emulation of PS/2 mouse using an USB mouse (even when USB mouse wasn't
> >present). Compiling the USB modules into the kernel fixes the problem.
> 
> Could this have anything to do with the fact that my x86-64 kernel nukes
> on startup if USB keyboard/mouse emul is enabled in the BIOS?

Yes, and no. USB keyboard/mouse emulation is simply broken in most
BIOSes. It's even more broken on AMD64 BIOSes, because usually noone
tests its interaction with 64-bit longmode. And thus when it is invoked
in 64-bit longmode, it crashes the machine.

On x86 it just causes problems with PS/2 mouse and keyboard.

So it's caused by the same thing, but these are two different problems.

> This is on an ASUS K8T800 and an MSI K8T800 board.
> 
> If you don't know what I'm talking about I'll give more info of course.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
