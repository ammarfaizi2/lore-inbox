Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVEXTIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVEXTIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 15:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVEXTIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 15:08:50 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:53778 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261499AbVEXTIp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 15:08:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I3wckEvv7Kg3xgN829uDXo/5kMBeiTfNt4QqKX4o7HxP+oN6pLbVAWf7dXBa1I/k02OWiZjHfdYWR0Z8WO1Z9sBDEz9yR4y3s5L3psrk5hkXsykrMArmi5b6khRn7ymGTv+Tvl1n7PQG/UGpCRkWcGHa4zPuD3WOvLYobMfT9yI=
Message-ID: <a4e6962a0505241208214a200f@mail.gmail.com>
Date: Tue, 24 May 2005 14:08:44 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Pekka Enberg <penberg@gmail.com>
Subject: Re: [RFC][patch 4/7] v9fs: VFS superblock operations (2.0-rc6)
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi
In-Reply-To: <84144f0205052400113c6f40fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505232225.j4NMPte1029529@ms-smtp-02-eri0.texas.rr.com>
	 <84144f0205052400113c6f40fc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/05, Pekka Enberg <penberg@gmail.com> wrote:
> 
> > +
> > +/**
> > + * find_slab - look up a slab by size
> > + * @size: size of slab data
> > + *
> > + */
> > +
> > +static inline kmem_cache_t *find_slab(int size)
> 
> Hmm? Why do you need this? If you're missing functionality from the
> slab allocator, please put that in mm/slab.c, not your filesystem!
> 

Thanks for the comments!  A bit of a clarification on slab policy - I
did my own find_slab() so I could keep tight control over my own slabs
(and monitor for slab leaks, etc.).  There seems to be similar
functionality for the malloc slabs (kmem_find_general_cachep), but I'm
not sure if this is really something that is generally useful.  What
do folks think?  Is this something that would be generally useful to
add to slab.c?  Or is there something like this that I just
overlooked?

             -eric
