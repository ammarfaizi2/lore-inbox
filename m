Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWAFWgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWAFWgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWAFWgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:36:39 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15856 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750952AbWAFWgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:36:38 -0500
Date: Fri, 6 Jan 2006 15:36:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org, akpm@osdl.org
Subject: Re: [PATCH] ppc32: Re-add embed_config.c to ml300/ep405
Message-ID: <20060106223635.GQ27215@smtp.west.cox.net>
References: <87y81vvdgf.fsf@48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y81vvdgf.fsf@48ers.dk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 11:24:32PM +0100, Peter Korsgaard wrote:

> Hi,
> 
> Commit 3e9e7c1d0b7a36fb8affb973a054c5098e27baa8 (ppc32: cleanup AMCC
> PPC40x eval boards to support U-Boot) broke the kernel for ML300 /
> EP405.
> 
> It still compiles as there's a weak definition of the function in
> misc-embedded.c, but the kernel crashes as the bd_t fixup isn't
> performed.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

I've seen this from others as well,
Acked-by: Tom Rini <trini@kernel.crashing.org>

... and this should goto stable@ once in Linus' tree.

> diff -urpN linux-2.6.15.orig/arch/ppc/boot/simple/Makefile linux-2.6.15/arch/ppc/boot/simple/Makefile
> --- linux-2.6.15.orig/arch/ppc/boot/simple/Makefile	2006-01-03 12:04:08.000000000 +0100
> +++ linux-2.6.15/arch/ppc/boot/simple/Makefile	2006-01-04 15:08:46.000000000 +0100
> @@ -190,6 +190,8 @@ boot-$(CONFIG_REDWOOD_5)	+= embed_config
>  boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
>  boot-$(CONFIG_8xx)		+= embed_config.o
>  boot-$(CONFIG_8260)		+= embed_config.o
> +boot-$(CONFIG_EP405)		+= embed_config.o
> +boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
>  boot-$(CONFIG_BSEIP)		+= iic.o
>  boot-$(CONFIG_MBX)		+= iic.o pci.o qspan_pci.o
>  boot-$(CONFIG_MV64X60)		+= misc-mv64x60.o

-- 
Tom Rini
http://gate.crashing.org/~trini/
