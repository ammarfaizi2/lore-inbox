Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVH2Dyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVH2Dyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 23:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVH2Dyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 23:54:31 -0400
Received: from pat.uio.no ([129.240.130.16]:1432 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750797AbVH2Dya convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 23:54:30 -0400
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
	search
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4312830C.8000308@yahoo.com.au>
References: <1125159996.5159.8.camel@mulgrave>
	 <20050827105355.360bd26a.akpm@osdl.org> <1125276312.5048.22.camel@mulgrave>
	 <20050828175233.61cada23.akpm@osdl.org> <1125278389.5048.30.camel@mulgrave>
	 <20050828183531.0b4d6f2d.akpm@osdl.org> <1125285994.5048.40.camel@mulgrave>
	  <4312830C.8000308@yahoo.com.au>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Aug 2005 20:54:11 -0700
Message-Id: <1125287651.29493.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.362, required 12,
	autolearn=disabled, AWL 1.64, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 29.08.2005 Klokka 13:37 (+1000) skreiv Nick Piggin:
> James Bottomley wrote:
> > On Sun, 2005-08-28 at 18:35 -0700, Andrew Morton wrote:
> 
> >>It does make the tree higher and hence will incur some more cache missing
> >>when descending the tree.
> > 
> > 
> > Actually, I don't think it does:  the common user is the page tree.
> > Obviously, I've changed nothing on 64 bits, so we only need to consider
> > what I've done on 32 bits.  A page size is almost universally 4k on 32
> > bit, so we need 20 bits to store the page tree index.  Regardless of
> > whether the index size is 5 or 6, that gives a radix tree depth of 4.
> > 
> 
> s/common/only ?

grep again... I use it in the NFS client for bookkeeping requests.

Cheers,
  Trond

