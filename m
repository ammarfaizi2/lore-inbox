Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWIVVcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWIVVcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWIVVcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:32:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:53901 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932193AbWIVVcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:32:52 -0400
Date: Fri, 22 Sep 2006 14:32:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Martin Bligh <mbligh@mbligh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
In-Reply-To: <200609222248.27700.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609221430450.9613@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
 <4514441E.70207@mbligh.org> <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
 <200609222248.27700.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Andi Kleen wrote:

> Looks like a good start. Surprising how little additional code it is.

Gosh. I just looked at x86_64 dma_alloc_coherent. There is mind boogling 
series of tricks with __GFP_DMA and GFP_DMA32 going on. Could you get me a 
patch that sorts this out if we have alloc_pages_range()? I would expect 
that the will become much simpler.
