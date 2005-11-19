Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVKSGCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVKSGCD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 01:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVKSGCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 01:02:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750952AbVKSGCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 01:02:01 -0500
Date: Fri, 18 Nov 2005 22:01:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dell_rbu driver depends on x86[64]
Message-Id: <20051118220144.11671174.akpm@osdl.org>
In-Reply-To: <20051118212938.GB3881@redhat.com>
References: <20051118212938.GB3881@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> This driver only appears on IA32 & EM64T boxes.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.14/drivers/firmware/Kconfig~	2005-11-14 19:23:45.000000000 -0500
> +++ linux-2.6.14/drivers/firmware/Kconfig	2005-11-14 19:24:18.000000000 -0500
> @@ -60,6 +60,7 @@ config EFI_PCDP
>  
>  config DELL_RBU
>  	tristate "BIOS update support for DELL systems via sysfs"
> +	depends on X86
>  	select FW_LOADER
>  	help
>  	 Say m if you want to have the option of updating the BIOS for your

Does it not compile on other architectures?  If it does, there's an
argument for leaving it there, for compile coverage.
