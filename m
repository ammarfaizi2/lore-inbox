Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTENI2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTENI2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:28:14 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:7952 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261365AbTENI1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:27:05 -0400
Date: Wed, 14 May 2003 09:39:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] PAG support only
Message-ID: <20030514093944.A9474@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@warthog.cambridge.redhat.com>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	openafs-devel@openafs.org
References: <20030513213759.A9244@infradead.org> <13536.1052900263@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <13536.1052900263@warthog.warthog>; from dhowells@warthog.cambridge.redhat.com on Wed, May 14, 2003 at 09:17:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 09:17:43AM +0100, David Howells wrote:
> > - and even a wrong one..
> 
> I disagree, but no matter.

It's not a matter of your (or my) personal opinion of coding style.  Linux
is a big project and it's only maintainable if everyone sticks to a slightly
similar style.  


> > > +static kmem_cache_t *vfs_token_cache;
> > > +static kmem_cache_t *vfs_pag_cache;
> > 
> > How many of those will be around for a typical AFS client?  I have the vague
> > feeling the slabs are overkill..
> 
> And then there's the people who said I shouldn't use kmalloc but should create
> a slab instead...

That's why I ask how much it is used.  Could you answer the question maybe?

> 
> > > +	if (pag>0) {
> > > +		/* join existing PAG */
> > > +		if (tsk->vfspag->pag &&
> > > +		    tsk->vfspag->pag==pag)
> > > +			return pag;
> > 
> > Please try to get your code in conformance with Documentation/CodingStyle.
> 
> You are suggesting what changes exactly?

spaces between operators to start with.  It's not that difficult to read the
above document and other core kernel code, though.

