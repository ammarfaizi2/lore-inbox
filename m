Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284248AbRLPFkF>; Sun, 16 Dec 2001 00:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284253AbRLPFjz>; Sun, 16 Dec 2001 00:39:55 -0500
Received: from sphere.open-net.org ([64.53.98.77]:3300 "HELO open-net.org")
	by vger.kernel.org with SMTP id <S284248AbRLPFjr>;
	Sun, 16 Dec 2001 00:39:47 -0500
Date: Sun, 16 Dec 2001 00:33:56 -0500
From: Robert Jameson <rj@open-net.org>
To: linux-kernel@vger.kernel.org
Subject: 8139too fails to compile
Message-Id: <20011216003356.5abcc2ac.rj@open-net.org>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; @host_alias@)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I was trying to compile 2.4.17-rc1 with no luck, It looks like a GCC error.



---

Gcc:
(root@pbx)(/usr/src/linux) -> gcc -v
Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/3.0.2/specs
Configured with: ../gcc-3.0.2/configure --prefix=/usr --enable-shared --with-gnu-ld --enable-threads --verbose --target=i386-slackware-linux --host=i386-slackware-linux
Thread model: posix
gcc version 3.0.2
(root@pbx)(/usr/src/linux) -> 

Error:

8139too.c:2295: Unrecognizable insn:
(insn/i 612 1054 1051 (parallel[ 
            (set (reg:SI 6 ebp)
                (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0") ("=&r") 0[ 
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
                    ]  ("/usr/src/linux/include/asm/uaccess.h") 558))
            (set (reg/v:SI 1 edx [166])
                (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0") ("=r") 1[ 
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
                    ]  ("/usr/src/linux/include/asm/uaccess.h") 558))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 598 (insn_list 605 (nil)))
    (nil))
8139too.c:2295: Internal compiler error in reload_cse_simplify_operands, at reload1.c:8364
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
make[3]: *** [8139too.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2


-- 

I'm praying for rain and I'm praying for tidal waves I wanna see the ground give way. 
I wanna watch it all go down - tool.
