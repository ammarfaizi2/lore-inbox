Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbTHUA1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 20:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTHUA1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 20:27:40 -0400
Received: from [66.212.224.118] ([66.212.224.118]:61708 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S262274AbTHUA1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 20:27:39 -0400
Date: Wed, 20 Aug 2003 20:27:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix ioapic build breakage
In-Reply-To: <20030820221755.GA20633@gtf.org>
Message-ID: <Pine.LNX.4.53.0308202026030.17457@montezuma.mastecende.com>
References: <20030820221755.GA20633@gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003, Jeff Garzik wrote:

> 
> 
> ===== arch/i386/kernel/setup.c 1.92 vs edited =====
> --- 1.92/arch/i386/kernel/setup.c	Tue Aug 19 16:01:09 2003
> +++ edited/arch/i386/kernel/setup.c	Wed Aug 20 18:15:34 2003
> @@ -543,11 +543,13 @@
>  			if (!acpi_force) acpi_disabled = 1;
>  		}
>  
> +#ifdef CONFIG_X86_LOCAL_APIC
>  		/* disable IO-APIC */
>  		else if (!memcmp(from, "noapic", 6)) {
>  			skip_ioapic_setup = 1;
>  		}
> -#endif
> +#endif /* CONFIG_X86_LOCAL_APIC */
> +#endif /* CONFIG_ACPI_BOOT */

Shouldn't that be CONFIG_X86_IO_APIC ?
