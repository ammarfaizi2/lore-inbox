Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWDXJHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWDXJHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 05:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWDXJHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 05:07:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17857 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932099AbWDXJHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 05:07:03 -0400
Subject: Re: [PATCH 07/16] GFS2: Directory handling
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060421161636.GA15311@infradead.org>
References: <1145636178.3856.106.camel@quoit.chygwyn.com>
	 <20060421161636.GA15311@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 24 Apr 2006 10:16:26 +0100
Message-Id: <1145870186.3856.131.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-04-21 at 17:16 +0100, Christoph Hellwig wrote:
> > +/*
> > +* Implements Extendible Hashing as described in:
> > +*   "Extendible Hashing" by Fagin, et al in
> > +*     __ACM Trans. on Database Systems__, Sept 1979.
> > +*
> > +*
> 
> please follow the normal comment style, that is leave a space before the *
> for block comments so it lines up nicely with the * in the start tag.
> 
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/completion.h>
> 
> you don't seem to be using any completion in this file
> 
> > +#include <linux/buffer_head.h>
> > +#include <linux/sort.h>
> > +#include <linux/gfs2_ondisk.h>
> > +#include <linux/crc32.h>
> > +#include <linux/vmalloc.h>
> > +#include <asm/semaphore.h>
> 
> you're not using any semaphore in this file
> 
> > +int gfs2_dir_get_buffer(struct gfs2_inode *ip, uint64_t block, int new,
> > +		         struct buffer_head **bhp)
[function body cut for clarity]
> 
> the code is completely different for the new vs !new case, so there's no
> point in merging it to a single function.
> 
These points are now fixed in the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=61e085a88cb59232eb8ff5b446d70491c7bf2c68

Thanks for the comments, please let me know if I missed anything,

Steve.


