Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWHPPjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWHPPjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWHPPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:39:39 -0400
Received: from hera.kernel.org ([140.211.167.34]:15803 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932077AbWHPPji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:39:38 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH for review] [102/145] x86_64: Remove unneeded externs in acpi/boot.c
Date: Wed, 16 Aug 2006 11:41:17 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193700.33E4413C16@wotan.suse.de>
In-Reply-To: <20060810193700.33E4413C16@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161141.17600.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 15:37, Andi Kleen wrote:

> And move one into proto.h
> 
> Cc: len.brown@intel.com

Acked-by: Len Brown <len.brown@intel.com>

> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/i386/kernel/acpi/boot.c |    3 ---
>  include/asm-x86_64/proto.h   |    2 ++
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> Index: linux/arch/i386/kernel/acpi/boot.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/acpi/boot.c
> +++ linux/arch/i386/kernel/acpi/boot.c
> @@ -47,9 +47,6 @@ EXPORT_SYMBOL(acpi_disabled);
>  
>  #ifdef	CONFIG_X86_64
>  
> -extern void __init clustered_apic_check(void);
> -
> -extern int gsi_irq_sharing(int gsi);
>  #include <asm/proto.h>
>  
>  static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id) { return 0; }
> Index: linux/include/asm-x86_64/proto.h
> ===================================================================
> --- linux.orig/include/asm-x86_64/proto.h
> +++ linux/include/asm-x86_64/proto.h
> @@ -124,6 +124,8 @@ extern int fix_aperture;
>  extern int reboot_force;
>  extern int notsc_setup(char *);
>  
> +extern int gsi_irq_sharing(int gsi);
> +
>  extern void smp_local_timer_interrupt(struct pt_regs * regs);
>  
>  long do_arch_prctl(struct task_struct *task, int code, unsigned long addr);
