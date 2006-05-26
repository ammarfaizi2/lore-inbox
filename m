Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWEZQn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWEZQn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWEZQn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:43:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59406 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751116AbWEZQn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:43:28 -0400
Date: Fri, 26 May 2006 18:43:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mike@halcrow.us>
Subject: Re: [PATCH 1/10] Convert ASSERT to BUG_ON
Message-ID: <20060526164327.GJ17337@stusta.de>
References: <20060526142117.GA2764@us.ibm.com> <E1FjdCG-000335-IS@localhost.localdomain> <20060526152401.GF17337@stusta.de> <20060526161454.GC2764@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526161454.GC2764@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 11:14:54AM -0500, Michael Halcrow wrote:
> On Fri, May 26, 2006 at 05:24:01PM +0200, Adrian Bunk wrote:
> > On Fri, May 26, 2006 at 09:21:48AM -0500, Mike Halcrow wrote:
> > > -	ASSERT(auth_tok->session_key.encrypted_key_size < PAGE_CACHE_SIZE);
> > > +	BUG_ON(auth_tok->session_key.encrypted_key_size > PAGE_CACHE_SIZE);
> > >...
> > 
> > What's with (auth_tok->session_key.encrypted_key_size ==
> > PAGE_CACHE_SIZE) ?
> 
> That should not be a problem.

IOW, the ASSERT was wrong?

My point is simply that this is not a semantically equivalent 
transformation, so if this fixes a case where the ASSERT() might have 
mistakenly triggered it should be noted in the changelog.

> Mike

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

