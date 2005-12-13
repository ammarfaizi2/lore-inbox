Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVLMVXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVLMVXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVLMVXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:23:49 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:2820 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S932385AbVLMVXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:23:48 -0500
Date: Tue, 13 Dec 2005 17:15:48 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Gerd Knorr <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] uml: Framebuffer driver for UML
Message-ID: <20051213221548.GB9769@ccure.user-mode-linux.org>
References: <439EE38C.6020602@suse.de> <439EE5B0.2030709@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439EE5B0.2030709@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 04:16:00PM +0100, Gerd Knorr wrote:
> $subject says pretty much all: This adds a framebuffer driver for UML.

> please apply,
> 
>   Gerd

Please don't.  This patch fails to link for me in -rc5 - the errors start like

drivers/built-in.o(.text+0x18b): In function `vgacon_deinit':
/home/jdike/linux/2.6/linux-2.6.15/drivers/video/console/vgacon.c:151: undefined reference to `outw'
drivers/built-in.o(.text+0x1a7):/home/jdike/linux/2.6/linux-2.6.15/drivers/video/console/vgacon.c:152: undefined reference to `outw'
drivers/built-in.o(.text+0x366): In function `vgacon_set_cursor_size':
/home/jdike/linux/2.6/linux-2.6.15/drivers/video/console/vgacon.c:430: undefined reference to `outb_p'
drivers/built-in.o(.text+0x375):/home/jdike/linux/2.6/linux-2.6.15/drivers/video/console/vgacon.c:431: undefined reference to `inb_p'
drivers/built-in.o(.text+0x396):/home/jdike/linux/2.6/linux-2.6.15/drivers/video/console/vgacon.c:432: undefined reference to `outb_p'
drivers/built-in.o(.text+0x3a5):/home/jdike/linux/2.6/linux-2.6.15/drivers/video/console/vgacon.c:433: undefined reference to `inb_p'

and go on for another couple hundred lines.

IIRC, I found fixes for these when I merged this into my tree.  It's a nice 
addition, but there are aspects of this that I don't like, which is why I
haven't sent it in myself.  Again, IIRC, enabling this disables the normal 
consoles, which is fairly unfriendly.

				Jeff
