Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268233AbUHQNrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268233AbUHQNrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268237AbUHQNrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:47:53 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:59087 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268233AbUHQNrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:47:52 -0400
Date: Tue, 17 Aug 2004 09:51:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Shaun Jackman <sjackman@telus.net>, linux-kernel@vger.kernel.org
Subject: Re: Hang after "BIOS data check successful" with DVI
In-Reply-To: <E82D6B0981@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.58.0408170950470.22078@montezuma.fsmlabs.com>
References: <E82D6B0981@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004, Petr Vandrovec wrote:

> On 16 Aug 04 at 16:55, Shaun Jackman wrote:
> > When I have a DVI display plugged into my Matrox G550 video card the
> > boot process hangs at "BIOS data check successful". I am running Linux
> > kernel 2.6.6. This problem does not affect Linux kernel 2.4.26. If I
> > boot without the DVI display plugged in, I can plug it in after the
> > boot process and the display works.
>
> Try disabling CONFIG_VIDEO_SELECT and/or comment out call to store_edid
> in arch/i386/boot/video.S. Also which bootloader you use? From
> quick glance at bootloaders, grub1 seems to set %sp to 0x9000, while
> LILO to 0x0800. And I think that 2048 byte stack (plus something already
> allocated by loader) might be too small for DDC call, as MGA BIOS first
> creates EDID copy on stack...

Urgh, this bug is still around :(

http://bugme.osdl.org/show_bug.cgi?id=1458
