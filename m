Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSLCRzP>; Tue, 3 Dec 2002 12:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSLCRzP>; Tue, 3 Dec 2002 12:55:15 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S262838AbSLCRzN>; Tue, 3 Dec 2002 12:55:13 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>
Cc: "'Richard Henderson'" <rth@twiddle.net>,
       "'Bjoern Brauel'" <bjb@gentoo.org>, <linux-kernel@vger.kernel.org>
Subject: RE: kernel build of 2.5.50 fails on Alpha
Date: Tue, 3 Dec 2002 19:02:11 +0100
Message-ID: <003c01c29af6$1b0240c0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20021202231624.A1571@jurassic.park.msu.ru>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> arch/alpha/kernel/pci.c: In function `pcibios_fixup_final':
> arch/alpha/kernel/pci.c:128: `ALPHA_ALCOR_MAX_DMA_ISA_ADDRESS' undeclared
I> My fault. Please try this.

Still problems:

        ld  -static -N  -T arch/alpha/vmlinux.lds.s arch/alpha/kernel/head.o
init/built-in.o --start-group  usr/built-in.o  arch/alpha/kernel/built-in.o
arch/alpha/mm/built-in.o  arch/alpha/math-emu/built-in.o  kernel/built-in.o
mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o
crypto/built-in.o  lib/lib.a  arch/alpha/lib/lib.a  drivers/built-in.o
sound/built-in.o  net/built-in.o --end-group  -o vmlinux
net/built-in.o: In function `ip_conntrack_helper_register':
net/built-in.o(.text+0x69040): undefined reference to `__this_module'
net/built-in.o(.text+0x69080): undefined reference to `__this_module'
net/built-in.o: In function `ip_conntrack_helper_unregister':
net/built-in.o(.text+0x6916c): undefined reference to `__this_module'
net/built-in.o: In function `ip_nat_helper_register':
net/built-in.o(.text+0x6d314): undefined reference to `__this_module'
net/built-in.o(.text+0x6d350): undefined reference to `__this_module'
net/built-in.o(.text+0x6d640): more undefined references to `__this_module'
follow
make: *** [vmlinux] Error 1

Also strange: I had to switch on the input-stuff (keyboard/events/etc.),
otherwhise I would get even more errors.


Folkert van Heusden
http://www.vanheusden.com/Linux/kernel_patches.php3

