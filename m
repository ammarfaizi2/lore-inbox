Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVB1LEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVB1LEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 06:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVB1LEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 06:04:48 -0500
Received: from web53605.mail.yahoo.com ([206.190.37.38]:37276 "HELO
	web53605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261271AbVB1LEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 06:04:39 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=lDHkrww/NdazF1EhsOeSda7CTcseyEtYyXRy2p0PcmmGiqDqRxd+UWMp4yUR6NXb02ObAitnGp5M2hZeeufjH12PMfY53A6RLr2ZB4czYDSzsmhTq6C42H83lnpKG/gmbu0Jp8bQXYVt++7L/+GCuC7/O9EyVDnTVj507UOgJdI=  ;
Message-ID: <20050228110439.86144.qmail@web53605.mail.yahoo.com>
Date: Mon, 28 Feb 2005 03:04:39 -0800 (PST)
From: Donald Duckie <schipperke2000@yahoo.com>
Subject: ethertap.c compilation problem
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried cross-compiling ethertap.c with
linux-sh-2.4.18, but can not successfully make it.

TOPDIR was set as /usr/src/linux-sh-2.4.18
CROSS_COMPILE   =sh4-linux-
CC              = $(CROSS_COMPILE)gcc

the compilation errors are:
--------------------------------------------------
[aphrodite@aphrodite2 net]$ pwd
/usr/src/linux-sh-2.4.18/drivers/net
[aphrodite@aphrodite2 net]$ make
make all_targets
make[1]: Entering directory
`/usr/src/linux-sh-2.4.18/drivers/net'
cc   -DKBUILD_BASENAME=auto_irq  -c -o auto_irq.o
auto_irq.c
In file included from /usr/include/asm/atomic.h:17,
                 from /usr/include/linux/module.h:25,
                 from auto_irq.c:33:
/usr/include/asm/system.h: In function `tas':
/usr/include/asm/system.h:81: unknown register name
`t' in `asm'
In file included from /usr/include/linux/sched.h:14,
                 from auto_irq.c:34:
/usr/include/linux/timex.h: At top level:
/usr/include/linux/timex.h:173: field `time' has
incomplete type
In file included from /usr/include/linux/sched.h:82,
                 from auto_irq.c:34:
/usr/include/linux/timer.h:17: field `list' has
incomplete type
auto_irq.c: In function `autoirq_report':
auto_irq.c:51: `jiffies' undeclared (first use in this
function)
auto_irq.c:51: (Each undeclared identifier is reported
only once
auto_irq.c:51: for each function it appears in.)
auto_irq.c: At top level:
auto_irq.c:56: syntax error before
"this_object_must_be_defined_as_export_objs_in_the_Makefile"
auto_irq.c:56: warning: data definition has no type or
storage class
auto_irq.c:57: syntax error before
"this_object_must_be_defined_as_export_objs_in_the_Makefile"
auto_irq.c:57: warning: data definition has no type or
storage class
make[1]: *** [auto_irq.o] Error 1
make[1]: Leaving directory
`/usr/src/linux-sh-2.4.18/drivers/net'
make: *** [first_rule] Error 2
--------------------------------------------------

what could be the possible problem in here?

basing on this compile log, i am expecting that: 
(for example)
/usr/include/asm/system.h
to be
/usr/src/linux-sh-2.4.18/include/asm/system.h

I know that there is no need to touch the Makefiles,
Rules.make for this, but I also tried replacing all
$(TOPDIR) to /usr/src/linux-sh-2.4.18.
The result was still the same.

I already ran make dep, make clean, and still got the
same result.

And also to my surprise, 
/usr/src/linux -> linux-sh-2.4.18
/usr/src/linux-sh-2.4.18
doing a : 
cd linux
would result to:
/usr/src/linux   instead of   /usr/src/linux-sh-2.4.18
has anyone experienced this?
if so, can this be explained as to why this is the
result?

hoping for some insights on how to proceed with my
compilation problem.


thank you.
donald


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250
