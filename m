Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290505AbSAYC3I>; Thu, 24 Jan 2002 21:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290511AbSAYC26>; Thu, 24 Jan 2002 21:28:58 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:29337
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S290505AbSAYC2m>; Thu, 24 Jan 2002 21:28:42 -0500
Date: Thu, 24 Jan 2002 21:37:11 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: dac960 + alpha + gcc 2.95.4
Message-ID: <20020124213711.A21167@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this error when compileing dac960.o on an alpha noritake with gcc
2.95.4 (I'm using debian/woody updated as of today)

gcc -D__KERNEL__ -I/usr/src/2.4.17/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev4 -Wa,-mev6 -DMODULE   -DEXPORT_SYMTAB -c DAC960.c
DAC960.c: In function `DAC960_V2_EnableMemoryMailboxInterface':
DAC960.c:1054: internal error--unrecognizable insn:
(insn 949 477 474 (set (reg:DI 2 $2)
        (plus:DI (reg:DI 30 $30)
            (const_int 4398046511104 [0x40000000000]))) -1 (nil)
    (nil))
cpp0: output pipe has been closed
make[1]: *** [DAC960.o] Error 1

I know gcc 2.96 can compile this (thanks Michal Jaegermann for compiling it
for me) as I'm using a kernel + the module (compiled with 2.96) w/o any
problems.  I tried gcc 3.0.3 but I received tons of ecc errors on the
console (kernel messages, sysrq-0 stopped them)

ideas?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
