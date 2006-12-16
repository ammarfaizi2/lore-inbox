Return-Path: <linux-kernel-owner+w=401wt.eu-S1030602AbWLPCeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030602AbWLPCeD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 21:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030604AbWLPCeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 21:34:03 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:54061 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030602AbWLPCeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 21:34:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:organization:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:x-mimeole:thread-index;
        b=U6XWFvc1ejGu8KoW2w3jQ4NB6zmhE98HsaNm9kA0v1UeRIQfy7o8n+bPDfJvrkIVgNSP7FTqHJdYMLP5YC33nxc0WmdXZFa4W2WWBmOODTMZ1jheZSFeow3/ofH57s5+nogBSXEjkFr9+d/nrIpDM8jrPAuhErL12X+NLVF9q7M=
From: "Bryan Wu" <cooloney.lkml@gmail.com>
To: <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Merge Blackfin-uClinux tree with latest Linus GIT tree including "LOG2.H" patch failed
Date: Sat, 16 Dec 2006 10:33:56 +0800
Organization: Analog Devices, Inc.
Message-ID: <003b01c720ba$a6a251d0$1502400a@BWUL01>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AccfnzWN7ALuEUJNQ/27BkWxdwPdNgBGwtkg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear David and Forks:

I am a developer of Blackfin uClinux (blackfin.uclinux.org). After git clone
the latest Linus GIT tree and quilt the blackfin-uclinux patch list, I met
some problems related with your log2.h patches when I try to compile the
kernel. The compile log is listed as below:

======================================================
$ make
scripts/kconfig/conf -s arch/blackfin/Kconfig
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC      arch/blackfin/kernel/asm-offsets.s
In file included from include/asm-generic/page.h:7,
                 from include/asm/page.h:84,
                 from include/asm/user.h:10,
                 from include/asm/bfin-global.h:38,
                 from include/asm/blackfin.h:12,
                 from include/asm/system.h:240,
                 from include/asm/bitops.h:10,
                 from include/linux/bitops.h:9,
                 from include/linux/thread_info.h:20,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:46,
                 from arch/blackfin/kernel/asm-offsets.c:33:
include/linux/log2.h: In function '__ilog2_u32':
include/linux/log2.h:34: warning: implicit declaration of function 'fls'
include/linux/log2.h: In function '__ilog2_u64':
include/linux/log2.h:42: warning: implicit declaration of function 'fls64'
include/linux/log2.h: In function '__roundup_pow_of_two':
include/linux/log2.h:52: warning: implicit declaration of function
'fls_long'
In file included from include/asm/bitops.h:210,
                 from include/linux/bitops.h:9,
                 from include/linux/thread_info.h:20,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:46,
                 from arch/blackfin/kernel/asm-offsets.c:33:
include/asm-generic/bitops/fls.h: At top level:
include/asm-generic/bitops/fls.h:13: error: static declaration of 'fls'
follows non-static declaration
include/linux/log2.h:34: error: previous implicit declaration of 'fls' was
here
In file included from include/asm/bitops.h:211,
                 from include/linux/bitops.h:9,
                 from include/linux/thread_info.h:20,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:46,
                 from arch/blackfin/kernel/asm-offsets.c:33:
include/asm-generic/bitops/fls64.h:7: error: static declaration of 'fls64'
follows non-static declaration
include/linux/log2.h:42: error: previous implicit declaration of 'fls64' was
here
In file included from include/linux/thread_info.h:20,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:46,
                 from arch/blackfin/kernel/asm-offsets.c:33:
include/linux/bitops.h:57: error: conflicting types for 'fls_long'
include/linux/log2.h:52: error: previous implicit declaration of 'fls_long'
was here
make[1]: *** [arch/blackfin/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
=============================================================

Could you please point me some hint with this?
Thanks a lot
Regards
-Bryan Wu




