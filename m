Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVAKA6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVAKA6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVAKA5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:57:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:27366 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262769AbVAKAqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:46:22 -0500
Date: Mon, 10 Jan 2005 16:46:09 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Chris Wright <chrisw@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V4 [1/4]: Arch specific page zeroing during page
 fault
In-Reply-To: <20050110164157.R469@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0501101645250.25962@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <Pine.LNX.4.58.0501100915200.19135@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501101004230.2373@ppc970.osdl.org>
 <Pine.LNX.4.58.0501101552100.25654@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501101553140.25654@schroedinger.engr.sgi.com>
 <20050110164157.R469@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Chris Wright wrote:

> * Christoph Lameter (clameter@sgi.com) wrote:
> > @@ -1795,7 +1786,7 @@
> >
> >  		if (unlikely(anon_vma_prepare(vma)))
> >  			goto no_mem;
> > -		page = alloc_page_vma(GFP_HIGHZERO, vma, addr);
> > +		page = alloc_zeroed_user_highpage(vma, addr);
>
> Oops, HIGHZERO is gone already in Linus' tree.

Use bk13 as I indicated.
