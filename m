Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWCYIg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWCYIg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 03:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWCYIg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 03:36:28 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:62897 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751109AbWCYIg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 03:36:28 -0500
Date: Sat, 25 Mar 2006 14:06:19 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Question on build_sched_domains
Message-ID: <20060325083619.GC17011@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060324025834.GD8903@in.ibm.com> <20060324071255.GB22150@in.ibm.com> <4423A391.4000301@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4423A391.4000301@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 06:45:21PM +1100, Nick Piggin wrote:
> Yeah I think what's happening is that the sched groups structures
> are not shared between nodes. (It's been a while since I looked at
> this code, and it is a bit tricky to follow).

Its really odd that sched group structure aren't shared between nodes in some 
case (sched_group_nodes) and are shared in other cases (sched_group_cpus, 
sched_group_core, sched_group_phys).

Also is the GFP_ATOMIC allocation really required (for
sched_group_nodes) in build_sched_domains()?

-- 
Regards,
vatsa
