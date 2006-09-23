Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWIWAkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWIWAkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWIWAkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:40:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:27607 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964978AbWIWAkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:40:22 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: More thoughts on getting rid of ZONE_DMA
Date: Sat, 23 Sep 2006 02:39:57 +0200
User-Agent: KMail/1.9.3
Cc: Martin Bligh <mbligh@mbligh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <200609230134.45355.ak@suse.de> <Pine.LNX.4.64.0609221715520.10484@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609221715520.10484@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609230239.57694.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 September 2006 02:23, Christoph Lameter wrote:
> On Sat, 23 Sep 2006, Andi Kleen wrote:
> 
> > The problem is that if someone has a workload with lots of pinned pages
> > (e.g. lots of mlock) then the first 16MB might fill up completely and there 
> > is no chance at all to free it because it's pinned
> 
> Ok. That may be a problem for i386. After the removal of the GFP_DMA 
> and ZONE_DMA stuff it is then be possible to redefine ZONE_DMA (or 
> whatever we may call it ZONE_RESERVE?) to an arbitrary size a the 
> beginning of memory. Then alloc_pages_range() can dynamically decide to 
> tap that pool if necessary. 

That's should work yes. Just we need the pool.

-Andi
