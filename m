Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993028AbWJUNss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993028AbWJUNss (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 09:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993031AbWJUNss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 09:48:48 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:6573 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S2993028AbWJUNsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 09:48:47 -0400
Subject: Re: [PATCH 2/7] KVM: Intel virtual mode extensions definitions
From: Steven Rostedt <rostedt@goodmis.org>
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4537823C.6030700@qumranet.com>
References: <4537818D.4060204@qumranet.com>  <4537823C.6030700@qumranet.com>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 09:48:41 -0400
Message-Id: <1161438521.16868.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 15:48 +0200, Avi Kivity wrote:
> Add some constants for the various bits defined by Intel's VT extensions.
> 
> Most of this file was lifted from the Xen hypervisor.
> 
> Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
> Signed-off-by: Avi Kivity <avi@qumranet.com>
> 
> Index: linux-2.6/drivers/kvm/vmx.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6/drivers/kvm/vmx.h
> @@ -0,0 +1,287 @@

This entire file is also very specific to an architecture. Couldn't it
be put somewhere in arch/x86_64 and not in drivers?

I know that this is all currently focused on Intel and AMD
virtualization platforms, but could you split out the x86_64 specific
stuff and make the rest more generic. Perhaps in the future this will
make it easier for other platforms to use this code as well.

It's hard to do a generic approach when developing it new, but if you
don't think about that now, it will be magnitudes larger in difficulty
to make generic when this is all done.

-- Steve



> purpose register */
> +#define LMSW_SOURCE_DATA_SHIFT 16
> +#define LMSW_SOURCE_DATA  (0xFFFF << LMSW_SOURCE_DATA_SHIFT) /* 16:31
> lmsw source */
> +#define REG_EAX                         (0 << 8)
> +#define REG_ECX                         (1 << 8)
> +#define REG_EDX                         (2 << 8)
> +#define REG_EBX                         (3 << 8)
> +#define REG_ESP                         (4 << 8)
> +#define REG_EBP                         (5 << 8)
> +#define REG_ESI                         (6 << 8)
> +#define REG_EDI                         (7 << 8)
> +#define REG_R8                         (8 << 8)
> +#define REG_R9                         (9 << 8)
> +#define REG_R10                        (10 << 8)
> +#define REG_R11                        (11 << 8)
> +#define REG_R12                        (12 << 8)
> +#define REG_R13                        (13 << 8)
> +#define REG_R14                        (14 << 8)
> +#define REG_R15                        (15 << 8)
> +


