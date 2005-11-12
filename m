Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVKLOsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVKLOsE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVKLOsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:48:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:21398 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932389AbVKLOsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:48:02 -0500
Date: Sat, 12 Nov 2005 15:48:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: tglx@linutronix.de, trini@kernel.crashing.org, sdietrich@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rt11 Fill out default_simple_type
Message-ID: <20051112144816.GA24942@elte.hu>
References: <Pine.LNX.4.64.0511120639420.15898@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511120639420.15898@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


doesnt apply. Also, the set_type line has whitespace damage.

	Ingo

* Daniel Walker <dwalker@mvista.com> wrote:

> 
> Needed to boot some ARM boards.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.14/kernel/irq/handle.c
> ===================================================================
> --- linux-2.6.14.orig/kernel/irq/handle.c
> +++ linux-2.6.14/kernel/irq/handle.c
> @@ -196,8 +196,9 @@ struct irq_type default_level_type = {
>   */
>  struct irq_type default_simple_type = {
>  	.typename	= "default_simple",
> -	.enable		= noop,
> -	.disable	= noop,
> +	.enable		= default_enable,
> +	.disable	= default_disable,
> +	.set_type       = default_set_type,
>  	.handle_irq	= handle_simple_irq,
>  };
