Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTFJL7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 07:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTFJL7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 07:59:10 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55424 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262473AbTFJL7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 07:59:05 -0400
Date: Tue, 10 Jun 2003 08:14:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: BalaKrishna Mallipeddi <bkmallipeddi@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem while including a module to kernel
In-Reply-To: <20030610115247.55738.qmail@web10707.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0306100804570.3774@chaos>
References: <20030610115247.55738.qmail@web10707.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, BalaKrishna Mallipeddi wrote:

> Hi,
>    I am in deep trouble to include a module to kernel.
>
> I am getting the following warnings, errors and hints
> while compiling(via makefile) and including the
> module(via insmod) to kernel. I am including the log
> below for easy reference. Please help me.
> log:
> root@(none):/home/chois/rfs_modules/fdisk# make
> gcc -Wall -DMODULE -D__KERNEL__ -DLINUX -c
> rfs_fdisk_module.c
> rfs_fdisk_module.c: In function `rfs_fdisk_module':
> rfs_fdisk_module.c:374: warning: implicit declaration
> of function `ioctl'
> rfs_fdisk_module.c:403: warning: implicit declaration
> of function
> `reboot'root@(none):/home/chois/rfs_modules/fdisk#
> sync
> root@(none):/home/chois/rfs_modules/fdisk# insmod
> rfs_fdisk_module.o
> rfs_fdisk_module.o: unresolved symbol read
> rfs_fdisk_module.o: unresolved symbol reboot
> rfs_fdisk_module.o: unresolved symbol lseek
> rfs_fdisk_module.o: unresolved symbol _exit
> rfs_fdisk_module.o: unresolved symbol write
> rfs_fdisk_module.o: unresolved symbol ioctl
> rfs_fdisk_module.o:
> Hint: You are trying to load a module without a GPL
> compatible license
>       and it has unresolved symbols.  Contact the
> module supplier for
>       assistance, only they can help you.
>
>

No! The problem is that what he is trying to load is __not__
a module!

The "hint" is

> rfs_fdisk_module.c:374: warning: implicit declaration
> of function `ioctl'

This is, therefore, not a function within the module, but
something called, perhaps from a runtime library.

It is likely that all the other symbols like read, write, lseek,
etc., are also expected to be resolved by the 'C' runtime library
rather than being internal to the module.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

