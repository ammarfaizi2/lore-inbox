Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTJNTFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTJNTFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:05:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:5603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262901AbTJNTE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:04:59 -0400
Date: Tue, 14 Oct 2003 12:13:46 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: linux-kernel@vger.kernel.org
Subject: fs/proc/array.c Compile Error
Message-ID: <Pine.LNX.4.44.0310141204150.28049-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As of this morning, I'm getting a neat compile error in fs/proc/array.c: 

fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:392: Unrecognizable insn:
(insn/i 711 995 989 (parallel[
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
        ] ) -1 (insn_list 705 (nil))
    (nil))
fs/proc/array.c:392: confused by earlier errors, bailing out


The GCC version I'm using is 

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)

Any ideas? 

Thanks,


	Pat


