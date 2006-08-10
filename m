Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWHJVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWHJVJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWHJVJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:09:46 -0400
Received: from xenotime.net ([66.160.160.81]:36058 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750828AbWHJVJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:09:45 -0400
Date: Thu, 10 Aug 2006 14:12:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for review] [120/145] i386/x86-64: Improve Kconfig
 description of CRASH_DUMP
Message-Id: <20060810141227.baa7c1c4.rdunlap@xenotime.net>
In-Reply-To: <20060810193719.52AE513B8E@wotan.suse.de>
References: <20060810 935.775038000@suse.de>
	<20060810193719.52AE513B8E@wotan.suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 21:37:19 +0200 (CEST) Andi Kleen wrote:

> r
> 
> Improve Kconfig description of CONFIG_CRASH_DUMP. Previously
> it was too brief to be useful.
> 
> Cc: vgoyal@in.ibm.com
> Cc: ebiederm@xmission.com
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/i386/Kconfig   |    7 +++++++
>  arch/x86_64/Kconfig |    9 ++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> Index: linux/arch/i386/Kconfig
> ===================================================================
> --- linux.orig/arch/i386/Kconfig
> +++ linux/arch/i386/Kconfig
> @@ -759,6 +759,13 @@ config CRASH_DUMP
>  	depends on HIGHMEM
>  	help
>  	  Generate crash dump after being started by kexec.
> +          This should be normally only set in special crash dump kernels
> +	  which are loaded in the main kernel with kexec-tools into
> +	  a specially reserved region and then later executed after
> +	  a crash by kdump/kexec. The crash dump kernel must be compiled
> +          to a memory address not used by the main kernel or BIOS using
> +          PHYSICAL_START.
> +	  For more details see Documentation/kdump/kdump.txt
>  
>  config PHYSICAL_START
>  	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
> Index: linux/arch/x86_64/Kconfig
> ===================================================================
> --- linux.orig/arch/x86_64/Kconfig
> +++ linux/arch/x86_64/Kconfig
> @@ -484,7 +484,14 @@ config CRASH_DUMP
>  	bool "kernel crash dumps (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL
>  	help
> -		Generate crash dump after being started by kexec.
> +          Generate crash dump after being started by kexec.
> +          This should be normally only set in special crash dump kernels
> +          which are loaded in the main kernel with kexec-tools into
> +          a specially reserved region and then later executed after
> +          a crash by kdump/kexec. The crash dump kernel must be compiled
> +	  to a memory address not used by the main kernel or BIOS using
> +	  PHYSICAL_START.
> +          For more details see Documentation/kdump/kdump.txt
>  
>  config PHYSICAL_START
>  	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
> -

Please fix indentation (use tabs consistently).

---
~Randy
