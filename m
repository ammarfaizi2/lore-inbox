Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbUL0QUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbUL0QUD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 11:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUL0QUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 11:20:03 -0500
Received: from adsl-64-109-89-108.dsl.chcgil.ameritech.net ([64.109.89.108]:32129
	"EHLO redscar") by vger.kernel.org with ESMTP id S261923AbUL0QT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 11:19:58 -0500
Subject: Re: [2.6 patch] i386: reboot.c cleanups
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, pazke@donpac.ru,
       linux-visws-devel@lists.sf.net
In-Reply-To: <20041206004127.GH2953@stusta.de>
References: <20041206004127.GH2953@stusta.de>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 10:19:55 -0600
Message-Id: <1104164395.5295.24.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 01:41 +0100, Adrian Bunk wrote:
> The partch below includes the following changes:
> - arch/i386/kernel/reboot.c: make reboot_thru_bios static
> - arch/i386/mach-visws/reboot.c: remove the unused reboot_thru_bios and
>                                  reboot_smp
> - arch/i386/mach-voyager/voyager_basic.c: remove the unused reboot_thru_bios
> - arch/i386/mach-voyager/voyager_smp.c: remove the unused reboot_smp

The description and the patch below don't match.  Do you have the
correct patch?

James


> --- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/process.c.old	2004-12-06 01:25:27.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/process.c	2004-12-06 01:25:38.000000000 +0100
> @@ -60,7 +60,7 @@
>  
>  asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
>  
> -int hlt_counter;
> +static int hlt_counter;
>  
>  unsigned long boot_option_idle_override = 0;
>  EXPORT_SYMBOL(boot_option_idle_override);
> --- linux-2.6.10-rc2-mm4-full/arch/parisc/kernel/process.c.old	2004-12-06 01:25:55.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/arch/parisc/kernel/process.c	2004-12-06 01:26:01.000000000 +0100
> @@ -54,7 +54,7 @@
>  #include <asm/uaccess.h>
>  #include <asm/unwind.h>
>  
> -int hlt_counter;
> +static int hlt_counter;
>  
>  /*
>   * Power off function, if any
> --- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/process.c.old	2004-12-06 01:26:17.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/process.c	2004-12-06 01:26:28.000000000 +0100
> @@ -53,7 +53,7 @@
>  
>  unsigned long kernel_thread_flags = CLONE_VM | CLONE_UNTRACED;
>  
> -atomic_t hlt_counter = ATOMIC_INIT(0);
> +static atomic_t hlt_counter = ATOMIC_INIT(0);
>  
>  unsigned long boot_option_idle_override = 0;
>  EXPORT_SYMBOL(boot_option_idle_override);

