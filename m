Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129357AbRBOQbR>; Thu, 15 Feb 2001 11:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129570AbRBOQbH>; Thu, 15 Feb 2001 11:31:07 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:58125 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S129357AbRBOQau>; Thu, 15 Feb 2001 11:30:50 -0500
Date: Thu, 15 Feb 2001 11:30:46 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.1ac12 mkdep -I support - take 2
Message-ID: <Pine.LNX.4.33.0102151122360.15924-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Keith!

You patch has been applied to 2.4.1ac13, but it doesn't help:

$ HPATH=. ../../scripts/mkdep -- names.c
names.o: names.c \
   $(wildcard /home/proski/src/linux/drivers/pci/config/pci/names.h) \
   /home/proski/src/linux/drivers/pci/devlist.h \
   /home/proski/src/linux/drivers/pci/devlist.h \
   /home/proski/src/linux/drivers/pci/devlist.h
$ ls
Config.in  compat.o       names.c  pci.o     quirks.o     setup-res.c
Makefile   devlist.h      pci.c    proc.c    setup-bus.c  syscall.c
compat.c   gen-devlist.c  pci.ids  quirks.c  setup-irq.c

devlist.h is in the current directory, but the full path is used.

Regards,
Pavel Roskin

