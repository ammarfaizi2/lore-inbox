Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030584AbWF0BUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbWF0BUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 21:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030588AbWF0BUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 21:20:31 -0400
Received: from xenotime.net ([66.160.160.81]:56460 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030584AbWF0BU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 21:20:29 -0400
Date: Mon, 26 Jun 2006 18:22:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 du jour on SPARC64: Build failure
Message-Id: <20060626182205.ba9392d2.rdunlap@xenotime.net>
In-Reply-To: <200606270041.k5R0fZqd008665@laptop11.inf.utfsm.cl>
References: <200606270041.k5R0fZqd008665@laptop11.inf.utfsm.cl>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 20:41:35 -0400 Horst von Brand wrote:

>   CC      arch/sparc64/kernel/devices.o
> In file included from include/linux/dma-mapping.h:27,
>                  from include/asm/sbus.h:10,
>                  from include/asm/dma.h:14,
>                  from include/linux/bootmem.h:8,
>                  from arch/sparc64/kernel/devices.c:15:
> include/asm/dma-mapping.h: In function `dma_sync_single_range_for_cpu':
> include/asm/dma-mapping.h:186: warning: implicit declaration of function `dma_sy
> nc_single_for_cpu'
> include/asm/dma-mapping.h: In function `dma_sync_single_range_for_device':
> include/asm/dma-mapping.h:195: warning: implicit declaration of function `dma_sy
> nc_single_for_device'
> make[1]: *** [arch/sparc64/kernel/devices.o] Error 1
> make: *** [arch/sparc64/kernel] Error 2
> 
> Configuration is attached.

CONFIG_PCI is not set.  That's the build problem, although
I don't see which file #includes it.
The bad news is that when CONFIG_PCI=n, those functions just do
	BUG();
anyway, so it won't help you much.

~Randy
