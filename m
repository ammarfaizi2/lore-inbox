Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTJRFTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 01:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTJRFTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 01:19:01 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:42370 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S261342AbTJRFS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 01:18:58 -0400
Message-ID: <XFMail.20031018011826.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sat, 18 Oct 2003 01:18:26 -0400 (EDT)
From: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8: broken  /fs/proc/array.c  compilation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
the changes in 2.6.0-test8 break compilation
of /fs/proc/array.c with
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y




CC      fs/proc/array.o
fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 1332 1672 1666 (parallel[
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 37))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 37))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 1326 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2


No problem in 2.6.0-test7



