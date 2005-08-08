Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVHHMiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVHHMiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 08:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVHHMiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 08:38:23 -0400
Received: from wormhole-tele2.se.axis.com ([193.13.178.170]:12003 "EHLO
	wormhole.se.axis.com") by vger.kernel.org with ESMTP
	id S1750847AbVHHMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 08:38:23 -0400
Message-ID: <1123504568.42f751b890ba2@webmail-unix.se.axis.com>
Date: Mon,  8 Aug 2005 14:36:08 +0200
From: starvik@axis.com
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, dev-etrax@axis.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] arch/cris/Kconfig.debug: use lib/Kconfig.debug
References: <20050807220005.GC4006@stusta.de>
In-Reply-To: <20050807220005.GC4006@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 212.181.50.183
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Mikael Starvik <starvik@axis.com>

> This patch converts arch/cris/Kconfig.debug to using lib/Kconfig.debug.
> 
> This should fix a compile error in 2.6.13-rc4 caused by a missing 
> CONFIG_LOG_BUF_SHIFT definition.
> 
> While I was editing this file, I also converted some spaces to tabs.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 31 Jul 2005
> 
>  arch/cris/Kconfig.debug |   31 ++++++++++---------------------
>  1 files changed, 10 insertions(+), 21 deletions(-)
> 
> --- linux-2.6.13-rc4-mm1/arch/cris/Kconfig.debug.old	2005-07-31
> 18:29:15.000000000 +0200
> +++ linux-2.6.13-rc4-mm1/arch/cris/Kconfig.debug	2005-07-31
> 18:32:15.000000000 +0200
> @@ -5,10 +5,13 @@
>  	bool "Kernel profiling support"
>  
>  config SYSTEM_PROFILER
> -        bool "System profiling support"
> +	bool "System profiling support"
> +
> +source "lib/Kconfig.debug"
>  
>  config ETRAX_KGDB
>  	bool "Use kernel GDB debugger"
> +	depends on DEBUG_KERNEL
>  	---help---
>  	  The CRIS version of gdb can be used to remotely debug a running
>  	  Linux kernel via the serial debug port.  Provided you have gdb-cris
> @@ -22,25 +25,11 @@
>  	  this option is turned on!
>  
>  
> -config DEBUG_INFO
> -        bool "Compile the kernel with debug info"
> -        help
> -          If you say Y here the resulting kernel image will include
> -          debugging info resulting in a larger kernel image.
> -          Say Y here only if you plan to use gdb to debug the kernel.
> -          If you don't debug the kernel, you can say N.
> -
> -config FRAME_POINTER
> -        bool "Compile the kernel with frame pointers"
> -        help
> -          If you say Y here the resulting kernel image will be slightly
> larger
> -          and slower, but it will give very useful debugging information.
> -          If you don't debug the kernel, you can say N, but we may not be
> able
> -          to solve problems without frame pointers.
> -
>  config DEBUG_NMI_OOPS
> -       bool "NMI causes oops printout"
> -       help
> -         If the system locks up without any debug information you can say Y
> -         here to make it possible to dump an OOPS with an external NMI.
> +	bool "NMI causes oops printout"
> +	depends on DEBUG_KERNEL
> +	help
> +	  If the system locks up without any debug information you can say Y
> +	  here to make it possible to dump an OOPS with an external NMI.
> +
>  endmenu
> 




-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
