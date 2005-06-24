Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263048AbVFXPrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbVFXPrC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbVFXPoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:44:39 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33259 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263058AbVFXPnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:43:19 -0400
Date: Fri, 24 Jun 2005 08:43:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, akpm@osdl.org,
       linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org,
       yshpilevsky@ru.mvista.com
Subject: Re: [PATCH] ppc32: add Freescale MPC885ADS board support
Message-ID: <20050624154311.GB3628@smtp.west.cox.net>
References: <42BAD78E.1020801@ru.mvista.com> <20050623140522.GA25724@logos.cnet> <42BC2501.5090101@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BC2501.5090101@ru.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 07:21:37PM +0400, Andrei Konovalov wrote:
> Hi Marcelo,
> 
> Marcelo Tosatti wrote:
> >Hi Andrei,
> >
> >On Thu, Jun 23, 2005 at 07:38:54PM +0400, Andrei Konovalov wrote:
> ><snip>
> >
> >>diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
> >>--- a/arch/ppc/syslib/m8xx_setup.c
> >>+++ b/arch/ppc/syslib/m8xx_setup.c
> >>@@ -369,7 +369,7 @@ m8xx_map_io(void)
> >>#if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || 
> >>defined(CONFIG_FB_RPX)
> >>	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, 
> >>	_PAGE_IO);
> >>#endif
> >>-#ifdef CONFIG_FADS
> >>+#if defined(CONFIG_FADS) || defined(CONFIG_MPC885ADS)
> >>	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
> >>#endif
> >>#ifdef CONFIG_PCI
> >
> >
> >I suppose you also want to include CONFIG_MPC885ADS in the 
> >io_block_mapping(IO_BASE) here?
> 
> No, not at the moment at least.
> Actually, the patch doesn't even #define IO_BASE.
> In 2.4 that io_block_mapping(IO_BASE) was needed for PCMCIA / CF cards to 
> work.
> We haven't got to PCMCIA support in 2.6 yet, and PCMCIA is unlikely to work
> as is in case of MPC885ADS, as drivers/pcmcia/m8xx_pcmcia.c is just missing.
> We plan to address PCMCIA later.

Lets just drop that hunk then..

-- 
Tom Rini
http://gate.crashing.org/~trini/
