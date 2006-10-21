Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993011AbWJUNhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993011AbWJUNhT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 09:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993014AbWJUNhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 09:37:19 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:62678 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S2993011AbWJUNhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 09:37:17 -0400
Subject: Re: [PATCH 1/7] KVM: userspace interface
From: Steven Rostedt <rostedt@goodmis.org>
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <453781F9.3050703@qumranet.com>
References: <4537818D.4060204@qumranet.com>  <453781F9.3050703@qumranet.com>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 09:37:09 -0400
Message-Id: <1161437829.16868.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 15:47 +0200, Avi Kivity wrote:
> This patch defines a bunch of ioctl()s on /dev/kvm.  The ioctl()s allow
> adding
> memory to a virtual machine, adding a virtual cpu to a virtual machine (at
> most one at this time), transferring control to the virtual cpu, and
> querying
> about guest pages changed by the virtual machine.
> 
> Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
> Signed-off-by: Avi Kivity <avi@qumranet.com>
> 
> Index: linux-2.6/include/linux/kvm.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6/include/linux/kvm.h

[...]

> +
> +/* for KVM_GET_REGS and KVM_SET_REGS */
> +struct kvm_regs {
> +    /* in */
> +    __u32 vcpu;
> +    __u32 padding;
> +
> +    /* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
> +    __u64 rax, rbx, rcx, rdx;
> +    __u64 rsi, rdi, rsp, rbp;
> +    __u64 r8,  r9,  r10, r11;
> +    __u64 r12, r13, r14, r15;
> +    __u64 rip, rflags;
> +};
> +

I know this is for userspace too, but still. Shouldn't this be in
include/asm-x86_64 and not include/linux.

-- Steve


