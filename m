Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWIVGSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWIVGSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWIVGSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:18:15 -0400
Received: from ns1.suse.de ([195.135.220.2]:64653 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750727AbWIVGSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:18:14 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
Date: Fri, 22 Sep 2006 08:17:59 +0200
User-Agent: KMail/1.9.3
Cc: Martin Bligh <mbligh@mbligh.org>, akpm@google.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609220817.59801.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 September 2006 06:02, Christoph Lameter wrote:
> We have repeatedly discussed the problems of devices having varying 
> address range requirements for doing DMA.

We already have such an API. dma_alloc_coherent(). Device drivers
are not supposed to mess with GFP_DMA* directly anymore for quite
some time. 

> We would like for the device  
> drivers to have the ability to specify exactly which address range is 
> allowed. 

I actually have my doubts it is a good idea to add that now. The devices
with weird requirements are steadily going away.

-Andi

