Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRG2TzS>; Sun, 29 Jul 2001 15:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbRG2TzI>; Sun, 29 Jul 2001 15:55:08 -0400
Received: from [194.102.102.3] ([194.102.102.3]:14084 "EHLO ns1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S268133AbRG2Tyw>;
	Sun, 29 Jul 2001 15:54:52 -0400
Date: Sun, 29 Jul 2001 22:56:54 +0300 (EEST)
From: Stanciu Adrian <adi@Aniela.EU.ORG>
To: <linux-kernel@vger.kernel.org>
Subject: problem compiling some code
Message-ID: <Pine.LNX.4.33.0107292254270.757-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

PROBLEM: #include errors

Hello,

I'm trying to compile the following code:

// test.c begins here
    #include <linux/modversions.h>
    #include <linux/module.h>
    #include <linux/version.h>
    #include <linux/kernel.h>
    #include <linux/pci.h>
    #include <linux/delay.h>
    #include <asm/uaccess.h>

    void main(void)
    {
        // no further code needed
    }
// end of test.c

But I get the following errors and warning messages:


In file included from /usr/include/linux/sched.h:14,
                 from /usr/include/asm/uaccess.h:8,
                 from test.c:8:
/usr/include/linux/times.h:5: parse error before `clock_t'
/usr/include/linux/times.h:5: warning: no semicolon at end of struct or
union
/usr/include/linux/times.h:6: warning: data definition has no type or
storage class
/usr/include/linux/times.h:7: parse error before `tms_cutime'
/usr/include/linux/times.h:7: warning: data definition has no type or
storage class
/usr/include/linux/times.h:8: parse error before `tms_cstime'
/usr/include/linux/times.h:8: warning: data definition has no type or
storage class
In file included from /usr/include/linux/sched.h:15,
                 from /usr/include/asm/uaccess.h:8,
                 from test.c:8:
/usr/include/linux/timex.h:173: field `time' has incomplete type
In file included from /usr/include/linux/signal.h:4,
                 from /usr/include/linux/sched.h:26,
                 from /usr/include/asm/uaccess.h:8,
                 from test.c:8:
/usr/include/asm/signal.h:174: parse error before `size_t'
/usr/include/asm/signal.h:174: warning: no semicolon at end of struct or
union
/usr/include/asm/signal.h:175: warning: data definition has no type or
storage class
In file included from /usr/include/linux/signal.h:5,
                 from /usr/include/linux/sched.h:26,
                 from /usr/include/asm/uaccess.h:8,
                 from test.c:8:
/usr/include/asm/siginfo.h:26: parse error before `pid_t'
/usr/include/asm/siginfo.h:26: warning: no semicolon at end of struct or
union
/usr/include/asm/siginfo.h:26: warning: no semicolon at end of struct or
union
/usr/include/asm/siginfo.h:27: warning: no semicolon at end of struct or
union
/usr/include/asm/siginfo.h:28: warning: data definition has no type or
storage class
/usr/include/asm/siginfo.h:38: parse error before `pid_t'
/usr/include/asm/siginfo.h:38: warning: no semicolon at end of struct or
union
/usr/include/asm/siginfo.h:39: warning: data definition has no type or
storage class
/usr/include/asm/siginfo.h:41: parse error before `}'
/usr/include/asm/siginfo.h:41: warning: data definition has no type or
storage class
/usr/include/asm/siginfo.h:45: parse error before `pid_t'
/usr/include/asm/siginfo.h:45: warning: no semicolon at end of struct or
union
/usr/include/asm/siginfo.h:46: warning: data definition has no type or
storage class
/usr/include/asm/siginfo.h:48: parse error before `_utime'
/usr/include/asm/siginfo.h:48: warning: data definition has no type or
storage class
/usr/include/asm/siginfo.h:49: parse error before `_stime'
/usr/include/asm/siginfo.h:49: warning: data definition has no type or
storage class
/usr/include/asm/siginfo.h:50: warning: data definition has no type or
storage class
/usr/include/asm/siginfo.h:62: parse error before `}'
/usr/include/asm/siginfo.h:62: warning: data definition has no type or
storage class
/usr/include/asm/siginfo.h:63: parse error before `}'
/usr/include/asm/siginfo.h:63: warning: data definition has no type or
storage class
In file included from /usr/include/linux/sched.h:77,
                 from /usr/include/asm/uaccess.h:8,
                 from test.c:8:
/usr/include/linux/time.h:10: parse error before `time_t'
/usr/include/linux/time.h:10: warning: no semicolon at end of struct or
union
/usr/include/linux/time.h:12: parse error before `}'
/usr/include/linux/time.h:89: parse error before `time_t'
/usr/include/linux/time.h:89: warning: no semicolon at end of struct or
union
/usr/include/linux/time.h:90: warning: data definition has no type or
storage class
/usr/include/linux/time.h:122: field `it_interval' has incomplete type
/usr/include/linux/time.h:123: field `it_value' has incomplete type
/usr/include/linux/time.h:127: field `it_interval' has incomplete type
/usr/include/linux/time.h:128: field `it_value' has incomplete type
In file included from /usr/include/linux/sched.h:79,
                 from /usr/include/asm/uaccess.h:8,
                 from test.c:8:
/usr/include/linux/resource.h:22: field `ru_utime' has incomplete type
/usr/include/linux/resource.h:23: field `ru_stime' has incomplete type
In file included from /usr/include/linux/sched.h:80,
                 from /usr/include/asm/uaccess.h:8,
                 from test.c:8:
/usr/include/linux/timer.h:17: field `list' has incomplete type
/usr/include/linux/timer.h: In function `timer_pending':
/usr/include/linux/timer.h:53: warning: control reaches end of non-void
functionIn file included from test.c:8:
/usr/include/asm/uaccess.h: In function `verify_area':
/usr/include/asm/uaccess.h:63: dereferencing pointer to incomplete type
/usr/include/asm/uaccess.h:63: `EFAULT' undeclared (first use in this
function)
/usr/include/asm/uaccess.h:63: (Each undeclared identifier is reported
only once/usr/include/asm/uaccess.h:63: for each function it appears in.)
/usr/include/asm/uaccess.h: In function `__constant_copy_to_user':
/usr/include/asm/uaccess.h:529: dereferencing pointer to incomplete type
/usr/include/asm/uaccess.h: In function `__constant_copy_from_user':
/usr/include/asm/uaccess.h:537: dereferencing pointer to incomplete type
test.c: At top level:
test.c:10: warning: return type of `main' is not `int'

Basic debugging shows that the last #include directive gives me trouble
(removing it helps solving the problem), but i need copy_from_user(...)
from asm/uaccess.h.

I'm using the original code of the linux-2.4.7 kernel.

scripts/ver_linux reported:


    Gnu C                  2.95.3
    Gnu make               3.79.1
    binutils               2.11.90.0.19
    util-linux             2.11f
    mount                  2.11b
    modutils               2.4.6
    e2fsprogs              1.22
    reiserfsprogs          3.x.0j
    Linux C Library        2.2.3
    Dynamic linker (ldd)   2.2.3
    Procps                 2.0.7
    Net-tools              1.60
    Kbd                    1.06
    Sh-utils               2.0
    Modules Loaded         cmpci audiobuf opl3 uart401 pnp midi soundbase
                            sndshield nls_iso8859-1 nls_cp437

The program is compiled using: gcc -Wall test.c

10x


