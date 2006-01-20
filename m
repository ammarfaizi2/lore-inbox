Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWATRJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWATRJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWATRJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:09:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42669 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750858AbWATRJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:09:07 -0500
Message-Id: <200601200518.k0K5InBK009744@laptop11.inf.utfsm.cl>
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [patch 05/10] slab: extract slab_destroy_objs() 
In-Reply-To: Message from Christoph Lameter <clameter@engr.sgi.com> 
   of "Wed, 18 Jan 2006 10:31:11 -0800." <Pine.LNX.4.62.0601181030340.1751@schroedinger.engr.sgi.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 20 Jan 2006 02:18:49 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 20 Jan 2006 14:08:21 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
> On Sat, 14 Jan 2006, Pekka Enberg wrote:
> 
> > +static void slab_destroy_objs(kmem_cache_t *cachep, struct slab *slabp)
> 
> This is only called once right? Make this inline?

Leave it to gcc. It might be called once today, and all over the place
tomorrow.

In any case, it can't be performance-critical.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

