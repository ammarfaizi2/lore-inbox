Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTIVEsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 00:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTIVEsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 00:48:24 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:33951 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262772AbTIVEsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 00:48:22 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5-bk8 breaks VMWare build
Date: Mon, 22 Sep 2003 00:48:21 -0400
User-Agent: KMail/1.5.4
References: <20030917050950.GC1376@Master> <20030922024058.GA1348@Master> <3F6E7A8A.8010604@cyberone.com.au>
In-Reply-To: <3F6E7A8A.8010604@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309220048.22043.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this should be considered a VMWare or a kernel problem.  This works fine under 2.6.0-test3-bk8, so a header that VMWare depends on has changed.  The 
`__set_64bit_var': warning does occur in test3-bk8, but the module safely compiles.

None of VMware Workstation's pre-built vmmon modules is suitable for your
running kernel.  Do you want this program to try to build the vmmon module for
your system (you need to have a C compiler installed on your system)? [yes]

Using compiler "/usr/bin/gcc". Use environment variable CC to override.

What is the location of the directory of C header files that match your running
kernel? [/lib/modules/2.6.0-test5-bk8/build/include]

Extracting the sources of the vmmon module.

Building the vmmon module.

make: Entering directory `/tmp/vmware-config0/vmmon-only'
make[1]: Entering directory `/tmp/vmware-config0/vmmon-only'
make[2]: Entering directory `/tmp/vmware-config0/vmmon-only/driver-2.6.0-test5-bk8'
make[2]: Leaving directory `/tmp/vmware-config0/vmmon-only/driver-2.6.0-test5-bk8'
make[2]: Entering directory `/tmp/vmware-config0/vmmon-only/driver-2.6.0-test5-bk8'
In file included from /lib/modules/2.6.0-test5-bk8/build/include/asm/processor.h:18,
                 from /lib/modules/2.6.0-test5-bk8/build/include/asm/thread_info.h:13,
                 from /lib/modules/2.6.0-test5-bk8/build/include/linux/thread_info.h:21,
                 from /lib/modules/2.6.0-test5-bk8/build/include/linux/spinlock.h:12,
                 from /lib/modules/2.6.0-test5-bk8/build/include/linux/capability.h:45,
                 from /lib/modules/2.6.0-test5-bk8/build/include/linux/sched.h:7,
                 from /lib/modules/2.6.0-test5-bk8/build/include/linux/module.h:10,
                 from ../linux/driver.c:16:
/lib/modules/2.6.0-test5-bk8/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.6.0-test5-bk8/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.6.0-test5-bk8/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
../linux/driver.c: In function `init_module':
../linux/driver.c:246: error: structure has no member named `prev'
../linux/driver.c:247: error: structure has no member named `next'
../include/vm_asm.h: In function `Div643264':
../include/vm_asm.h:1095: warning: use of memory input without lvalue in asm operand 4 is deprecated
make[2]: *** [driver.o] Error 1
make[2]: Leaving directory `/tmp/vmware-config0/vmmon-only/driver-2.6.0-test5-bk8'
make[1]: *** [driver] Error 2
make[1]: Leaving directory `/tmp/vmware-config0/vmmon-only'
make: *** [auto-build] Error 2
make: Leaving directory `/tmp/vmware-config0/vmmon-only'
Unable to build the vmmon module.

For more information on how to troubleshoot module-related problems, please
visit our Web site at "http://www.vmware.com/download/modules/modules.html" and
"http://www.vmware.com/support/reference/linux/prebuilt_modules_linux.html".

Execution aborted.


