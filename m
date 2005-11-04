Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVKDH10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVKDH10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVKDH1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:27:25 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:21134 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751418AbVKDH1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:27:25 -0500
Date: Thu, 3 Nov 2005 23:26:49 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, andy@thermo.lanl.gov, mbligh@mbligh.org, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051103232649.12e58615.pj@sgi.com>
In-Reply-To: <20051104063820.GA19505@elte.hu>
References: <20051104010021.4180A184531@thermo.lanl.gov>
	<Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
	<20051103221037.33ae0f53.pj@sgi.com>
	<20051104063820.GA19505@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> to clearly stress the 'might easily fail' restriction. But if userspace 
> is well-behaved on Andy's systems (which it seems to be), then in 
> practice it should be resizable. 

At first glance, this is the sticky point that jumps out at me.

Andy wrote:
>    My experience is that after some days or weeks of running have gone
>    by, there is no possible way short of a reboot to get pages merged
>    effectively back to any pristine state with the infrastructure that 
>    exists there.

I take it, from what Andy writes, and from my other experience with
similar customers, that his workload is not "well-behaved" in the
sense you hoped for.

After several diverse jobs are run, we cannot, so far as I know,
merge small pages back to big pages.

I have not played with Mel Gorman's Fragmentation Avoidance patches,
so don't know if they would provide a substantial improvement here.
They well might.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
