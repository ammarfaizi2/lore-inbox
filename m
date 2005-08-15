Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVHOQRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVHOQRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVHOQRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:17:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3089 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964807AbVHOQRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:17:38 -0400
Date: Mon, 15 Aug 2005 17:55:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: mustang4@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Hang or stop after uncompressing MPC8245
Message-ID: <20050815155505.GF20363@alpha.home.local>
References: <1124122213.4300be659dc89@imp5-q.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124122213.4300be659dc89@imp5-q.free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 15, 2005 at 06:10:13PM +0200, mustang4@free.fr wrote:
> 
> Hello,
> 
> I try to boot my linux kernel (with 2.4 or 2.6 it's the same problem) on an
> embeded board (EM04N MenMicro) base on a MPC8245 cpu...
> 
> When i boot i 've;
> 
> > Detected PPCBOOT header
> >     Verifying image CRC...ok
> >     Uncompressing Multi-File Image ... ok
> >     Moving initrd...ok
> >     Passing Kernel parameters: root=ramfs console=ttyS0,9600
> >     Starting Linux Kernel.
> >
> and stop here... i must hard reset the board...
> 
> Anyone boot a linux kernel on this board ?
> I heard about UART serial port problem with MPC8245 cpu, but i don't find a
> working solution for patching kernel or setting up correctly...

Although I don't know this board, here are a few questions :
  - are you sure that you enabled the correct serial driver and that it is
    linked to the zImage and not build as a module ?
  - are you sure that you enabled "console on serial port" in the config ?
  - how can you be certain that the serial will appear on ttyS0 and not ttyS1
    or another one (the kernel might detect another serial port which it
    assigns ttyS0)
  - is it possible that you have trouble with the endianness of the image ?
    example: little endian image loaded on big endian CPU ?

Regards,
Willy

> Anyone can help me ?
> 
> I use :
> ELDK kit cross compilation for PPC8245
> uBoot
> and official last kernel source...
> 
> Thanks
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
