Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423795AbWKHWKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423795AbWKHWKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423794AbWKHWKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:10:23 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:22439 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423795AbWKHWKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:10:21 -0500
Date: Wed, 8 Nov 2006 14:10:07 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gx-suspmod: fix "&& 0xff" typo
Message-Id: <20061108141007.e0adf333.randy.dunlap@oracle.com>
In-Reply-To: <20061108220435.GA4972@martell.zuzino.mipt.ru>
References: <20061108220435.GA4972@martell.zuzino.mipt.ru>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 01:04:35 +0300 Alexey Dobriyan wrote:

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/i386/kernel/cpu/cpufreq/gx-suspmod.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
> +++ b/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
> @@ -473,7 +473,7 @@ static int __init cpufreq_gx_init(void)
>  	pci_read_config_byte(params->cs55x0, PCI_MODON, &(params->on_duration));
>  	pci_read_config_byte(params->cs55x0, PCI_MODOFF, &(params->off_duration));
>          pci_read_config_dword(params->cs55x0, PCI_CLASS_REVISION, &class_rev);
> -	params->pci_rev = class_rev && 0xff;
> +	params->pci_rev = class_rev & 0xff;

Hi,
any kind of automated detection on that one?

thanks,
---
~Randy
