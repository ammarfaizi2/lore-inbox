Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263708AbTJCO0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 10:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbTJCO0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 10:26:51 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:49398
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S263708AbTJCO0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 10:26:49 -0400
Message-ID: <3F7D8723.E1898A5@eyal.emu.id.au>
Date: Sat, 04 Oct 2003 00:26:43 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1: scsi/pcmcia qlogic does not build
References: <20031002152648.GB1240@velociraptor.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-poi
nter -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686
-malign-functio
ns=4 -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/inclu
de/linux/modversions.h  -nostdinc -iwithprefix include
-DKBUILD_BASENAME=qlogicf
as -DPCMCIA -D__NO_VERSION__ -c -o qlogicfas.o ../qlogicfas.c
../qlogicfas.c: In function `qlogicfas_detect':
../qlogicfas.c:650: warning: passing arg 1 of
`scsi_unregister_R2c5e5a25' from incompatible pointer type
ld -m elf_i386 -r -o qlogic_cs.o qlogic_stub.o qlogicfas.o
qlogicfas.o: In function `init_module':
qlogicfas.o(.text+0xe40): multiple definition of `init_module'
qlogic_stub.o(.text+0x770): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
qlogicfas.o
qlogicfas.o: In function `cleanup_module':
qlogicfas.o(.text+0xe80): multiple definition of `cleanup_module'
qlogic_stub.o(.text+0x7c0): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
qlogicfas.o
make[3]: *** [qlogic_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/drivers/scsi/pcmcia'

A broken build?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
