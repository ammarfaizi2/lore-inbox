Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVGFFXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVGFFXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVGFFUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:20:45 -0400
Received: from fsmlabs.com ([168.103.115.128]:59806 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261534AbVGFDam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:30:42 -0400
Date: Tue, 5 Jul 2005 21:35:10 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nigel Cunningham <nigel@suspend2.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, shaohua.li@intel.com
Subject: Re: [PATCH] [11/48] Suspend2 2.1.9.8 for 2.6.12: 401-e820-table-support.patch
In-Reply-To: <11206164403490@foobar.com>
Message-ID: <Pine.LNX.4.61.0507052131140.2149@montezuma.fsmlabs.com>
References: <11206164403490@foobar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Nigel Cunningham wrote:

> diff -ruNp 402-mtrr-remove-sysdev.patch-old/arch/i386/kernel/cpu/mtrr/main.c 402-mtrr-remove-sysdev.patch-new/arch/i386/kernel/cpu/mtrr/main.c
> --- 402-mtrr-remove-sysdev.patch-old/arch/i386/kernel/cpu/mtrr/main.c	2005-06-20 11:46:42.000000000 +1000
> +++ 402-mtrr-remove-sysdev.patch-new/arch/i386/kernel/cpu/mtrr/main.c	2005-07-04 23:14:19.000000000 +1000
> @@ -166,7 +166,6 @@ static void ipi_handler(void *info)
>  	atomic_dec(&data->count);
>  	local_irq_restore(flags);
>  }
> -
>  #endif
>  
>  /**
> @@ -560,7 +559,7 @@ struct mtrr_value {
>  
>  static struct mtrr_value * mtrr_state;
>  
> -static int mtrr_save(struct sys_device * sysdev, u32 state)
> +int mtrr_save(void)
>  {
>  	int i;
>  	int size = num_var_ranges * sizeof(struct mtrr_value);
> @@ -580,28 +579,27 @@ static int mtrr_save(struct sys_device *
>  	return 0;
>  }

Isn't this covered by Shaohua Li's patch?
