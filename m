Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbVKQEGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbVKQEGk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 23:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbVKQEGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 23:06:40 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:18086 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161133AbVKQEGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 23:06:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WVpkdynQxlskDe159r9h0ejMAHE9kjZTjt3dWdo9ouc/B3gW5UuH4hFX3zpix8eqxBJTpKQCsXyOGDNjm+DxkDuwLVWbINlerNxD09r2Xmi+le8F6YSaGJfG7kZHjoC6gvns5dbOgckkAVqY5pP0+waHzATB2korDZx2DGyEyXc=
Message-ID: <437C4FAD.9090202@gmail.com>
Date: Thu, 17 Nov 2005 09:38:53 +0000
From: "venkata jagadish.p" <cpvjagadeesh@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john cooper <john.cooper@timesys.com>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: RT patched kernel debugging
References: <437B5FD3.7020404@gmail.com> <437B36DA.7090404@timesys.com>
In-Reply-To: <437B36DA.7090404@timesys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john cooper wrote:

> venkata jagadish.p wrote:
>
>> Hi all,
>> I am trying to debug the RT patched kernel with UML. But it is 
>> showing these errors
>> My kernel version is 2.6.13 and applied patch-2.6.13-rt14 to this kernel
>>
>>
>> gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
>> -fno-common -ffreestanding -O2 -fno-omit-frame-pointer 
>> -fno-optimize-sibling-calls -g -D__arch_um__ -DSUBARCH=\"i386\" 
>> -Iarch/um/include -I/usr/src/linux-2.6.13/arch/um/kernel/tt/include 
>> -I/usr/src/linux-2.6.13/arch/um/kernel/skas/include 
>> -Dvmap=kernel_vmap -Derrno=kernel_errno 
>> -Dsigprocmask=kernel_sigprocmask -fno-unit-at-a-time -U__i386__ 
>> -Ui386 -D_LARGEFILE64_SOURCE -Wdeclaration-after-statement 
>> -Wno-pointer-sign -nostdinc -isystem 
>> /usr/lib/gcc/i386-redhat-linux/4.0.0/include -D__KERNEL__ -Iinclude 
>> -S -o arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
>> In file included from arch/um/sys-i386/kernel-offsets.c:3:
>> include/linux/sched.h: In function ‘set_tsk_need_resched_delayed’:
>> include/linux/sched.h:1465: error: ‘TIF_NEED_RESCHED_DELAYED’ 
>> undeclared (first use in this function)
>
>
> That's odd.  Did the patch apply cleanly?
> TIF_NEED_RESCHED_DELAYED should be defined in
> include/asm-i386/thread_info.h for an i386
> target.
>
>
Patch was applied properly, for an i386 target it was compiled with out 
any errors, and it is working properly.
 When i try to complile the rt patch applied kernel
i didnot found TIF_NEED_RESCHED_DELAYED in include/asm-um/thread_info.h
Is there any separate patch required for debugging rtpatched kernel with 
UML.

regards,
Venka ta jagadish.p

