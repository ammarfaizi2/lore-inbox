Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUCQTYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 14:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUCQTYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 14:24:08 -0500
Received: from fe4-cox.cox-internet.com ([66.76.2.49]:61323 "EHLO
	fe4.cox-internet.com") by vger.kernel.org with ESMTP
	id S261978AbUCQTYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 14:24:03 -0500
Message-ID: <4058A57B.4040006@cox-internet.com>
Date: Wed, 17 Mar 2004 13:22:35 -0600
From: billy rose <billyrose@cox-internet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gcc error?
Content-Type: multipart/mixed;
 boundary="------------010205040205070608010305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010205040205070608010305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

is the 40+ parameter sprintf() in proc_pid_stat() flushing out a bug in 
gcc on this? ive tried setting the cpu type to 386, 486, and 586 but 
still get the same error.

gcc -v shows 2.96.20000731
redhat 7.3
running kernel 2.4.18-3 or 2.4.20
kernel being compiled is 2.6.4

=====
Billy


--------------010205040205070608010305
Content-Type: text/plain;
 name="output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="output.txt"

fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 1334 1666 1660 (parallel[ 
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
        ] ) -1 (insn_list 1328 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2

--------------010205040205070608010305--

