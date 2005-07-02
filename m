Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVGBFur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVGBFur (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 01:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVGBFur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 01:50:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:1241 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261807AbVGBFul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 01:50:41 -0400
Date: Fri, 1 Jul 2005 22:37:11 -0700
From: Greg KH <greg@kroah.com>
To: Eric Valette <eric.valette@free.fr>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS + empty /dev
Message-ID: <20050702053711.GA5635@kroah.com>
References: <42C30CBC.5030704@free.fr> <20050629224040.GB18462@kroah.com> <1120137161.42c3efc93b36c@imp1-q.free.fr> <20050630155453.GA6828@kroah.com> <42C455C1.30503@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C455C1.30503@free.fr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 10:27:45PM +0200, Eric Valette wrote:
> 
> BTW speaking of initramfs to hold the minimal /dev, in the embedded
> world initramfs has to be stored in flash as udev binary and eventually
> additionnal scripts, this represent flash memory (OK very little I have
> to admit but when you need to find 10K of flash or change the flash
> size...).

Why?  Why not put it in ROM with your kernel image, look at how the
kernel build process does it with the "built-in" initramfs.

If that doesn't work, initrd still works just as well for udev, that's
what RH does.

> I hope someone will pick-up your nano defvs proposal and enhance it to
> support a  version enabling to boot a system without anything in /dev.

I boot my boxes with nothing in /dev and have been for almost a year
now.  udev works just fine for this, and so do some other programs that
work like udev does.

I hope everyone can just forget about my nano devfs proposal, and just
pass it off as a example of someone who went temporarily insane.

thanks,

greg k-h
