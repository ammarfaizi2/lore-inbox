Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTFPWAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTFPWAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:00:14 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:54538 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264377AbTFPWAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:00:11 -0400
Date: Mon, 16 Jun 2003 23:14:03 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Tony Lill <ajlill@tardis.ajlc.waterloo.on.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: help with 2.5.70 on Dell inspiron - no display
In-Reply-To: <200306151839.h5FIdBFL006301@spider.ajlc.waterloo.on.ca>
Message-ID: <Pine.LNX.4.44.0306162254530.26878-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've been playing wiht 2.5.70 on my laptop, but I can't get any screen
> output. The Inspiron uses a
> VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 100).
> according to /proc/pci. I started wiht a working .config from my 2.4
> kernel and did make oldconfig, and I've been playing wiht the
> framebuffer and console options, but the best I've been able to do is
> get the cursor to appear, but no text. I know the box is booting
> beacuse the cursor moves like it's writin output.

You have to many fbd4ev drivers selected. You need to pick one.

> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_MATROX is not set
> CONFIG_FB_RADEON=y
> CONFIG_FB_ATY128=y
> CONFIG_FB_ATY=y
> CONFIG_FB_ATY_CT=y
> CONFIG_FB_ATY_GX=y
> CONFIG_FB_ATY_XL_INIT=y
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=m

?? You are booting into VGA text mode and framebuffer console as a 
modules. I bet you have vga=0x7XX which makes the hardware switch to 
graphics mode. Not good with vgacon.


