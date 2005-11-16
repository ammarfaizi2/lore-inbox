Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVKPLC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVKPLC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 06:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbVKPLC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 06:02:27 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:5927 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030273AbVKPLC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 06:02:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=XkECpCHkgsjzLuZNzLHcHHBRoc3t++05rCXWPAwLsVo49VNiMu8NG5Eea1ydKMx02V6sqKhY6UsYupq1RDwyYkQD8nDfpQXyS+vah0cWhanBJ6hlQIgZARvGi8O5TwRyP5UrWB83RnhYTS33IJYU64TvjWDcVHwIxpR8zqLySIg=
Message-ID: <437B5FD3.7020404@gmail.com>
Date: Wed, 16 Nov 2005 16:35:31 +0000
From: "venkata jagadish.p" <cpvjagadeesh@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: RT patched kernel debugging 
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am trying to debug the RT patched kernel with UML. But it is showing 
these errors
My kernel version is 2.6.13 and applied patch-2.6.13-rt14 to this kernel


gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -ffreestanding -O2 -fno-omit-frame-pointer 
-fno-optimize-sibling-calls -g -D__arch_um__ -DSUBARCH=\"i386\" 
-Iarch/um/include -I/usr/src/linux-2.6.13/arch/um/kernel/tt/include 
-I/usr/src/linux-2.6.13/arch/um/kernel/skas/include -Dvmap=kernel_vmap 
-Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask 
-fno-unit-at-a-time -U__i386__ -Ui386 -D_LARGEFILE64_SOURCE 
-Wdeclaration-after-statement -Wno-pointer-sign -nostdinc -isystem 
/usr/lib/gcc/i386-redhat-linux/4.0.0/include -D__KERNEL__ -Iinclude -S 
-o arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
In file included from arch/um/sys-i386/kernel-offsets.c:3:
include/linux/sched.h: In function ‘set_tsk_need_resched_delayed’:
include/linux/sched.h:1465: error: ‘TIF_NEED_RESCHED_DELAYED’ undeclared 
(first use in this function)
include/linux/sched.h:1465: error: (Each undeclared identifier is 
reported only once
include/linux/sched.h:1465: error: for each function it appears in.)
include/linux/sched.h: In function ‘clear_tsk_need_resched_delayed’:
include/linux/sched.h:1470: error: ‘TIF_NEED_RESCHED_DELAYED’ undeclared 
(first use in this function)
include/linux/sched.h: In function ‘need_resched_delayed’:
include/linux/sched.h:1475: error: ‘TIF_NEED_RESCHED_DELAYED’ undeclared 
(first use in this function)
make: *** [arch/um/kernel-offsets.s] Error 1


