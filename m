Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275207AbRJJKIy>; Wed, 10 Oct 2001 06:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275211AbRJJKId>; Wed, 10 Oct 2001 06:08:33 -0400
Received: from fismat1.fcfm.buap.mx ([148.228.125.1]:24750 "EHLO
	fismat1.fcfm.buap.mx") by vger.kernel.org with ESMTP
	id <S275207AbRJJKIO>; Wed, 10 Oct 2001 06:08:14 -0400
Date: Wed, 10 Oct 2001 04:08:04 -0500 (CDT)
From: Luis Montgomery <monty@fismat1.fcfm.buap.mx>
To: linux-kernel@vger.kernel.org
Subject: 2.4.11:compile 8139too as module fail
Message-ID: <Pine.GSO.4.21.0110100405540.27961-100000@fismat1.fcfm.buap.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the gcc report:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.11/include -Wall -Wstrict-prototypes
-Wno-
trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpref
erred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linu
x-2.4.11/include/linux/modversions.h   -c -o 8139too.o 8139too.c
8139too.c: In function `netdev_ethtool_ioctl':
8139too.c:2419: Unrecognizable insn:
(insn/i 612 1054 1051 (parallel[
            (set (reg:SI 6 ebp)
                (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl
%1,%4; sbbl $0,
%0") ("=&r") 0[
                        (reg/v:SI 1 edx [166])
                        (mem:SI (plus:SI (reg/f:SI 6 ebp)
                                (const_int -352 [0xfffffea0])) 0)
                        (mem/s:SI (plus:SI (reg:SI 0 eax [174])
                                (const_int 12 [0xc])) 0)
                    ]
                    [
                        (asm_input:SI ("1"))
                        (asm_input:SI ("g"))
                        (asm_input:SI ("g"))
                    ]
("/usr/src/linux-2.4.11/include/asm/uaccess.h") 558))
            (set (reg/v:SI 1 edx [166])
                (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl
%1,%4; sbbl $0,
%0") ("=r") 1[
                        (reg/v:SI 1 edx [166])
                        (mem:SI (plus:SI (reg/f:SI 6 ebp)
                                (const_int -352 [0xfffffea0])) 0)
                        (mem/s:SI (plus:SI (reg:SI 0 eax [174])
                                (const_int 12 [0xc])) 0)
                    ]
                    [
                        (asm_input:SI ("1"))
                        (asm_input:SI ("g"))
                        (asm_input:SI ("g"))
                    ]
("/usr/src/linux-2.4.11/include/asm/uaccess.h") 558))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 598 (insn_list 605 (nil)))
    (nil))
8139too.c:2419: Internal compiler error in reload_cse_simplify_operands,
at relo
ad1.c:8355


Luis Montgomery

