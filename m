Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUDRWwA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 18:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbUDRWv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 18:51:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:11676 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264207AbUDRWv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 18:51:27 -0400
Subject: Re: [Fwd: [PATCH] ppc64: Fix CPU hot unplug deadlock]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040418165055.GC28807@suse.de>
References: <1082266724.2500.327.camel@gaston>
	 <20040418165055.GC28807@suse.de>
Content-Type: text/plain
Message-Id: <1082328347.13508.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 08:45:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > diff -urN linux-2.5/arch/ppc64/kernel/rtas.c ppc64-linux-2.5/arch/ppc64/kernel/rtas.c
> > --- linux-2.5/arch/ppc64/kernel/rtas.c	2004-04-17 12:39:03.253986984 +1000
> > +++ ppc64-linux-2.5/arch/ppc64/kernel/rtas.c	2004-04-18 15:35:41.871029480 +1000
> > @@ -504,9 +504,9 @@
> >  void rtas_stop_self(void)
> >  {
> >  	struct rtas_args *rtas_args = &(get_paca()->xRtas);
> > -	unsigned long s;
> >  
> > -	spin_lock_irqsave(&rtas.lock, s);
> > +	local_irq_disable(s);
> 
> did that compile ok for you

Rah ! I sent the wrong one ! I'm really sick...

New fix on the way

Ben.


