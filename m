Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVBBTen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVBBTen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVBBTeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:34:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7382 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262741AbVBBTb3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:31:29 -0500
Date: Wed, 2 Feb 2005 19:31:24 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Haakon Riiser <haakon.riiser@fys.uio.no>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
In-Reply-To: <20050202154139.GA3267@s>
Message-ID: <Pine.LNX.4.56.0502021930250.20184@pentafluge.infradead.org>
References: <20050202133108.GA2410@s> <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com>
 <20050202142155.GA2764@s> <1107357093.6191.53.camel@gonzales>
 <20050202154139.GA3267@s>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Le mercredi 02 février 2005 à 15:21 +0100, Haakon Riiser a
> > écrit :
> 
> >> How can I use a frame buffer driver's optimized copyarea,
> >> fillrect, blit, etc. from userspace?  The only way I've ever
> >> seen anyone use the frame buffer device is by mmap()ing it
> >> and doing everything manually in the mapped memory.  I assume
> >> there must be ioctls for accessing the accelerated functions,
> >> but after several hours of grepping and googling, I give up. :-(
> 
> > Did you try DirectFB ?
> 
> Thanks for the tip, I hadn't heard about it.  I will take a look,
> but only to see if it can show me the user space API of /dev/fb.
> I don't need a general library that supports a bunch of different
> graphics cards.  I'm writing my own frame buffer driver for the
> GX2 CPU, and I just want to know how to call the various functions
> registered in struct fb_ops, so that I can test my code.  I mean,
> all those functions registered in fb_ops must be accessible
> somehow; if they weren't, what purpose would they serve?

The reason for the accelerated functions is for the framebuffer console.
Drawing pixel by pixel is to slow.

