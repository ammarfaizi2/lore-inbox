Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWIVQff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWIVQff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWIVQff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:35:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62364 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932565AbWIVQfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:35:34 -0400
Date: Fri, 22 Sep 2006 09:35:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Martin Bligh <mbligh@mbligh.org>, akpm@google.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
In-Reply-To: <200609220817.59801.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609220934040.7083@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
 <200609220817.59801.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Andi Kleen wrote:

> On Friday 22 September 2006 06:02, Christoph Lameter wrote:
> > We have repeatedly discussed the problems of devices having varying 
> > address range requirements for doing DMA.
> 
> We already have such an API. dma_alloc_coherent(). Device drivers
> are not supposed to mess with GFP_DMA* directly anymore for quite
> some time. 

Device drivers need to be able to indicate ranges of addresses that may be 
different from ZONE_DMA. This is an attempt to come up with a future 
scheme that does no longer rely on device drivers referring to zoies.

> > We would like for the device  
> > drivers to have the ability to specify exactly which address range is 
> > allowed. 
> 
> I actually have my doubts it is a good idea to add that now. The devices
> with weird requirements are steadily going away

Hmm.... Martin?

