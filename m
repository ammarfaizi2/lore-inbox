Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276763AbRJKTo1>; Thu, 11 Oct 2001 15:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276764AbRJKToX>; Thu, 11 Oct 2001 15:44:23 -0400
Received: from zok.sgi.com ([204.94.215.101]:22699 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S276763AbRJKTnt>;
	Thu, 11 Oct 2001 15:43:49 -0400
Message-ID: <XFMail.20011011143922.jkp@riker.nailed.org>
X-Mailer: XFMail 1.5.0 on IRIX
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Thu, 11 Oct 2001 14:39:22 -0500 (CDT)
Organization: SGI, Inc.
From: jkp@riker.nailed.org
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-ac12 compile error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just downloaded the -ac12 patch to 2.4.10 and applied it over 2.4.10.
The patch applied fine (no rejects).

Compile produces this:

-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i586    -DEXPORT_SYMTAB -c serial.c
In file included from serial.c:172:
/usr/src/linux-2.4.10-ac12/include/linux/serialP.h:27:25: operator '(' has no
left operand
serial.c:192:25: operator '(' has no left operand
serial.c:195:25: operator '(' has no left operand
serial.c:216:51: operator '(' has no left operand
serial.c:668:25: operator '(' has no left operand
serial.c: In function `receive_chars':
serial.c:671: warning: implicit declaration of function `queue_task_irq_off'
serial.c:1423:25: operator '(' has no left operand
serial.c:1572:25: operator '(' has no left operand
serial.c:2148:25: operator '(' has no left operand
serial.c: In function `rs_write':
serial.c:1867: warning: implicit declaration of function `copy_from_user'
serial.c:2195:25: operator '(' has no left operand
serial.c:2372:25: operator '(' has no left operand
serial.c: In function `get_serial_info':
serial.c:2065: warning: implicit declaration of function `copy_to_user'
serial.c:2529:25: operator '(' has no left operand
serial.c:2544:25: operator '(' has no left operand
serial.c:3156:25: operator '(' has no left operand
serial.c:3822:25: operator '(' has no left operand
serial.c:3827:32: linux/symtab_begin.h: No such file or directory
serial.c:3830:30: linux/symtab_end.h: No such file or directory
serial.c: At top level:
serial.c:3826: variable `serial_syms' has initializer but incomplete type
serial.c:3828: warning: implicit declaration of function `X'
serial.c:3828: warning: excess elements in struct initializer
serial.c:3828: warning: (near initialization for `serial_syms')
serial.c:3829: warning: excess elements in struct initializer
serial.c:3829: warning: (near initialization for `serial_syms')
serial.c:5380:25: operator '(' has no left operand
serial.c:5383:25: operator '(' has no left operand
serial.c:5418:25: operator '(' has no left operand
serial.c:5421:25: operator '(' has no left operand
serial.c:5432:25: operator '(' has no left operand
serial.c:5439:25: operator '(' has no left operand
serial.c:2389: warning: `rs_break' defined but not used
serial.c:3826: warning: `serial_syms' defined but not used
make[3]: *** [serial.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.10-ac12/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.10-ac12/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.10-ac12/drivers'
make: *** [_dir_drivers] Error 2

All the lines above include the macro LINUX_VERSION_CODE which appears
to be undefined. About 50 other files compiled fine.

Thanks.

-- 
----------------------------------
Jens Petersohn       x33128
