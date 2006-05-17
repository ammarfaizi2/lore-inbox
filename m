Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWEQOij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWEQOij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 10:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWEQOij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 10:38:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61135 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964779AbWEQOii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 10:38:38 -0400
Date: Wed, 17 May 2006 16:37:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [patch 27/50] genirq: ARM: dyntick quirk
Message-ID: <20060517143717.GA8472@elf.ucw.cz>
References: <20060517001721.GB12877@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517001721.GB12877@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> ARM dyntick quirk.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/irq/handle.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> Index: linux-genirq.q/kernel/irq/handle.c
> ===================================================================
> --- linux-genirq.q.orig/kernel/irq/handle.c
> +++ linux-genirq.q/kernel/irq/handle.c
> @@ -16,6 +16,10 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel_stat.h>
>  
> +#if defined(CONFIG_NO_IDLE_HZ) && defined(CONFIG_ARM)
> +#include <asm/dyntick.h>
> +#endif
> +
>  #include "internals.h"
>  
>  /**

Move ifdef into header file or just always include it?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
