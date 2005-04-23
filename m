Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVDWBIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVDWBIc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 21:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVDWBIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 21:08:32 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55975 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261398AbVDWBI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 21:08:28 -0400
Date: Sat, 23 Apr 2005 03:05:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] correct the DEBUG_BUGVERBOSE question dependency
In-Reply-To: <20050423002513.GQ4355@stusta.de>
Message-ID: <Pine.LNX.4.61.0504230302400.863@scrub.home>
References: <20050423002513.GQ4355@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Apr 2005, Adrian Bunk wrote:

> Currently, DEBUG_BUGVERBOSE, is automatically set to "y" if 
> DEBUG_KERNEL=n and EMBEDDED=y which doesn't make much sense.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc2-mm3-full/lib/Kconfig.debug.old	2005-04-22 03:03:27.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/lib/Kconfig.debug	2005-04-22 03:04:00.000000000 +0200
> @@ -125,9 +125,9 @@
>  	  This options enables addition error checking for high memory systems.
>  	  Disable for production systems.
>  
>  config DEBUG_BUGVERBOSE
> -	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
> +	bool "Verbose BUG() reporting (adds 70K)" if EMBEDDED
>  	depends on BUG
>  	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || (X86 && !X86_64) || FRV
>  	default !EMBEDDED
>  	help

1. you just messed up the menu structure.
2. the default is "!EMBEDDED", so it should become "n"?!

bye, Roman
