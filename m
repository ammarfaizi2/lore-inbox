Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWEaVlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWEaVlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWEaVlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:41:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64134 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965177AbWEaVls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:41:48 -0400
Date: Wed, 31 May 2006 17:41:39 -0400
From: Alan Cox <alan@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, alan@redhat.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c disable_irq()
Message-ID: <20060531214139.GA8196@devserv.devel.redhat.com>
References: <20060531200236.GA31619@elte.hu> <1149107500.3114.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149107500.3114.75.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 10:31:40PM +0200, Arjan van de Ven wrote:
> > 8390.c knows that ei_local->page_lock can only be used by an irq
> > context that it disabled -
> 
> btw I think this is no longer correct with the irq polling stuff Alan
> added to the kernel recently...

We could make the misrouted IRQ logic skip all handlers on a disabled IRQ
but that might actually be worse than the disease we are trying to cure by
doing so.

Alan

