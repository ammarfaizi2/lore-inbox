Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbUKGTUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUKGTUo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 14:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUKGTUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 14:20:44 -0500
Received: from holomorphy.com ([207.189.100.168]:54158 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261674AbUKGTUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 14:20:39 -0500
Date: Sun, 7 Nov 2004 11:20:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Adam Litke <agl@us.ibm.com>,
       Andy Whitworth <apw@shadowen.org>
Subject: Re: [RFC] Consolidate lots of hugepage code
Message-ID: <20041107192024.GM2890@holomorphy.com>
References: <20041029033708.GF12247@zax> <20041029034817.GY12934@holomorphy.com> <20041107172030.GA16976@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107172030.GA16976@krispykreme.ozlabs.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Further consolidation is premature given that outstanding hugetlb bugs
>> have the implication that architectures' needs are not being served by
>> the current arch/core split. I have at least two relatively major hugetlb
>> bugs outstanding, the lack of a flush_dcache_page() analogue first, and
>> another (soon to be a reported to affected distros) less well-understood.
>> Unless they're directly toward the end of restoring hugetlb to a sound
>> state, they're counterproductive to merge before patches doing so.

On Mon, Nov 08, 2004 at 04:20:30AM +1100, Anton Blanchard wrote:
> Could you point me at a summary of these 2 issues? 

It's all pretty obvious. The first is checking page size vs. cache size
and whether it's VI or does anything unusual; thus far things look
hopeful that flush_dcache_page() analogues are unnecessary. More
information about Super-H is needed to wrap up what will probably be no
more than an audit. The second is a triplefault on x86-64 under some
condition involving a long-running database regression test. There has
obviously been considerably less progress there in no small part due to
the amount of time required to reproduce the issue.


-- wli
