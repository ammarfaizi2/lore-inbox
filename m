Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbTJTKXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 06:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTJTKXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 06:23:08 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:11245 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262501AbTJTKXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 06:23:05 -0400
Message-ID: <0c1101c396f4$00bfeaf0$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: RH7.3 can't compile 2.6.0-test8
Date: Mon, 20 Oct 2003 19:21:51 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand that Red Hat's GCC is nonstandard, but this still surprised me.
In the "make" output below, the word エラー means error.


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
make[2]: *** [fs/proc/array.o] エラー 1
make[1]: *** [fs/proc] エラー 2
make: *** [fs] エラー 2
[ndiamond@c1pc40 linux-2.6.0-test8]$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)
[ndiamond@c1pc40 linux-2.6.0-test8]$ rpm -qa binutils
binutils-2.11.93.0.2-11

