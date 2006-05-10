Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWEJXAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWEJXAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWEJXAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:00:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:29621 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965057AbWEJXAn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:00:43 -0400
Date: Wed, 10 May 2006 16:00:54 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: penberg@cs.Helsinki.FI, clameter@sgi.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add slab_is_available() routine for boot code
Message-ID: <20060510230054.GA11214@w-mikek2.ibm.com>
References: <20060510205543.GI3198@w-mikek2.ibm.com> <20060510155026.173c57a1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510155026.173c57a1.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 03:50:26PM -0700, Andrew Morton wrote:
> Mike Kravetz <kravetz@us.ibm.com> wrote:
> > diff -Naupr linux-2.6.17-rc3-mm1/mm/sparse.c linux-2.6.17-rc3-mm1.work3/mm/sparse.c
> > --- linux-2.6.17-rc3-mm1/mm/sparse.c	2006-05-03 22:19:16.000000000 +0000
> > +++ linux-2.6.17-rc3-mm1.work3/mm/sparse.c	2006-05-10 19:15:56.000000000 +0000
> > @@ -32,7 +32,7 @@ static struct mem_section *sparse_index_
> >  	unsigned long array_size = SECTIONS_PER_ROOT *
> >  				   sizeof(struct mem_section);
> >  
> > -	if (system_state == SYSTEM_RUNNING)
> > +	if (slab_is_available())
> >  		section = kmalloc_node(array_size, GFP_KERNEL, nid);
> >  	else
> >  		section = alloc_bootmem_node(NODE_DATA(nid), array_size);
> 
> Is this a needed-for-2.6.17 fix?

I'll let Arnd answer.  He ran into this when doing some Cell work.  Not
sure where in the development cycle the code is that exposes this bug.

-- 
Mike
