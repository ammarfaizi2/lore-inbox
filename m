Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTKBEqC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 23:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTKBEqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 23:46:01 -0500
Received: from rth.ninka.net ([216.101.162.244]:35492 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261437AbTKBEqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 23:46:00 -0500
Date: Sat, 1 Nov 2003 20:45:47 -0800
From: "David S. Miller" <davem@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] phys_contig implies hw_contig
Message-Id: <20031101204547.1c861c42.davem@redhat.com>
In-Reply-To: <20031101023127.GA14438@gondor.apana.org.au>
References: <20031101023127.GA14438@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Nov 2003 13:31:27 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> In ll_merge_requests_fn, it is checking blk_hw_contig_segments even if
> blk_phys_contig_segments succeeds.  This means that it may cause two
> physically contiguous segments to be separated because the hw check
> fails.

Your analysis assumes that phys contig implies hw contig, I
believe it does not.  There may be limitations in the VMERGE
mechanism a platform implements that causes this situation to
arise.

