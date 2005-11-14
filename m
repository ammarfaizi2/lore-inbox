Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVKNOzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVKNOzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 09:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKNOzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 09:55:18 -0500
Received: from [194.90.237.34] ([194.90.237.34]:614 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S1751136AbVKNOzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 09:55:16 -0500
Date: Mon, 14 Nov 2005 16:57:08 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051114145708.GU20871@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0511141237180.2655@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511141237180.2655@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Hugh Dickins <hugh@veritas.com>:
> Subject: Re: Nick's core remove PageReserved broke vmware...
> 
> On Mon, 14 Nov 2005, Michael S. Tsirkin wrote:
> > Quoting Gleb Natapov <gleb@minantech.com>:
> > > On Mon, Nov 14, 2005 at 02:25:35PM +0200, Michael S. Tsirkin wrote:
> > > > 
> > > > There's one thing that I have thought about: what happens
> > > > if I set DONTFORK on a page which already has COW set
> > > > (e.g. after fork)?
> > > > 
> > > > It seems that the right thing would be to force a page copy -
> > > > otherwise the page can get copied on write.
>
> > Should we worry about this?
> 
> About what?

For pages which hardware will only read, not write,
hardware driver does get_user_pages with write cleared.

This means that COW may remain set.

-- 
MST
