Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965331AbWHXEhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331AbWHXEhI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 00:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWHXEhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 00:37:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965331AbWHXEhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 00:37:05 -0400
Date: Wed, 23 Aug 2006 21:27:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Stephane Eranian <eranian@frankl.hpl.hp.com>, eranian@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] 2.6.17.9 perfmon2 patch for review: modified
 x86_64 files
Message-Id: <20060823212701.07d38455.akpm@osdl.org>
In-Reply-To: <p73k64z7oh6.fsf@verdi.suse.de>
References: <200608230806.k7N8689P000540@frankl.hpl.hp.com>
	<p73k64z7oh6.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2006 12:09:25 +0200
Andi Kleen <ak@suse.de> wrote:

> >  void flush_thread(void)
> > @@ -462,6 +464,8 @@ int copy_thread(int nr, unsigned long cl
> >  	asm("mov %%es,%0" : "=m" (p->thread.es));
> >  	asm("mov %%ds,%0" : "=m" (p->thread.ds));
> >  
> > +	pfm_copy_thread(p);
> > +
> 
> AFAIK there was some work in -mm* for generic notifiers for exit/copy hooks. Can those
> be used?

I dropped them.  It was nice code, but there was overhead.  I went for
nasty&&fast over nice&&slow.
