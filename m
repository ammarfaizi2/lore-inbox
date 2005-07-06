Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVGFKy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVGFKy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVGFKoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:44:54 -0400
Received: from fmr19.intel.com ([134.134.136.18]:51905 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262167AbVGFI15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:27:57 -0400
Subject: Re: [PATCH] [4/48] Suspend2 2.1.9.8 for 2.6.12:
	302-init-hooks.patch
From: Shaohua Li <shaohua.li@intel.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11206164392@foobar.com>
References: <11206164392@foobar.com>
Content-Type: text/plain
Date: Wed, 06 Jul 2005 16:38:45 +0800
Message-Id: <1120639125.2908.5.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 12:20 +1000, Nigel Cunningham wrote:
> diff -ruNp 350-workthreads.patch-old/drivers/acpi/osl.c 350-workthreads.patch-new/drivers/acpi/osl.c
> --- 350-workthreads.patch-old/drivers/acpi/osl.c	2005-06-20 11:46:50.000000000 +1000
> +++ 350-workthreads.patch-new/drivers/acpi/osl.c	2005-07-04 23:14:18.000000000 +1000
> @@ -95,7 +95,7 @@ acpi_os_initialize1(void)
>  		return AE_NULL_ENTRY;
>  	}
>  #endif
> -	kacpid_wq = create_singlethread_workqueue("kacpid");
> +	kacpid_wq = create_singlethread_workqueue("kacpid", PF_NOFREEZE);
>  	BUG_ON(!kacpid_wq);
I'm not sure but kacpid can run any kind of code (depends on BIOS, it
might touch some devices), is this safe?

Thanks,
Shaohua

