Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUKGTfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUKGTfY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 14:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUKGTfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 14:35:24 -0500
Received: from ozlabs.org ([203.10.76.45]:388 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261232AbUKGTfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 14:35:13 -0500
Date: Mon, 8 Nov 2004 06:30:07 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Adam Litke <agl@us.ibm.com>,
       Andy Whitworth <apw@shadowen.org>
Subject: Re: [RFC] Consolidate lots of hugepage code
Message-ID: <20041107193007.GC16976@krispykreme.ozlabs.ibm.com>
References: <20041029033708.GF12247@zax> <20041029034817.GY12934@holomorphy.com> <20041107172030.GA16976@krispykreme.ozlabs.ibm.com> <20041107192024.GM2890@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107192024.GM2890@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> It's all pretty obvious. The first is checking page size vs. cache size
> and whether it's VI or does anything unusual; thus far things look
> hopeful that flush_dcache_page() analogues are unnecessary. More
> information about Super-H is needed to wrap up what will probably be no
> more than an audit. 

Good to hear.

> The second is a triplefault on x86-64 under some
> condition involving a long-running database regression test. There has
> obviously been considerably less progress there in no small part due to
> the amount of time required to reproduce the issue.

OK. We have not seen a similar issue on ppc64 even with extensive
testing (although with HPC apps). The question is how long we should
hold off on further hugetlb development waiting for this one bug report
on a single architecture to be chased.

Anton
