Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277731AbRJWPMW>; Tue, 23 Oct 2001 11:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277733AbRJWPMQ>; Tue, 23 Oct 2001 11:12:16 -0400
Received: from relay-1v.club-internet.fr ([194.158.96.112]:48849 "HELO
	relay-1v.club-internet.fr") by vger.kernel.org with SMTP
	id <S277731AbRJWPL4>; Tue, 23 Oct 2001 11:11:56 -0400
Message-ID: <3BD588F5.7020301@freesurf.fr>
Date: Tue, 23 Oct 2001 17:12:53 +0200
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011022
X-Accept-Language: fr, en, fr-fr
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: Fail to compile 2.4.13-pre6 (with ext3fs) with gcc-3.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.4.13-pre6/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon     -c -o 8139too.o 8139too.c
8139too.c: In function `netdev_ethtool_ioctl':
8139too.c:2432: Unrecognizable insn:
(insn/i 618 1061 1058 (parallel[
             (set (reg:SI 6 ebp)
                 (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; 
sbbl $0,%0") ("=&r") 0[
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
                     ] 
("/usr/src/linux-2.4.13-pre6/include/asm/uaccess.h") 558))
             (set (reg/v:SI 1 edx [165])
                 (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; 
sbbl $0,%0") ("=r") 1[
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
                     ] 
("/usr/src/linux-2.4.13-pre6/include/asm/uaccess.h") 558))
             (clobber (reg:QI 19 dirflag))
             (clobber (reg:QI 18 fpsr))
             (clobber (reg:QI 17 flags))
         ] ) -1 (insn_list 604 (insn_list 611 (nil)))
     (nil))
8139too.c:2432: Internal compiler error in reload_cse_simplify_operands, 
at reload1.c:8355

I don't really know if it's a gcc or kernel problem. If I'm in the wrong 
list, please accept my apologizes.

-- 
  ** Gael Le Mignot, Ing3 EPITA, Coder of The Kilobug Team **
Home Mail : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM       : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Web       : http://kilobug.freesurf.fr or http://drizzt.dyndns.org

"Software is like sex it's better when it's free.", Linus Torvalds

