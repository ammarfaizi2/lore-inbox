Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbSLKADl>; Tue, 10 Dec 2002 19:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbSLKADl>; Tue, 10 Dec 2002 19:03:41 -0500
Received: from clem.digital.net ([216.230.43.233]:26377 "EHLO clem.digital.net")
	by vger.kernel.org with ESMTP id <S265608AbSLKADk>;
	Tue, 10 Dec 2002 19:03:40 -0500
From: Pete Clements <clem@clem.digital.net>
Message-Id: <200212110011.TAA11516@clem.digital.net>
Subject: 2.5.51 compile fails (fs/readdir.c)
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Tue, 10 Dec 2002 19:11:22 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:


  gcc -Wp,-MD,fs/.readdir.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=readdir -DKBUILD_MODNAME=readdir   -c -o fs/readdir.o fs/readdir.c
fs/readdir.c: In function `filldir64':
fs/readdir.c:242: internal error--unrecognizable insn:
(insn 187 186 448 (set (reg/v:SI 4 %esi)
        (asm_operands/v ("1:	movl %%eax,0(%2)
2:	movl %%edx,4(%2)
3:
.section .fixup,"ax"
4:	movl %3,%0
	jmp 3b
.previous
.section __ex_table,"a"
	.align 4
	.long 1b,4b
	.long 2b,4b
.previous") ("=r") 0[ 
                (reg:DI 1 %edx)
                (reg:SI 0 %eax)
                (const_int -14 [0xfffffff2])
                (reg/v:SI 4 %esi)
            ] 
            [ 
                (asm_input:DI ("A"))
                (asm_input:SI ("r"))
                (asm_input:SI ("i"))
                (asm_input:SI ("0"))
            ]  ("fs/readdir.c") 226)) -1 (insn_list 184 (insn_list 186 (nil)))
    (nil))
make[1]: *** [fs/readdir.o] Error 1
make: *** [fs] Error 2

-- 
Pete Clements 
clem@clem.digital.net
