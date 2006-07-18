Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWGRN7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWGRN7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWGRN7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:59:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53974 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932213AbWGRN7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:59:32 -0400
Date: Tue, 18 Jul 2006 06:59:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
In-Reply-To: <44BCE86A.4030602@mbligh.org>
Message-ID: <Pine.LNX.4.64.0607180657160.30887@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy> 
 <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com>
 <1153224998.2041.15.camel@lappy> <Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com>
 <44BCE86A.4030602@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006, Martin J. Bligh wrote:

> Someone remind me why we can't remove the memlocked pages from the LRU
> again? Apart from needing a refcount of how many times they're memlocked
> (or we just shove them back whenever they're unlocked, and let it fall
> out again when we walk the list, but that doesn't fix the accounting
> problem).

We simply do not unmap memlocked pages (see try_to_unmap). And therefore
they are not reclaimable.

