Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSLBTtE>; Mon, 2 Dec 2002 14:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSLBTtE>; Mon, 2 Dec 2002 14:49:04 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:8423 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S264925AbSLBTtC>; Mon, 2 Dec 2002 14:49:02 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Richard Henderson'" <rth@twiddle.net>,
       "'Bjoern Brauel'" <bjb@gentoo.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel build of 2.5.50 fails on Alpha
Date: Mon, 2 Dec 2002 20:55:59 +0100
Message-ID: <001001c29a3c$d65eaf80$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20021201201122.A31609@twiddle.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ive been working on implementing some missing bits but what Id like to
> know is who is "officially" doing development for alpha on 2.5.

RH> See
RH>
http://ftp.kernel.org/pub/linux/kernel/people/rusty/patches/Module/rth-share
d-modules.patch.gz
RH> which I hope will make it into the kernel relatively soon.

I'm afraid that one won't compile:

arch/alpha/kernel/pci.c: In function `pcibios_fixup_final':
arch/alpha/kernel/pci.c:128: `ALPHA_ALCOR_MAX_DMA_ISA_ADDRESS' undeclared
(first use in this function)
arch/alpha/kernel/pci.c:128: (Each undeclared identifier is reported only
once
arch/alpha/kernel/pci.c:128: for each function it appears in.)
make[1]: *** [arch/alpha/kernel/pci.o] Error 1
make: *** [arch/alpha/kernel] Error 2

The only reference I could find was in asm-alpha/dma.h:
define MAX_ISA_DMA_ADDRESS         ALPHA_ALCOR_MAX_DMA_ISA_ADDRESS
but no definition.


Folkert van Heusden
http://www.vanheusden.com/Linux/kernel_patches.php3

