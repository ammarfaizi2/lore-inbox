Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWBORjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWBORjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWBORjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:39:45 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:59619 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751037AbWBORjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:39:44 -0500
Subject: Re: [PATCH] add asm-generic/mman.h
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <Pine.LNX.4.64.0602150916580.3691@g5.osdl.org>
References: <20060215151649.GA12090@mellanox.co.il>
	 <1140019088.21448.3.camel@dyn9047017100.beaverton.ibm.com>
	 <20060215165016.GD12974@mellanox.co.il>
	 <1140022377.21448.6.camel@dyn9047017100.beaverton.ibm.com>
	 <20060215170935.GE12974@mellanox.co.il>
	 <Pine.LNX.4.64.0602150916580.3691@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 09:40:50 -0800
Message-Id: <1140025250.21448.15.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 09:28 -0800, Linus Torvalds wrote:
> 
> On Wed, 15 Feb 2006, Michael S. Tsirkin wrote:
> >
> > Other numbers look right, dont they?
> 
> Suggestion: for each macro name, do
> 
> 	grep "macroname" patch
> 
> and if you see anything that looks even half-way suspicious, check it.
> 
> Here's a pipeline from hell which shows that you broke at least 
> MADV_REMOVE (which has values 5-9 depending on architecture).

Yes. I did that earlier and checked everything.

MADV_REMOVE is a known change. Since it added very recently,
I guess is okay to fix it for real. But if we are going to
change it, I am hoping to see it very soon in mainline. 
(Before distros fork-off).

Thanks,
Badari

