Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVKNMXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKNMXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKNMXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:23:53 -0500
Received: from [194.90.237.34] ([194.90.237.34]:17881 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1750702AbVKNMXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:23:53 -0500
Date: Mon, 14 Nov 2005 14:25:35 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051114122535.GP20871@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0511101251060.7127@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511101251060.7127@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins <hugh@veritas.com>:
> Subject: Re: Nick's core remove PageReserved broke vmware...
> 
> On Tue, 8 Nov 2005, Michael S. Tsirkin wrote:
> > 
> > Hugh, did you have something like the following in mind
> > (this is only boot-tested and only on x86-64)?
> 
> Yes, that looks pretty good to me, a few comments below.
> Only another twenty or so architectures to go ;)

There's one thing that I have thought about: what happens
if I set DONTFORK on a page which already has COW set
(e.g. after fork)?

It seems that the right thing would be to force a page copy -
otherwise the page can get copied on write.

Makes sense?

-- 
MST
