Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVKFBbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVKFBbx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 20:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVKFBbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 20:31:53 -0500
Received: from zlynx.org ([199.45.143.209]:29452 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S932271AbVKFBbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 20:31:52 -0500
Message-ID: <436D5CCD.3050901@acm.org>
Date: Sat, 05 Nov 2005 18:30:53 -0700
From: Zan Lynx <zlynx@acm.org>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Gregory Maxwell <gmaxwell@gmail.com>, Andy Nelson <andy@thermo.lanl.gov>,
       mingo@elte.hu, akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, torvalds@osdl.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051104201248.GA14201@elte.hu> <20051104210418.BC56F184739@thermo.lanl.gov> <e692861c0511041331ge5dd1abq57b6c513540fa200@mail.gmail.com> <200511042343.27832.ak@suse.de>
In-Reply-To: <200511042343.27832.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I don't like it very much. You have two choices if a workload runs
> out of the kernel allocatable pages. Either you spill into the reclaimable
> zone or you fail the allocation. The first means that the huge pages
> thing is unreliable, the second would mean that all the many problems
> of limited lowmem would be back.
>
> None of this is very attractive.
>   
You could allow the 'hugetlb zone' to shrink, allowing more kernel 
allocations.  User pages at the boundary would be moved to make room.

This would at least keep the 'hugetlb zone' pure and not create holes in it.
