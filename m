Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWHGWbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWHGWbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWHGWbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:31:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50877 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932263AbWHGWbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:31:50 -0400
Date: Mon, 7 Aug 2006 15:31:44 -0700
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial: Consolidate HPET_TIMER Makefile entries
Message-ID: <20060807223144.GA14812@kroah.com>
References: <20060807210030.GA1391@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807210030.GA1391@plexity.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 02:00:30PM -0700, Deepak Saxena wrote:
> 
> Signed-off-by: Deepak Saxena <dsaxena@mvista.com>
> 
> 
> diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
> index ab98fc2..085b9fa 100644
> --- a/arch/i386/kernel/Makefile
> +++ b/arch/i386/kernel/Makefile
> @@ -32,12 +32,11 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
>  obj-$(CONFIG_MODULES)		+= module.o
>  obj-y				+= sysenter.o vsyscall.o
>  obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
> -obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
>  obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
>  obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault.o
>  obj-$(CONFIG_VM86)		+= vm86.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
> -obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
> +obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o hpet.o
>  obj-$(CONFIG_K8_NB)		+= k8.o
>  obj-$(CONFIG_AUDIT)		+= audit.o

Is this necessary for 2.6.18-final?  Are you sure that we don't need
this for link order issues?

Care to use the trivial tree for this?

thanks,

greg k-h
