Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbTIAGbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 02:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTIAGbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 02:31:18 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32387
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262641AbTIAGbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 02:31:17 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Unnecessary objects built in 2.6.0-test4?
Date: Mon, 1 Sep 2003 02:31:39 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309010231.39329.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.0-test4 on my laptop, and it's quite nice.  (Haven't beaten 
also into submission yet, and it won't suspend, and kde is dropping some 
events, but everything else is chugging along quite nicely...)

But the kernel is huge, an I'm curious why.  So I did this in the build 
directory:

find . -name "*.o" | xargs ls -l | less

And the results are interesting.

For example: I have a coppermine celeron in this laptop, and I told the build 
that, and I did NOT select generic x86 optimizations, so why did it build 
objects with names like amd, centaur, and cyrix, winchip, k7...?

-rw-r--r--    1 root     root         3348 Sep  1 01:24 
./arch/i386/kernel/cpu/amd.o
-rw-r--r--    1 root     root        55962 Sep  1 01:24 
./arch/i386/kernel/cpu/built-in.o
-rw-r--r--    1 root     root         2572 Sep  1 01:24 
./arch/i386/kernel/cpu/centaur.o
-rw-r--r--    1 root     root         7908 Sep  1 01:24 
./arch/i386/kernel/cpu/common.o
-rw-r--r--    1 root     root         5664 Sep  1 01:24 
./arch/i386/kernel/cpu/cyrix.o
-rw-r--r--    1 root     root         4820 Sep  1 01:24 
./arch/i386/kernel/cpu/intel.o
-rw-r--r--    1 root     root         7957 Sep  1 01:24 
./arch/i386/kernel/cpu/mcheck/built-in.o
-rw-r--r--    1 root     root         2212 Sep  1 01:24 
./arch/i386/kernel/cpu/mcheck/k7.o
-rw-r--r--    1 root     root         2184 Sep  1 01:24 
./arch/i386/kernel/cpu/mcheck/mce.o
-rw-r--r--    1 root     root         2952 Sep  1 01:24 
./arch/i386/kernel/cpu/mcheck/p4.o
-rw-r--r--    1 root     root         1600 Sep  1 01:24 
./arch/i386/kernel/cpu/mcheck/p5.o
-rw-r--r--    1 root     root         2312 Sep  1 01:24 
./arch/i386/kernel/cpu/mcheck/p6.o
-rw-r--r--    1 root     root         1264 Sep  1 01:24 
./arch/i386/kernel/cpu/mcheck/winchip.o
-rw-r--r--    1 root     root         1452 Sep  1 01:24 
./arch/i386/kernel/cpu/mtrr/amd.o
-rw-r--r--    1 root     root        23991 Sep  1 01:24 
./arch/i386/kernel/cpu/mtrr/built-in.o
-rw-r--r--    1 root     root         3084 Sep  1 01:24 
./arch/i386/kernel/cpu/mtrr/centaur.o
-rw-r--r--    1 root     root         3776 Sep  1 01:24 
./arch/i386/kernel/cpu/mtrr/cyrix.o

Rob
