Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280619AbRKBJUH>; Fri, 2 Nov 2001 04:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280620AbRKBJT6>; Fri, 2 Nov 2001 04:19:58 -0500
Received: from mx10.port.ru ([194.67.57.20]:56761 "EHLO mx10.port.ru")
	by vger.kernel.org with ESMTP id <S280619AbRKBJTn>;
	Fri, 2 Nov 2001 04:19:43 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200111020921.fA29LP718803@vegae.deep.net>
Subject: 3.0.2 fails to build linux-2.4.13-ac5, 8139.c
To: gcc-bugs@gcc.gnu.org
Date: Fri, 2 Nov 2001 12:21:19 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     Hello folks, got a following issue:
make[3]: Entering directory `/usr/src/linux/drivers/net'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586    -c -o 8139too.o 8139too.c
8139too.c: In function `netdev_ethtool_ioctl':
8139too.c:2432: Unrecognizable insn:
(insn/i 609 1066 1063 (parallel[
            (set (reg:SI 6 ebp)
                (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0") ("=&r") 0[
                        (reg/v:SI 1 edx [165])
                        (mem:SI (plus:SI (reg/f:SI 6 ebp)
                                (const_int -352 [0xfffffea0])) 0)
                        (mem/s:SI (plus:SI (reg:SI 0 eax [173])
                                (const_int 12 [0xc])) 0)
                    ]
                    [
                        (asm_input:SI ("1"))
                        (asm_input:SI ("g"))
                        (asm_input:SI ("g"))
                    ]  ("/usr/src/linux/include/asm/uaccess.h") 558))
            (set (reg/v:SI 1 edx [165])
                (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0") ("=r") 1[
                        (reg/v:SI 1 edx [165])
                        (mem:SI (plus:SI (reg/f:SI 6 ebp)
                                (const_int -352 [0xfffffea0])) 0)
                        (mem/s:SI (plus:SI (reg:SI 0 eax [173])
                                (const_int 12 [0xc])) 0)
                    ]
                    [
                        (asm_input:SI ("1"))
                        (asm_input:SI ("g"))
                        (asm_input:SI ("g"))
                    ]  ("/usr/src/linux/include/asm/uaccess.h") 558))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 595 (insn_list 602 (nil)))
    (nil))
8139too.c:2432: Internal compiler error in reload_cse_simplify_operands, at reload1.c:8364
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
make[3]: *** [8139too.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

