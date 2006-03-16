Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751981AbWCPPf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWCPPf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWCPPf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:35:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:18193 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751981AbWCPPf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:35:28 -0500
Date: Thu, 16 Mar 2006 16:35:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: beware <wimille@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adding a new module in the Kernel source
Message-ID: <20060316153522.GA23386@mars.ravnborg.org>
References: <3fd7d9680603160329i23b2f58bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd7d9680603160329i23b2f58bg@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 12:29:19PM +0100, beware wrote:
> Hi everybody,
> 
> I want to compile the last stable version of the Linux Kernel
> (2.6.15.6) but i want to add my own module in the kernel.
> 
> Firstly, is it a good idea to do this? Or it's more simple to add this
> module after the compilation and add it to the modules which are
> automicaly laoded?
> 
> But, if i want to add this module in the kernel source, what do i have
> to do for this operation?
To include the module in kernel sources is simple.
Let's assume it is a char driver and the module is named beware.

1) copy source to drivers/char
cp beware.c $KERNEL_SRC_DIR/drivers/char/

2) Edit makefile to include your module:
Just above the clean-files statement add:
obj-y += beware.o

And you are ready to compile the kernel with your module built-in.

May I also refer you to Linux Device Drivers volume 3 (LDD3) and to
Documentation/kbuild/* in the kernel source.

	Sam
