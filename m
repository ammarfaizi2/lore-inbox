Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311575AbSC1EAD>; Wed, 27 Mar 2002 23:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311582AbSC1D7x>; Wed, 27 Mar 2002 22:59:53 -0500
Received: from holomorphy.com ([66.224.33.161]:36516 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S311575AbSC1D7l>;
	Wed, 27 Mar 2002 22:59:41 -0500
Date: Wed, 27 Mar 2002 19:59:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 build breakage around blkpg.c
Message-ID: <20020328035926.GA10467@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What hit me?


Thanks,
Bill

VERSION = 2
PATCHLEVEL = 5
SUBLEVEL = 7
EXTRAVERSION =

$ gcc --version
2.95.4

$ as --version
GNU assembler 2.11.93.0.2 20020207 Debian/GNU Linux
...

gcc -D__KERNEL__ -I/home/wli/src/linus/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i386   -DKBUILD_BASENAME=blkpg  -c -o blkpg.o blkpg.c
blkpg.c: In function `blk_ioctl':
blkpg.c:311: Internal compiler error:
blkpg.c:311: internal error--unrecognizable insn:
(insn 898 1478 907 (set (reg/v:SI 3 %ebx)
        (asm_operands/v ("1:    movl %%eax,0(%2)
2:      movl %%edx,4(%2)
3:
.section .fixup,"ax"
4:      movl %3,%0
        jmp 3b
.previous
.section __ex_table,"a"
        .align 4
        .long 1b,4b
        .long 2b,4b
.previous") ("=r") 0[ 
                (reg:DI 1 %edx)
                (reg/v:SI 4 %esi)
                (const_int -14 [0xfffffff2])
                (reg/v:SI 3 %ebx)
            ] 
            [ 
                (asm_input:DI ("A"))
                (asm_input:SI ("r"))
                (asm_input:SI ("i"))
                (asm_input:SI ("0"))
            ]  ("blkpg.c") 268)) -1 (insn_list 873 (insn_list 897 (nil)))
    (nil))

