Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271579AbRH0B5S>; Sun, 26 Aug 2001 21:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271592AbRH0B5J>; Sun, 26 Aug 2001 21:57:09 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:31494 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271579AbRH0B5D>; Sun, 26 Aug 2001 21:57:03 -0400
Subject: Updated Linux kernel preemption patches
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: nigel@nrg.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 26 Aug 2001 21:57:43 -0400
Message-Id: <998877465.801.19.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at:

http://tech9.net/rml/linux/patch-rml-2.4.9-preempt-kernel-1
http://tech9.net/rml/linux/patch-rml-2.4.8-ac12-preempt-kernel-1

for kernel 2.4.9 and 2.4.8-ac12, respectively.

This is a straight update of Nigel Gamble's Linux kernel preemption
patch from http://kpreempt.sourceforge.net, updated for the above
kernels.  Thus, this is Nigel's code -- I merely updated it.

I am eager to see work done on the patch and to see what its future may
be.  If you are in any way interested in application latency or
real-time support, I suggest you check this out.  If you are just
curious, its an interesting patch none-the-less.

Some benchmarks:

kernel 2.4.8-ac12 (nonpreempt):
dbench 16:
Throughput 12.9453 MB/sec (NB=16.1816 MB/sec  129.453 MBit/sec)
dbench 1:
Throughput 76.0099 MB/sec (NB=95.0123 MB/sec  760.099 MBit/sec)
kernel compile (make dep clean bzImage):
7:35.51 (386.34s user, 23.41s system)

kernel 2.4.8-ac12 with preemptible kernel patch:
dbench 16:
Throughput 13.3579 MB/sec (NB=16.6974 MB/sec  133.579 MBit/sec)
dbench 1:
Throughput 31.4971 MB/sec (NB=39.3714 MB/sec  314.971 MBit/sec)
kernel compile (make dep clean bzImage):
7:23.26 (387.10s user, 23.42s system)

The performance increase in kernel compile and dbench 16 is decent, but
the decrease in dbench 1 is odd.  I am curious what numbers others find.
My "how does it feel" benchmark is that bandwidth seems similar while
multitasking may be a tad smoother with the patch.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

