Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129176AbRBIUmf>; Fri, 9 Feb 2001 15:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRBIUm0>; Fri, 9 Feb 2001 15:42:26 -0500
Received: from cust-795-150.customer.jump.net ([207.8.95.150]:55052 "EHLO
	dev.audiogalaxy.com") by vger.kernel.org with ESMTP
	id <S129176AbRBIUmQ>; Fri, 9 Feb 2001 15:42:16 -0500
Date: Fri, 9 Feb 2001 14:42:11 -0600 (CST)
From: Michael Merhej <michael@audiogalaxy.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.1ac3 vs 2.4.1ac8
Message-ID: <Pine.LNX.4.30.0102091411180.10189-100000@dev.audiogalaxy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basic Machine configuration:

SMP Supermicro board
2 gigabytes of ECC Registered ram
Adaptec AIC-7892
eepro100 onboard nic

The machine has been running as a database server with no MySQL crashes
for several months and has run fine with kernels 2.2.18 and 2.4.1ac3.

We have seen a HUGE improvement in the processing power and file
access from kernel 2.4.1ac3 to 2.4.1ac8, but MySQL crashes every few hours
with the following error on 2.4.1ac8:

mysqld version: 3.23.32

mysqld got signal 11;
The manual section 'Debugging a MySQL server' tells you how to use a
stack trace and/or the core file to produce a readable backtrace that may
help in finding out why mysqld died
Attemping backtrace. You can use the following information to find out
where mysqld died.  If you see no messages after this, something went
terribly wrong
Bogus stack limit or frame pointer, aborting backtrace


With 2.4.1.ac8 syslog has been spitting out the following errors:

Feb  8 23:12:38 db1 kernel: __alloc_pages: 0-order allocation failed.
Feb  8 23:34:54 db1 kernel: __alloc_pages: 2-order allocation failed.
Feb  8 23:34:54 db1 kernel: IP: queue_glue: no memory for gluing queue
ef1c1de0
Feb  8 23:34:55 db1 kernel: __alloc_pages: 2-order allocation failed.

Feb  8 23:34:55 db1 kernel: IP: queue_glue: no memory for gluing queue
ef1c1ee0
Feb  8 23:34:56 db1 kernel: __alloc_pages: 2-order allocation failed.
Feb  8 23:34:56 db1 kernel: IP: queue_glue: no memory for gluing queue
ef1c1160
Feb  8 23:34:59 db1 kernel: __alloc_pages: 2-order allocation failed.
Feb  8 23:34:59 db1 kernel: IP: queue_glue: no memory for gluing queue
ef1c11a0
Feb  8 23:35:05 db1 kernel: nfs: server toastem not responding, still
trying
Feb  8 23:35:05 db1 kernel: __alloc_pages: 2-order allocation failed.
Feb  8 23:35:05 db1 kernel: IP: queue_glue: no memory for gluing queue
c322e520
Feb  8 23:35:06 db1 kernel: __alloc_pages: 2-order allocation failed.
Feb  8 23:35:06 db1 kernel: IP: queue_glue: no memory for gluing queue
ef1c11a0
Feb  8 23:36:04 db1 kernel: __alloc_pages: 2-order allocation failed.
Feb  8 23:36:04 db1 kernel: IP: queue_glue: no memory for gluing queue
c322ea60
Feb  8 23:36:05 db1 kernel: __alloc_pages: 2-order allocation failed.
Feb  8 23:36:05 db1 kernel: IP: queue_glue: no memory for gluing queue
c322ea60
Feb  8 23:36:06 db1 kernel: __alloc_pages: 2-order allocation failed.
Feb  8 23:36:06 db1 kernel: IP: queue_glue: no memory for gluing queue
c322ea60

Feb  9 00:00:13 db1 kernel: __alloc_pages: 1-order allocation failed.
Feb  9 00:00:21 db1 last message repeated 269 times

Feb  9 00:15:13 db1 kernel: __alloc_pages: 1-order allocation failed.
Feb  9 00:15:19 db1 last message repeated 114 times

etc



We would love to stay with kernel 2.4.1ac8 because of the huge speed
increase.

Queries / Sec on this machine are from about 300 - 1700

If you need more information please email me.



Thanks



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
