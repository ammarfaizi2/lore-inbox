Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVAHJja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVAHJja (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVAHJh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:37:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18611 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261987AbVAHIlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 03:41:32 -0500
Date: Sat, 8 Jan 2005 09:41:17 +0100
From: Jens Axboe <axboe@suse.de>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6] cciss typo fix
Message-ID: <20050108084113.GA21857@suse.de>
References: <D4CFB69C345C394284E4B78B876C1CF107DC0185@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107DC0185@cceexc23.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07 2005, Miller, Mike (OS Dev) wrote:
> > -----Original Message-----
> > From: James Bottomley [mailto:James.Bottomley@SteelEye.com]
> > 
> > 
> > On Fri, 2005-01-07 at 17:01 -0600, mike.miller@hp.com wrote:
> > > -		*total_size = be32_to_cpu(*((__be32 *) 
> > &buf->total_size[0]))+1;
> > > -		*block_size = be32_to_cpu(*((__be32 *) 
> > &buf->block_size[0]));
> > > +		*total_size = be32_to_cpu(*((__u32 *) 
> > &buf->total_size[0]))+1;
> > > +		*block_size = be32_to_cpu(*((__u32 *) 
> > &buf->block_size[0]));
> > 
> > I don't think that's a typo.  It was introduced by this patch:
> > 
> > ChangeSet 1.1988.24.79 2004/10/06 07:55:02 viro@www.linux.org.uk
> >   [PATCH] cciss endianness and iomem annotations
> >  
> > The idea being that BE and LE numbers should be annotated differently,
> > so the __be32 annotations look correct to me.  I think sparse 
> > will warn
> > if you make this change.
> 
> Hmmm, SuSE complained that __be32 was not defined in the kernel. Any
> other thoughts, anyone?

Hmm odd, no one should have complained, it should just have been added
to the compat header.

-- 
Jens Axboe

