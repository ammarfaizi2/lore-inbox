Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVKNPHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVKNPHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVKNPHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:07:53 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:39461 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1751145AbVKNPHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:07:52 -0500
Date: Mon, 14 Nov 2005 17:07:03 +0200
From: Gleb Natapov <gleb@minantech.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051114150703.GH5492@minantech.com>
References: <Pine.LNX.4.61.0511141237180.2655@goblin.wat.veritas.com> <20051114145708.GU20871@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114145708.GU20871@mellanox.co.il>
X-OriginalArrivalTime: 14 Nov 2005 15:07:46.0637 (UTC) FILETIME=[2BBA7FD0:01C5E92D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 04:57:08PM +0200, Michael S. Tsirkin wrote:
> Quoting r. Hugh Dickins <hugh@veritas.com>:
> > Subject: Re: Nick's core remove PageReserved broke vmware...
> > 
> > On Mon, 14 Nov 2005, Michael S. Tsirkin wrote:
> > > Quoting Gleb Natapov <gleb@minantech.com>:
> > > > On Mon, Nov 14, 2005 at 02:25:35PM +0200, Michael S. Tsirkin wrote:
> > > > > 
> > > > > There's one thing that I have thought about: what happens
> > > > > if I set DONTFORK on a page which already has COW set
> > > > > (e.g. after fork)?
> > > > > 
> > > > > It seems that the right thing would be to force a page copy -
> > > > > otherwise the page can get copied on write.
> >
> > > Should we worry about this?
> > 
> > About what?
> 
> For pages which hardware will only read, not write,
> hardware driver does get_user_pages with write cleared.
> 
It looks like openib always pass 1 as write. I think this is
exactly for this reason.

> This means that COW may remain set.
> 
> -- 
> MST

--
			Gleb.
