Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSLCJW3>; Tue, 3 Dec 2002 04:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbSLCJW3>; Tue, 3 Dec 2002 04:22:29 -0500
Received: from [203.167.79.9] ([203.167.79.9]:55055 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S264878AbSLCJW3>; Tue, 3 Dec 2002 04:22:29 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1038917280.1228.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 17:22:35 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 01:31, James Simmons wrote:
> 
> > Attached is a patch against 2.5.49 + James Simmons' latest fbdev.diff.
> > 
> > Added support for logo drawing.
> > Fixed vga16fb_imageblit() limitation of 8-pixel wide bitmap blitting
> > only.
> 
> Applied and tested :-=) The only weird thing is it drew the logo twice 
> when I don't have a SMP laptop. It works other than that. 
> 
Should be expected if the fbcon_show_logo() patch did not take.  I'm
resubmitting another patch in one of my replies.

> P.S
>   Things I like to get done for the vga16fb driver. 
> 
>   1) Its own read and write functions to fake a linear framebuffer.
Should be doable with fb_write and fb_read, but with mmap, the app still
needs to know the VGA format.

>   2) The ability to go back to vga text mode on close of /dev/fb. 
>      Yes fbdev/fbcon supports that now. 

I'll take a stab at writing VGA save/restore routines which hopefully is
generic enough to be used by various hardware.  No promises though, VGA
programming gives me a headache :(

Tony

