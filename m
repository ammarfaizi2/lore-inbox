Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279941AbRJ3MUY>; Tue, 30 Oct 2001 07:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279942AbRJ3MUO>; Tue, 30 Oct 2001 07:20:14 -0500
Received: from [213.228.128.56] ([213.228.128.56]:32500 "HELO
	front1.netvisao.pt") by vger.kernel.org with SMTP
	id <S279941AbRJ3MUC>; Tue, 30 Oct 2001 07:20:02 -0500
To: linux-kernel@vger.kernel.org
Subject: 8139too.c Problem
From: pocm@rnl.ist.utl.pt (Paulo J. Matos aka PDestroy)
Date: 30 Oct 2001 12:23:13 +0000
Message-ID: <m3y9lte2q6.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm using gcc3.0 and I tried to compile the kernel. This same thing
happens in kernel 2.4.12 and 2.4.13.
Do I need a gcc update or what?

gcc -D__KERNEL__ -I/usr/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o 8139too.o 8139too.c
8139too.c: In function `netdev_ethtool_ioctl':
8139too.c:2432: Unrecognizable insn:
(insn/i 618 1061 1058 (parallel[ 
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
                    ]  ("/usr/src/linux-2.4.13/include/asm/uaccess.h") 558))
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
                    ]  ("/usr/src/linux-2.4.13/include/asm/uaccess.h") 558))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 604 (insn_list 611 (nil)))
    (nil))
8139too.c:2432: Internal compiler error in reload_cse_simplify_operands, at reload1.c:8355
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.



Best regards,

-- 
Paulo J. Matos aka PDestroy : pocm@rnl.ist.utl.pt
Instituto Superior Tecnico - Lisbon
Software & Computer Engineering - A.I.
 - > http://www.rnl.ist.utl.pt/~pocm

