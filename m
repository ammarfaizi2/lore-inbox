Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTKBWKm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 17:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTKBWKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 17:10:42 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:519 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261868AbTKBWKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 17:10:41 -0500
Date: Mon, 3 Nov 2003 09:10:26 +1100
To: "David S. Miller" <davem@redhat.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] phys_contig implies hw_contig
Message-ID: <20031102221026.GA9976@gondor.apana.org.au>
References: <20031101023127.GA14438@gondor.apana.org.au> <20031101204547.1c861c42.davem@redhat.com> <20031102044734.GA2150@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102044734.GA2150@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 03:47:34PM +1100, herbert wrote:
> On Sat, Nov 01, 2003 at 08:45:47PM -0800, David S. Miller wrote:
>
> > Your analysis assumes that phys contig implies hw contig, I
> > believe it does not.  There may be limitations in the VMERGE
> > mechanism a platform implements that causes this situation to
> > arise.
> 
> OK, if that's the case, then we better change blk_recount_segments
> as it assumes this.

Bug David that can't be right.  If two segments are physically contiguous,
then they don't need to be remapped to be virtually continguous, right?
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
