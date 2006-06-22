Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWFVTpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWFVTpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161211AbWFVTpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:45:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62904 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030355AbWFVTpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:45:07 -0400
Date: Thu, 22 Jun 2006 12:44:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/4] Slab Reclaim logic
In-Reply-To: <Pine.LNX.4.58.0606222234400.5385@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0606221243360.31332@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0606222234400.5385@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Pekka J Enberg wrote:

> Some coding style comments below.
> 
> > +extern long kmem_cache_reclaim(struct kmem_cache *, gfp_t flags, unsigned long);
> 
> The parameter name is redundant.

Ok.
> 
> > +static int try_reclaim_one(kmem_cache_t *cachep, struct kmem_list3 *l3,
> > +	struct list_head *list, unsigned short marker)
> 
> Please use struct kmem_cache instead of the typedef.  Better name for l3 
> would be nice.

l3 is a very good name.

> > +{
> > +	int nr_freed = 0;
> 
> s/nr_freed/ret/

ret is non descriptive. nr_freed is describing what the purpose of the 
variable is.

> > +	while (nr_freed < slabs_to_free) {
> > +		int x;
> 
> s/x/nr_freed/

Would shadow variable.

