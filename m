Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWDZL3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWDZL3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWDZL3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:29:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22486 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932396AbWDZL3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:29:20 -0400
From: Andi Kleen <ak@suse.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH] mm: add a nopanic option for low bootmem
Date: Wed, 26 Apr 2006 13:28:18 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, mulix@mulix.org
References: <20060424214428.GA14575@us.ibm.com> <200604250043.38590.ak@suse.de> <20060425140839.GB7779@us.ibm.com>
In-Reply-To: <20060425140839.GB7779@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261328.18495.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 16:08, Jon Mason wrote:
> On Tue, Apr 25, 2006 at 12:43:38AM +0200, Andi Kleen wrote:
> > On Monday 24 April 2006 23:44, Jon Mason wrote:
> > > This patch adds a no panic option for low bootmem allocs.  This will
> > > allow for a more graceful handling of "out of memory" for those
> > > callers who wish to handle it.
> > 
> > What's the user of it? Normally we don't merge such changes without
> > an user.
> 
> Sorry.  Per your suggestion in the review of our Calgary IOMMU code, I
> tried to use the alloc_bootmem_nopanic that you recently added.
> Unfortunately, it needs low mem for our translation tables, so we needed
> a new function to do this.  
> 
> Aside from Calgary, I have updated swiotlb to take advantage of this new
> function (amongst other clean-ups and refinements).  I'll push those
> swiotlb patches out today.


I will merge it together with the Calgary code then.
-Andi
