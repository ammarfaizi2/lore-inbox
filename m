Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWDYOEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWDYOEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWDYOEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:04:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43429 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932223AbWDYOEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:04:44 -0400
Date: Tue, 25 Apr 2006 09:08:39 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, mulix@mulix.org
Subject: Re: [PATCH] mm: add a nopanic option for low bootmem
Message-ID: <20060425140839.GB7779@us.ibm.com>
References: <20060424214428.GA14575@us.ibm.com> <200604250043.38590.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604250043.38590.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:43:38AM +0200, Andi Kleen wrote:
> On Monday 24 April 2006 23:44, Jon Mason wrote:
> > This patch adds a no panic option for low bootmem allocs.  This will
> > allow for a more graceful handling of "out of memory" for those
> > callers who wish to handle it.
> 
> What's the user of it? Normally we don't merge such changes without
> an user.

Sorry.  Per your suggestion in the review of our Calgary IOMMU code, I
tried to use the alloc_bootmem_nopanic that you recently added.
Unfortunately, it needs low mem for our translation tables, so we needed
a new function to do this.  

Aside from Calgary, I have updated swiotlb to take advantage of this new
function (amongst other clean-ups and refinements).  I'll push those
swiotlb patches out today.

Thanks,
Jon

> 
> -Andi
