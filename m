Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265959AbSKFShS>; Wed, 6 Nov 2002 13:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265962AbSKFShS>; Wed, 6 Nov 2002 13:37:18 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:9736 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265959AbSKFShR>; Wed, 6 Nov 2002 13:37:17 -0500
Date: Wed, 6 Nov 2002 18:43:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org, Marco van Wieringen <mvw@planets.elm.net>
Subject: Re: [PATCH] remove extern inline from quotaops.h
Message-ID: <20021106184348.A25077@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>, vda@port.imtp.ilyichevsk.odessa.ua,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org,
	Marco van Wieringen <mvw@planets.elm.net>
References: <20021104141317.A29058@mookie.adilger.int> <200211061519.gA6FJXp13811@Port.imtp.ilyichevsk.odessa.ua> <3DC95F0A.50DB3C1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC95F0A.50DB3C1@digeo.com>; from akpm@digeo.com on Wed, Nov 06, 2002 at 10:27:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 10:27:22AM -0800, Andrew Morton wrote:
> Denis Vlasenko wrote:
> > 
> > For example,
> > 
> > static __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
> > {
> >         lock_kernel();
> >         if (sb_any_quota_enabled(inode->i_sb)) {
> 
> That's nuts.
> 
> Here you go.  Saves 7k in an ext2+ext3 build, and a lot of it is
> fastpath.  This will significantly reduce the cache footprint
> which the kernel presents to applications which are performing
> filesystem operations.

What about giving it non-shouting names while you're at it?

