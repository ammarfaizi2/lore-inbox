Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbSJIOfC>; Wed, 9 Oct 2002 10:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbSJIOfC>; Wed, 9 Oct 2002 10:35:02 -0400
Received: from ma-northadams1b-3.bur.adelphia.net ([24.52.166.3]:10134 "EHLO
	ma-northadams1b-3.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S261803AbSJIOfB>; Wed, 9 Oct 2002 10:35:01 -0400
Date: Wed, 9 Oct 2002 10:40:39 -0400
From: Eric Buddington <eric@ma-northadams1b-3.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.41: ide-probe.c: HD_IRQ undeclared
Message-ID: <20021009104039.A15212@ma-northadams1b-3.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a compile failure on 2.5.41, compiled for a PII using gcc-3.0.4.
Just about all options configured as 'm'.

-Eric

--------------------------------------------------

gcc -Wp,-MD,arch/i386/pci/.irq.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-proto types -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common - pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc
 -iwithprefix include -DKBUILD_BASENAME=irq -c -o arch/i386/pci/irq.o
arch/ i386/pci/irq.c

drivers/ide/ide-probe.c: In function `hwif_init':
drivers/ide/ide-probe.c:1026: `HD_IRQ' undeclared (first use in this function)
drivers/ide/ide-probe.c:1026: (Each undeclared identifier is reported only once
drivers/ide/ide-probe.c:1026: for each function it appears in.)
make[2]: *** [drivers/ide/ide-probe.o] Error 1
make[1]: *** [drivers/ide] Error 2
make: *** [drivers] Error 2
