Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWFISUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWFISUs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWFISUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:20:48 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41627 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751463AbWFISUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:20:48 -0400
Message-Id: <200606091819.k59IJTlN027053@laptop11.inf.utfsm.cl>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, hugh@veritas.com, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 01/14] Per zone counter functionality 
In-Reply-To: Message from Peter Zijlstra <a.p.zijlstra@chello.nl> 
   of "Fri, 09 Jun 2006 11:22:13 +0200." <1149844934.20886.41.camel@lappy> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Fri, 09 Jun 2006 14:19:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 09 Jun 2006 14:19:45 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Thu, 2006-06-08 at 21:00 -0700, Andrew Morton wrote:
> > On Thu, 8 Jun 2006 16:02:44 -0700 (PDT)
> > Christoph Lameter <clameter@sgi.com> wrote:
> 
> > > +#ifdef CONFIG_SMP
> > > +void refresh_cpu_vm_stats(int);
> > > +void refresh_vm_stats(void);
> > > +#else
> > > +static inline void refresh_cpu_vm_stats(int cpu) { };
> > > +static inline void refresh_vm_stats(void) { };
> > > +#endif
> > 
> > do {} while (0), please.  Always.  All other forms (afaik) have problems. 
> > In this case,
> > 
> > 	if (something)
> > 		refresh_vm_stats();
> > 	else
> > 		foo();
> > 
> > will not compile.
> 
> It surely will, 'static inline' does not make it less of a function.
> Although the trailing ; is not needed in the function definition.

The trailing ';' is broken.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
