Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVKPNs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVKPNs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVKPNs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:48:28 -0500
Received: from mail.timesys.com ([65.117.135.102]:45752 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1030329AbVKPNs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:48:28 -0500
Message-ID: <437B36DA.7090404@timesys.com>
Date: Wed, 16 Nov 2005 08:40:42 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "venkata jagadish.p" <cpvjagadeesh@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT patched kernel debugging
References: <437B5FD3.7020404@gmail.com>
In-Reply-To: <437B5FD3.7020404@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Nov 2005 13:42:55.0906 (UTC) FILETIME=[A63E1820:01C5EAB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

venkata jagadish.p wrote:
> Hi all,
> I am trying to debug the RT patched kernel with UML. But it is showing 
> these errors
> My kernel version is 2.6.13 and applied patch-2.6.13-rt14 to this kernel
> 
> 
> gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
> -fno-common -ffreestanding -O2 -fno-omit-frame-pointer 
> -fno-optimize-sibling-calls -g -D__arch_um__ -DSUBARCH=\"i386\" 
> -Iarch/um/include -I/usr/src/linux-2.6.13/arch/um/kernel/tt/include 
> -I/usr/src/linux-2.6.13/arch/um/kernel/skas/include -Dvmap=kernel_vmap 
> -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask 
> -fno-unit-at-a-time -U__i386__ -Ui386 -D_LARGEFILE64_SOURCE 
> -Wdeclaration-after-statement -Wno-pointer-sign -nostdinc -isystem 
> /usr/lib/gcc/i386-redhat-linux/4.0.0/include -D__KERNEL__ -Iinclude -S 
> -o arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
> In file included from arch/um/sys-i386/kernel-offsets.c:3:
> include/linux/sched.h: In function ‘set_tsk_need_resched_delayed’:
> include/linux/sched.h:1465: error: ‘TIF_NEED_RESCHED_DELAYED’ undeclared 
> (first use in this function)

That's odd.  Did the patch apply cleanly?
TIF_NEED_RESCHED_DELAYED should be defined in
include/asm-i386/thread_info.h for an i386
target.

-john

-- 
john.cooper@timesys.com
