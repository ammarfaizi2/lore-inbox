Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTF0Pfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTF0Pfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:35:43 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:22426 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S264488AbTF0Pfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:35:38 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] My research agenda for 2.7
Date: Fri, 27 Jun 2003 17:50:52 +0200
User-Agent: KMail/1.5.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306271717.01562.phillips@arcor.de> <Pine.LNX.4.53.0306271617210.21548@skynet>
In-Reply-To: <Pine.LNX.4.53.0306271617210.21548@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306271750.52362.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 June 2003 17:22, Mel Gorman wrote:
> I still suspect moving order0 allocations to slab will be a fragmentation
> resistent allocator but my main concern would be that the slab allocator
> overhead, both CPU and storage requirements will be too high.
>
> On the other hand, it would do some things you are looking for. For
> example, it allocates large blocks of memory in one lump and then
> allocates them piecemeal. Second, it would be resistent to the FAFAFA
> problem Martin pointed out. As slabs would be allocated in a large block
> from the buddy, you are guarenteed that you'll be able to free up buddies.
> Lastly, as there would be a cache specifically for userspace pages, a
> defragger that looked exclusively at user pages will still be sure of
> being able to free adjacent buddies.
>
> I need to write a proper RFC.....

You might want to have a look at this:

   http://www.research.att.com/sw/tools/vmalloc/
   (Vmalloc: A Memory Allocation Library)

Regards,

Daniel

