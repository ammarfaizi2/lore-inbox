Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTENFVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 01:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTENFVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 01:21:09 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:9487 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261788AbTENFVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 01:21:02 -0400
Date: Wed, 14 May 2003 06:33:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Neulinger <nneul@umr.edu>
Cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support only
Message-ID: <20030514063345.A517@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nathan Neulinger <nneul@umr.edu>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <8943.1052843591@warthog.warthog> <20030513213759.A9244@infradead.org> <1052864839.20037.2.camel@nneul-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052864839.20037.2.camel@nneul-laptop>; from nneul@umr.edu on Tue, May 13, 2003 at 05:27:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[openafs-devel dropped from the Cc-list due to stupid subscriber only policy]

On Tue, May 13, 2003 at 05:27:20PM -0500, Nathan Neulinger wrote:
> > > +static kmem_cache_t *vfs_token_cache;
> > > +static kmem_cache_t *vfs_pag_cache;
> > 
> > How many of those will be around for a typical AFS client?  I have the vague
> > feeling the slabs are overkill..
> 
> What's a "typical client"?

The case we wan to optimize for.  The question here is whether we really want
a separate slab or whether it makes more senze to just use the new kmalloc
slab (usually power of two sized).  
