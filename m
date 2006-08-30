Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWH3ECe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWH3ECe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 00:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWH3ECe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 00:02:34 -0400
Received: from xenotime.net ([66.160.160.81]:43404 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751459AbWH3ECd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 00:02:33 -0400
Date: Tue, 29 Aug 2006 21:05:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH 2/7] BC: kconfig
Message-Id: <20060829210546.6e5b76f9.rdunlap@xenotime.net>
In-Reply-To: <44F45468.1080203@sw.ru>
References: <44F45045.70402@sw.ru>
	<44F45468.1080203@sw.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 18:51:20 +0400 Kirill Korotaev wrote:

> Add kernel/bc/Kconfig file with BC options and
> include it into arch Kconfigs
> 
> ---
>  init/Kconfig      |    2 ++
>  kernel/bc/Kconfig |   25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> --- ./init/Kconfig.bckm	2006-07-10 12:39:10.000000000 +0400
> +++ ./init/Kconfig	2006-07-28 14:10:41.000000000 +0400
> @@ -222,6 +222,8 @@ source "crypto/Kconfig"
>  
>  	  Say N if unsure.
>  
> +source "kernel/bc/Kconfig"
> +
>  config SYSCTL
>  	bool
>  
> --- ./kernel/bc/Kconfig.bckm	2006-07-28 13:07:38.000000000 +0400
> +++ ./kernel/bc/Kconfig	2006-07-28 13:09:51.000000000 +0400
> @@ -0,0 +1,25 @@
> +#
> +# Resource beancounters (BC)
> +#
> +# Copyright (C) 2006 OpenVZ. SWsoft Inc
> +
> +menu "User resources"
> +
> +config BEANCOUNTERS
> +	bool "Enable resource accounting/control"
> +	default n
> +	help 
> +          When Y this option provides accounting and allows to configure

"allows" needs an object after it, like "you" or "one".

> +          limits for user's consumption of exhaustible system resources.
> +          The most important resource controlled by this patch is unswappable 
> +          memory (either mlock'ed or used by internal kernel structures and 
> +          buffers). The main goal of this patch is to protect processes
> +          from running short of important resources because of an accidental

drop "an"

> +          misbehavior of processes or malicious activity aiming to ``kill'' 
> +          the system. It's worth to mention that resource limits configured 

s/to mention/mentioning/

> +          by setrlimit(2) do not give an acceptable level of protection 
> +          because they cover only small fraction of resources and work on a 

"only a small fraction"

> +          per-process basis.  Per-process accounting doesn't prevent malicious
> +          users from spawning a lot of resource-consuming processes.
> +
> +endmenu

and there are several lines that end with <space> (don't do that :).

---
~Randy
