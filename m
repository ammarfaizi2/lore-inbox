Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWCXC7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWCXC7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 21:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWCXC7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 21:59:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30948 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751526AbWCXC7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 21:59:12 -0500
Date: Fri, 24 Mar 2006 08:28:34 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Question on build_sched_domains
Message-ID: <20060324025834.GD8903@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,
	I was going thr' build_sched_domains and had a question
regarding formation of sched_groups for NUMA nodes. There are two 'for'
loops, each loop possibly allocating memory (sched_group) for one or more nodes.
My question is: in the outer loop, don't we need to skip allocating for
nodes for whom the inner loop has allocated in an earlier pass?

Taking the example of 4 node system which are in the same
sched_domain_node_span(), I see that we end up allocating 16
times (when 4 would have sufficed?).

What am I missing here? 

-- 
Regards,
vatsa
