Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268230AbUG2QgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268230AbUG2QgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUG2QBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:01:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:17116 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267752AbUG2Pzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:55:32 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: Oops in find_busiest_group(): 2.6.8-rc1-mm1
Date: Thu, 29 Jul 2004 08:49:42 -0700
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Paul Jackson <pj@sgi.com>,
       haveblue@us.ibm.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@sgi.com>
References: <1089871489.10000.388.camel@nighthawk> <4108D349.1030209@yahoo.com.au> <20040729153510.GB1141@sgi.com>
In-Reply-To: <20040729153510.GB1141@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407290849.42271.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 29, 2004 8:35 am, Dimitri Sivanich wrote:
> Here's a patch to 2.6.8-rc2-mm1 that allows things to work:
>
> --- sched.c.old 2004-07-29 10:11:00.000000000 -0500
> +++ sched.c     2004-07-29 10:27:58.000000000 -0500
> @@ -3770,8 +3770,6 @@ __init static void arch_init_sched_domai
>                 cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
>
>  #ifdef CONFIG_NUMA
> -               if (i != first_cpu(sd->groups->cpumask))
> -                       continue;
>                 sd = &per_cpu(node_domains, i);
>                 group = cpu_to_node_group(i);
>                 *sd = SD_NODE_INIT;

Yep, this was a merge error.  I posted it as the first reply (f1rst p0st!) to 
Andrew's 2.6.8-rc2-mm1 announcement.  Sorry for the trouble, my last patch 
didn't include it, but there was some confusion since there were several 
fixes to the scheduler code posted to Nick's 'consolidate sched domains' 
thread.

Jesse
