Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265519AbTL3AEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTL3AEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:04:48 -0500
Received: from [64.65.177.98] ([64.65.177.98]:2534 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S265519AbTL3AEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:04:46 -0500
Subject: Re: Kernel panic while upgrading from 2.4.20-6 to 2.4.22
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58L.0312281944370.15976@logos.cnet>
References: <20031225023952.32560.qmail@web80710.mail.yahoo.com>
	 <Pine.LNX.4.58L.0312281944370.15976@logos.cnet>
Content-Type: text/plain
Message-Id: <1072742671.21939.6.camel@bubbles.imr-net.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 16:04:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-29 at 11:31, Marcelo Tosatti wrote:
> On Wed, 24 Dec 2003, Elwin Eliazer wrote:
> 
> > ds: no socket drivers loaded!
> > VFS: Cannot open root device "LABEL=/" or 00:00
> > Please append a correct "root=" boot option
> > Kernel panic: VFS: Unable to mount root fs on 00:00
> 
> If you want to use the vanilla kernel, you need to use "root=/dev/xxx"
> instead "LABEL=/".
> 

You can also use the mkinitrd that comes with redhat:

# cd /usr/src/linux-2.4.22

# make config
# make dep
# make bzImage
# make modules
# make modules_install
# cp System.map /boot/System.map-2.4.22
# cp arch/i386/boot/bzImage /boot/vmlinuz-2.4.22
# mkinitrd /boot/initrd-2.4.22.img 2.4.22

If you get errors, it will most likely be SCSI or something.

Try:

  --omit-raid-modules  or  --omit-scsi-modules.

man mkinitrd.

js


