Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbTKXT3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTKXT3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:29:53 -0500
Received: from netlx014.civ.utwente.nl ([130.89.1.88]:5195 "EHLO
	netlx014.civ.utwente.nl") by vger.kernel.org with ESMTP
	id S263827AbTKXT3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:29:50 -0500
Date: Mon, 24 Nov 2003 20:29:33 +0100 (CET)
From: mp3project@sarijopen.student.utwente.nl
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test10 : compile error in /fs/proc/array.c
Message-ID: <Pine.LNX.4.44.0311242014030.8867-100000@sarijopen.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
X-UTwente-MailScanner-SpamScore: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ave people

My redhat 7.3 compiler (gcc 2.96--113) is still complaining about that 
file.

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      fs/proc/array.o
fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 1332 1663 1657 (parallel[ 
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 1326 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2


It's a known error and various patches are floating around on lkml.

Is this
a)a post 2.6.0 item
b)a case of fix the compiler,we ain't gonna work around.

Patching the source is not difficult to do,but it would be nice if 
vanilla 2.6.0 is gonna compile cleanly without patching on redhat 7.3 

Greetz Mu
 

