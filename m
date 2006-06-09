Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWFIJd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWFIJd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 05:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFIJdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 05:33:55 -0400
Received: from ozlabs.org ([203.10.76.45]:1991 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932347AbWFIJdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 05:33:54 -0400
Date: Fri, 9 Jun 2006 11:49:50 +0300
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Lameter <clameter@sgi.com>
Cc: Adam Litke <agl@us.ibm.com>, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions on vma close
Message-ID: <20060609084950.GA30625@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Christoph Lameter <clameter@sgi.com>, Adam Litke <agl@us.ibm.com>,
	linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <1149257287.9693.6.camel@localhost.localdomain> <Pine.LNX.4.64.0606021301300.5492@schroedinger.engr.sgi.com> <1149281841.9693.39.camel@localhost.localdomain> <Pine.LNX.4.64.0606021407580.6179@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606021407580.6179@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jun 02, 2006 at 02:08:27PM -0700, Christoph Lameter wrote:
> On Fri, 2 Jun 2006, Adam Litke wrote:
> 
> > The real reason I want to "close" hugetlb regions (even on 64bit
> > platforms) is so a process can replace a previous hugetlb mapping with
> > normal pages when huge pages become scarce.  An example would be the
> > hugetlb morecore (malloc) feature in libhugetlbfs :)
> 
> Well that approach wont work on IA64 it seems.

Yes, but there's not much that can be done about that.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
