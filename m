Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbUKOBK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUKOBK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUKOBKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:10:19 -0500
Received: from ozlabs.org ([203.10.76.45]:52657 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261397AbUKOBJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:09:54 -0500
Subject: Re: [PATCH][2.6.10-rc1-mm4][3/4] perfctr x86 driver updates
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411110937.iAB9b7Ir028763@alkaid.it.uu.se>
References: <200411110937.iAB9b7Ir028763@alkaid.it.uu.se>
Content-Type: text/plain
Date: Mon, 15 Nov 2004 12:09:45 +1100
Message-Id: <1100480985.7381.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 10:37 +0100, Mikael Pettersson wrote:
> Part 3/4 of the perfctr interrupt fixes:
...
>  	} control;
> +#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
> +	unsigned int interrupts_masked;
> +#endif
>  } ____cacheline_aligned;
>  static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);

While you're here, does this really have to be cacheline aligned?  I
wouldn't think so, since it's in the per-cpu section anyway.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

