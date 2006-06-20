Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWFTOVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWFTOVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWFTOVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:21:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18351 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751065AbWFTOVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:21:16 -0400
Date: Tue, 20 Jun 2006 16:20:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Matthew Wilcox <matthew@wil.cx>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unify CONFIG_LBD and CONFIG_LSF handling
In-Reply-To: <20060619221618.GJ1630@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0606201616430.17704@scrub.home>
References: <20060619221618.GJ1630@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Jun 2006, Matthew Wilcox wrote:

> Index: ./block/Kconfig
> ===================================================================
> RCS file: /var/cvs/linux-2.6/block/Kconfig,v
> retrieving revision 1.4
> diff -u -p -r1.4 Kconfig
> --- ./block/Kconfig	3 Apr 2006 13:44:01 -0000	1.4
> +++ ./block/Kconfig	19 Apr 2006 13:43:26 -0000
> @@ -1,11 +1,9 @@
>  #
>  # Block layer core configuration
>  #
> -#XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
> -#for instance.
>  config LBD
>  	bool "Support for Large Block Devices"
> -	depends on X86 || (MIPS && 32BIT) || PPC32 || (S390 && !64BIT) || SUPERH || UML
> +	depends on !64BIT
>  	help
>  	  Say Y here if you want to attach large (bigger than 2TB) discs to
>  	  your machine, or if you want to have a raid or loopback device
> @@ -26,7 +24,7 @@ config BLK_DEV_IO_TRACE
>  
>  config LSF
>  	bool "Support for Large Single Files"
> -	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
> +	depends on !64BIT
>  	help
>  	  Say Y here if you want to be able to handle very large files (bigger
>  	  than 2TB), otherwise say N.

While you're at it, could you please take care of bug #6719 and fix the 
LSF help text?
Thanks.

bye, Roman
