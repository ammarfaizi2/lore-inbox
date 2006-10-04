Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWJDTuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWJDTuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWJDTuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:50:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15041 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750960AbWJDTuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:50:11 -0400
Message-ID: <4524106C.8010807@garzik.org>
Date: Wed, 04 Oct 2006 15:50:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: linux-kernel@vger.kernel.org, arjan@infradead.org, matthew@wil.cx,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #3
References: <20061004193229.GA352@slug>
In-Reply-To: <20061004193229.GA352@slug>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> --- 2.6.18-mm3.orig/include/linux/interrupt.h
> +++ 2.6.18-mm3/include/linux/interrupt.h
> @@ -75,6 +75,13 @@ struct irqaction {
>  	struct proc_dir_entry *dir;
>  };
>  
> +#ifndef ARCH_VALIDATE_IRQ
> +static inline int is_irq_valid(unsigned int irq)
> +{
> +	return irq ? 1 : 0;
> +}
> +#endif /* ARCH_VALIDATE_IRQ */


I ACK everything except the above snippet.  I just don't think it's 
linux/interrupt.h material, sorry.

If a consensus of arch maintainers (i.e. not just willy) think it's 
fine, then I'm overruled, otherwise...

	Jeff


