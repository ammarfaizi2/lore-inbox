Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSCRIte>; Mon, 18 Mar 2002 03:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312249AbSCRItP>; Mon, 18 Mar 2002 03:49:15 -0500
Received: from smtp01.iprimus.net.au ([203.134.64.99]:22532 "EHLO
	smtp01.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S312248AbSCRIs5>; Mon, 18 Mar 2002 03:48:57 -0500
Subject: kernel 2.4.17: CCIS Compaq Smart Array build problems.
From: Crispin Wellington <crispin@aeonline.net>
To: linux-kernel@vger.kernel.org, arrays@compaq.com,
        compaqandlinux@cpqlin.van-dijk.net
Cc: Undisclosed Recipients <crispin@aeonline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 18 Mar 2002 16:44:54 +0800
Message-Id: <1016441097.739.10.camel@water>
Mime-Version: 1.0
X-OriginalArrivalTime: 18 Mar 2002 08:46:19.0566 (UTC) FILETIME=[5FACDCE0:01C1CE59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apon trying to build a 2.4.17 series kernel with
CONFIG_BLK_CPQ_CISS_DA=y (Compaq Smart Array 53xx support) I get the
following build error...

gcc -D__KERNEL__ -I/bigfree/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i386    -c -o cciss.o cciss.c
cciss.c: In function `cciss_ioctl':
cciss.c:705: internal error--unrecognizable insn:
(insn 949 5224 958 (set (reg/v:SI 0 %eax)
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
                (reg:SI 3 %ebx)
                (const_int -14 [0xfffffff2])
                (reg/v:SI 0 %eax)
            ] 
            [ 
                (asm_input:DI ("A"))
                (asm_input:SI ("r"))
                (asm_input:SI ("i"))
                (asm_input:SI ("0"))
            ]  ("cciss.c") 406)) -1 (insn_list 864 (insn_list 948
(nil)))
    (nil))
cpp: output pipe has been closed
make[4]: *** [cciss.o] Error 1
make[4]: Leaving directory `/bigfree/linux/drivers/block'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/bigfree/linux/drivers/block'
make[2]: *** [_subdir_block] Error 2
make[2]: Leaving directory `/bigfree/linux/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory `/bigfree/linux'
make: *** [stamp-build] Error 2

more info...

gcc --version
2.95.2

ld -V
GNU ld version 2.9.5 (with BFD 2.9.5.0.37)
  Supported emulations:
   elf_i386
   i386linux

Any ideas? Is there any newer patch I could try? Please CC me as I'm not
subscribed.

Kind Regards
Crispin Wellington


