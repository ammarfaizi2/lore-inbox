Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTKBErx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 23:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTKBErx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 23:47:53 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:59396 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261464AbTKBErv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 23:47:51 -0500
Date: Sun, 2 Nov 2003 15:47:34 +1100
To: "David S. Miller" <davem@redhat.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] phys_contig implies hw_contig
Message-ID: <20031102044734.GA2150@gondor.apana.org.au>
References: <20031101023127.GA14438@gondor.apana.org.au> <20031101204547.1c861c42.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101204547.1c861c42.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 08:45:47PM -0800, David S. Miller wrote:
> On Sat, 1 Nov 2003 13:31:27 +1100
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> > In ll_merge_requests_fn, it is checking blk_hw_contig_segments even if
> > blk_phys_contig_segments succeeds.  This means that it may cause two
> > physically contiguous segments to be separated because the hw check
> > fails.
> 
> Your analysis assumes that phys contig implies hw contig, I
> believe it does not.  There may be limitations in the VMERGE
> mechanism a platform implements that causes this situation to
> arise.

OK, if that's the case, then we better change blk_recount_segments
as it assumes this.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
