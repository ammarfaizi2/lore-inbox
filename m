Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263454AbTKCWqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 17:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTKCWqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 17:46:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7808 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263454AbTKCWqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 17:46:33 -0500
Date: Mon, 3 Nov 2003 14:40:21 -0800
From: "David S. Miller" <davem@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] phys_contig implies hw_contig
Message-Id: <20031103144021.4b884b48.davem@redhat.com>
In-Reply-To: <20031102221026.GA9976@gondor.apana.org.au>
References: <20031101023127.GA14438@gondor.apana.org.au>
	<20031101204547.1c861c42.davem@redhat.com>
	<20031102044734.GA2150@gondor.apana.org.au>
	<20031102221026.GA9976@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003 09:10:26 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Sun, Nov 02, 2003 at 03:47:34PM +1100, herbert wrote:
> > On Sat, Nov 01, 2003 at 08:45:47PM -0800, David S. Miller wrote:
> >
> > > Your analysis assumes that phys contig implies hw contig, I
> > > believe it does not.  There may be limitations in the VMERGE
> > > mechanism a platform implements that causes this situation to
> > > arise.
> > 
> > OK, if that's the case, then we better change blk_recount_segments
> > as it assumes this.
> 
> Bug David that can't be right.  If two segments are physically contiguous,
> then they don't need to be remapped to be virtually continguous, right?

Yes it sounds silly.

To be honest I'm more concerned that things are consistent.
Therefore I recommend that your original patch is applied.
