Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269423AbTHKSei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272824AbTHKSdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:33:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52740 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S272875AbTHKScB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:32:01 -0400
Date: Mon, 11 Aug 2003 20:31:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: davej@redhat.com
cc: torvalds@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sort the cache shift options.
In-Reply-To: <E19mFqr-00068f-00@tetrachloride>
Message-ID: <Pine.LNX.4.44.0308112030240.24676-100000@serv>
References: <E19mFqr-00068f-00@tetrachloride>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 11 Aug 2003 davej@redhat.com wrote:

> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/Kconfig linux-2.5/arch/i386/Kconfig
> --- bk-linus/arch/i386/Kconfig	2003-08-06 16:39:02.000000000 +0100
> +++ linux-2.5/arch/i386/Kconfig	2003-08-08 00:38:44.000000000 +0100
> @@ -322,10 +322,10 @@ config X86_XADD
>  
>  config X86_L1_CACHE_SHIFT
>  	int
> -	default "7" if MPENTIUM4 || X86_GENERIC
>  	default "4" if MELAN || M486 || M386
>  	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
>  	default "6" if MK7 || MK8
> +	default "7" if MPENTIUM4 || X86_GENERIC
>  
>  config RWSEM_GENERIC_SPINLOCK
>  	bool

The order does matter, in this case we want to override the cpu selection 
with X86_GENERIC.

bye, Roman

