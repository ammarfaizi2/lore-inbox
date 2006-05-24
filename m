Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWEXBs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWEXBs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWEXBs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:48:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13804 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932542AbWEXBs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:48:57 -0400
Date: Wed, 24 May 2006 11:48:41 +1000
From: David Chinner <dgc@sgi.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
Message-ID: <20060524014841.GA7418631@melbourne.sgi.com>
References: <20060524012412.GB7412499@melbourne.sgi.com> <20060523184407.dc8b4a2b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060523184407.dc8b4a2b.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 06:44:07PM -0700, Randy.Dunlap wrote:
> On Wed, 24 May 2006 11:24:12 +1000 David Chinner wrote:
> > +static void
> > +dentry_lru_del_init(struct dentry *dentry)
> > +{
> > +	if (likely(!list_empty(&dentry->d_lru))) {
> > +		list_del_init(&dentry->d_lru);
> > +		dentry_stat.nr_unused--;
> > +	}
> > +}
> > +
> >  /* 
> >   * This is dput
> >   *
> 
> Please use regular kernel coding style for functions:
> don't put qualifiers and names on separate lines.

Oops - I'm too used to the XFS coding style. Fixed.

> > @@ -377,6 +399,48 @@ static inline void prune_one_dentry(stru
> >  	spin_lock(&dcache_lock);
> >  }
> >  
> > +/*
> > + * Shrink the dentry LRU on æ given superblock.
> 
> on ? given superblock ?

"a". Fixed.

I'll wait for other comments before sending out an updated patch.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
