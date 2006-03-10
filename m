Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752157AbWCJB1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbWCJB1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCJB1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:27:08 -0500
Received: from xenotime.net ([66.160.160.81]:23484 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932706AbWCJB1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:27:07 -0500
Date: Thu, 9 Mar 2006 17:28:54 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kevin Winchester <kwin@ns.sympatico.ca>
Cc: akpm@osdl.org, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm3] x86-64: Eliminate register_die_notifier symbol
 exported twice
Message-Id: <20060309172854.ae8eeec9.rdunlap@xenotime.net>
In-Reply-To: <4410BDFB.3070401@ns.sympatico.ca>
References: <4410BDFB.3070401@ns.sympatico.ca>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2006 19:44:59 -0400 Kevin Winchester wrote:

> 
> register_die_notifier is exported twice, once in traps.c and once in 
> x8664_ksyms.c.  This results in a warning on build.
> 
> Signed-Off-By: Kevin Winchester <kwin@ns.sympatico.ca>
> 
> --- v2.6.16-rc5-mm3.orig/arch/x86_64/kernel/x8664_ksyms.c       
> 2006-03-09 19:34:11.000000000 -0400
> +++ v2.6.16-rc5-mm3/arch/x86_64/kernel/x8664_ksyms.c    2006-03-09 
> 19:40:46.000000000 -0400
> @@ -142,7 +142,6 @@ EXPORT_SYMBOL(rwsem_down_write_failed_th
>  EXPORT_SYMBOL(empty_zero_page);
> 
>  EXPORT_SYMBOL(die_chain);
> -EXPORT_SYMBOL(register_die_notifier);
> 
>  #ifdef CONFIG_SMP
>  EXPORT_SYMBOL(cpu_sibling_map);

Thanks for that.  However, I see 2 such warnings:

WARNING: vmlinux: 'register_die_notifier' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strlen' exported twice. Previous export was in vmlinux


---
~Randy
Please use an email client that implements proper (compliant) threading.
(You know who you are.)
