Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVKLOw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVKLOw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVKLOw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:52:58 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62447 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932390AbVKLOw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:52:57 -0500
Subject: Re: [PATCH] rt11 Fill out default_simple_type
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, trini@kernel.crashing.org, sdietrich@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051112144816.GA24942@elte.hu>
References: <Pine.LNX.4.64.0511120639420.15898@dhcp153.mvista.com>
	 <20051112144816.GA24942@elte.hu>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 06:52:54 -0800
Message-Id: <1131807175.20224.3.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Teach me not use pine. I'll send it attached privatly, I think it's been
well reviewed anyway .

Daniel


On Sat, 2005-11-12 at 15:48 +0100, Ingo Molnar wrote:
> doesnt apply. Also, the set_type line has whitespace damage.
> 
> 	Ingo
> 
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > 
> > Needed to boot some ARM boards.
> > 
> > Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> > 
> > Index: linux-2.6.14/kernel/irq/handle.c
> > ===================================================================
> > --- linux-2.6.14.orig/kernel/irq/handle.c
> > +++ linux-2.6.14/kernel/irq/handle.c
> > @@ -196,8 +196,9 @@ struct irq_type default_level_type = {
> >   */
> >  struct irq_type default_simple_type = {
> >  	.typename	= "default_simple",
> > -	.enable		= noop,
> > -	.disable	= noop,
> > +	.enable		= default_enable,
> > +	.disable	= default_disable,
> > +	.set_type       = default_set_type,
> >  	.handle_irq	= handle_simple_irq,
> >  };

