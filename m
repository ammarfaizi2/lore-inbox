Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261263AbSJ1O2P>; Mon, 28 Oct 2002 09:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbSJ1O2P>; Mon, 28 Oct 2002 09:28:15 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62715 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261263AbSJ1O2O>; Mon, 28 Oct 2002 09:28:14 -0500
Date: Mon, 28 Oct 2002 14:35:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, <rmk@arm.linux.org.uk>, <willy@debian.org>,
       <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shmem missing cache flush
In-Reply-To: <20021028.061059.38206858.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210281429160.10214-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 16 Oct 2002, David S. Miller wrote:
>    From: Hugh Dickins <hugh@veritas.com>
>    Date: Thu, 17 Oct 2002 00:57:30 +0100 (BST)
>    
>    I would be much happier about adding it, if you could tell me that
>    I can then remove the flush_page_to_ram(page) from shmem_nopage?
>    
> No we still have to support platforms using flush_page_to_ram()
> 
> I didn't get a chance to deprecate this in 2.5.x, I wish I had.

On Mon, 28 Oct 2002, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 21 Oct 2002 17:12:22 +0100
>    
>    Send me the diffs Im happy to give them a spin.
> 
> Here goes.  I contacted Anton and Paulus about flush_icache_page as
> that is on the hitlist next and ppc/ppc64 is the only well maintained
> port using that.

I like your patch, but what has changed?  Are those platforms which
were using flush_page_to_ram() now committed to its elimination?
Or have they already replaced it (not seen in your patch)?

Hugh

