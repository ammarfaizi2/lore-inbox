Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271076AbTGPVQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271133AbTGPVQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:16:48 -0400
Received: from ms-smtp-02.southeast.rr.com ([24.93.67.83]:15772 "EHLO
	ms-smtp-02.southeast.rr.com") by vger.kernel.org with ESMTP
	id S271076AbTGPVQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:16:30 -0400
Subject: Re: 2.6.0-test1 Vesa fb and Nvidia
From: "David St.Clair" <dstclair@cs.wcu.edu>
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200307162033.h6GKXTup002619@turing-police.cc.vt.edu>
References: <1058386396.3710.4.camel@localhost>
	 <200307162033.h6GKXTup002619@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1058391079.2471.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 17:31:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have also tried using CONFIG_FB_VGA16 as a module (so it's not loaded
by default) and I get the same results.

In /arch/i386/boot/video.S 
CONFIG_VIDEO_VESA is defined. CONFIG_VIDEO_SVGA is the only one not
defined.

Setting it in my .config file didn't seem to work. (I may be doing
something dumb here...) It resulted in a warning message ".config:1318:
trying to assign nonexistent symbol VIDEO_VESA"

Trying to boot using vga=794 didn't help either.

I have the binary NVIDIA driver working. I used the 2.5/2.6 patches.

Thanks for your help,

David St.Clair


On Wed, 2003-07-16 at 16:33, Valdis.Kletnieks@vt.edu wrote: 
> On Wed, 16 Jul 2003 16:13:16 EDT, "David St.Clair" <dstclair@cs.wcu.edu>  said:
> > I don't know if this is a hardware specific bug or I just don't have
> > something configured right.
> 
> 2.6.0-test1-mm1, Dell C840 laptop with a Geforce4 440Go.
> 
> I do *NOT* have 'CONFIG_FB_VGA16' set, but *do* have 'CONFIG_VIDEO_VESA'.
> 
> With this, 'vga=794' gets me a small font and a penguin on boot,
> the NVidia binary driver works fine under X  after the minion.de patch,
> switching back and forth works well, and life is generally good.
> 
> Mode 792 is in the VESA bios mode range: from Documentation/svga.txt:
> 
>    0x0200 to 0x08ff - VESA BIOS modes. The ID is a VESA mode ID increased by
>         0x0100. All VESA modes should be autodetected and shown on the menu.
> ....
>    CONFIG_VIDEO_VESA - enables autodetection of VESA modes. If it doesn't work
> on your machine (or displays a "Error: Scanning of VESA modes failed" message),
> you can switch it off and report as a bug.
> 
> Try turning that on?

