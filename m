Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTE0UhJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTE0Ugv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:36:51 -0400
Received: from host81-136-131-132.in-addr.btopenworld.com ([81.136.131.132]:51863
	"EHLO mx.homelinux.com") by vger.kernel.org with ESMTP
	id S264190AbTE0Uey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:34:54 -0400
Date: Tue, 27 May 2003 21:48:07 +0100 (BST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@mx.homelinux.com
To: linux-kernel@vger.kernel.org
cc: marcelo@conectiva.com.br
Subject: Re: Linux 2.4.21-rc5
Message-ID: <Pine.LNX.4.53.0305272142200.565@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's be nice if we could also have the definition of
PCI_DEVICE_ID_VIA_8237 ?

make[4]: Entering directory
`/usr/src/linux-2.4/testing/linux-2.4.20/drivers/ide/pci'
gcc -D__KERNEL__ -I/usr/src/linux-2.4/testing/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -I../ -nostdinc -iwithprefix include -DKBUILD_BASENAME=via82cxxx  -c -o via82cxxx.o via82cxxx.c
via82cxxx.c:77: `PCI_DEVICE_ID_VIA_8237' undeclared here (not in a function)
via82cxxx.c:77: initializer element is not constant
via82cxxx.c:77: (near initialization for `via_isa_bridges[0].id')
make[4]: *** [via82cxxx.o] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4/testing/linux-2.4.20/drivers/ide/pci'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4/testing/linux-2.4.20/drivers/ide/pci'
make[2]: *** [_subdir_pci] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4/testing/linux-2.4.20/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4/testing/linux-2.4.20/drivers'
make: *** [_dir_drivers] Error 2

---------- Forwarded message ----------
Date: 2003-05-27 19:41:16
From: Marcelo Tosatti <marcelo () conectiva ! com ! br>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.21-rc5


Hi,

Mainly due to a IDE DMA problem which would happen on boxes with lots of
RAM, here is -rc5.

As I always ask, please test.


Summary of changes from v2.4.21-rc4 to v2.4.21-rc5
============================================

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o 1: (trivial) Fix the formatting of your ide hack
  o 2: =scsi option fails in some cases
  o 3: IDE DMA
  o add the via ide ident
  o fix the siimage mmio stuff

Andi Kleen <ak@muc.de>:
  o Fix 32bit ioctl holes
  o Fix context switch bug on x86-64
  o Prefetch workaround for csum-copy

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC Documentation/Configure.help fix

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc5


