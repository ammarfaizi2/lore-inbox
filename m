Return-Path: <linux-kernel-owner+w=401wt.eu-S967195AbWLIKZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967195AbWLIKZM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 05:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967671AbWLIKZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 05:25:12 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:57788 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967195AbWLIKZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 05:25:10 -0500
Message-ID: <457A8F04.40308@vmware.com>
Date: Sat, 09 Dec 2006 02:25:08 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org,
       akpm <akpm@osdl.org>, chrisw@sous-sol.org, rusty@rustcorp.com.au,
       jeremy@goop.org
Subject: Re: [PATCH] no paravirt for X86_VOYAGER or X86_VISWS
References: <20061209015131.fc19aeb3.randy.dunlap@oracle.com>
In-Reply-To: <20061209015131.fc19aeb3.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Since Voyager and Visual WS already define ARCH_SETUP,
> it looks like PARAVIRT shouldn't be offered for them.
>
> In file included from arch/i386/kernel/setup.c:63:
> include/asm-i386/mach-visws/setup_arch.h:8:1: warning: "ARCH_SETUP" redefined
> In file included from include/asm/msr.h:5,
>                  from include/asm/processor.h:17,
>                  from include/asm/thread_info.h:16,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:46,
>                  from arch/i386/kernel/setup.c:26:
> include/asm/paravirt.h:163:1: warning: this is the location of the previous definition
> In file included from arch/i386/kernel/setup.c:63:
> include/asm-i386/mach-visws/setup_arch.h:8:1: warning: "ARCH_SETUP" redefined
> In file included from include/asm/msr.h:5,
>                  from include/asm/processor.h:17,
>                  from include/asm/thread_info.h:16,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:46,
>                  from arch/i386/kernel/setup.c:26:
> include/asm/paravirt.h:163:1: warning: this is the location of the previous definition
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  arch/i386/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-2.6.19-git13.orig/arch/i386/Kconfig
> +++ linux-2.6.19-git13/arch/i386/Kconfig
> @@ -190,6 +190,7 @@ endchoice
>  config PARAVIRT
>  	bool "Paravirtualization support (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL
> +	depends on !(X86_VISWS || X86_VOYAGER)
>  	help
>  	  Paravirtualization is a way of running multiple instances of
>  	  Linux on the same machine, under a hypervisor.  This option
>
>
> ---
>
>   
Acked-by: Zachary Amsden <zach@vmware.com>
