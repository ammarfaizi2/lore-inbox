Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWJVIOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWJVIOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWJVIOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:14:39 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:14220 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S932212AbWJVIOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:14:39 -0400
Message-ID: <453B2863.4060106@qumranet.com>
Date: Sun, 22 Oct 2006 10:14:27 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com>  <453781F9.3050703@qumranet.com> <1161437829.16868.9.camel@localhost.localdomain>
In-Reply-To: <1161437829.16868.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 08:14:38.0741 (UTC) FILETIME=[1E443C50:01C6F5B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
>> +
>> +/* for KVM_GET_REGS and KVM_SET_REGS */
>> +struct kvm_regs {
>> +    /* in */
>> +    __u32 vcpu;
>> +    __u32 padding;
>> +
>> +    /* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
>> +    __u64 rax, rbx, rcx, rdx;
>> +    __u64 rsi, rdi, rsp, rbp;
>> +    __u64 r8,  r9,  r10, r11;
>> +    __u64 r12, r13, r14, r15;
>> +    __u64 rip, rflags;
>> +};
>> +
>>     
>
> I know this is for userspace too, but still. Shouldn't this be in
> include/asm-x86_64 and not include/linux.
>   

Most of this file is arch-independent and could be used for other 
virtualization-capable architectures.  I could this snippet to 
asm-x86_64 but where would it leave i386?

(i386 needs access to 64-bit registers since we support 64-bit guests on 
a 64-bit host with a 32-bit userspace)

-- 
error compiling committee.c: too many arguments to function

