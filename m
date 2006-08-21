Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWHUNyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWHUNyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbWHUNyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:54:46 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:10915 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030479AbWHUNyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:54:43 -0400
Date: Mon, 21 Aug 2006 15:54:30 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Anton Blanchard <anton@samba.org>
Cc: pj@sgi.com, simon.derr@bull.net, nathanl@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
In-Reply-To: <20060821132709.GB8499@krispykreme>
Message-ID: <Pine.LNX.4.61.0608211548260.13190@openx3.frec.bull.fr>
References: <20060821132709.GB8499@krispykreme>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/08/2006 15:59:49,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/08/2006 15:59:50,
	Serialize complete at 21/08/2006 15:59:50
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006, Anton Blanchard wrote:

> 
> Hi,
> 
> We have a bug report where sched_setaffinity fails for cpus that are
> hotplug added after boot. Nathan found this suspicious piece of code:
> 
> void __init cpuset_init_smp(void)
> {
>         top_cpuset.cpus_allowed = cpu_online_map;
>         top_cpuset.mems_allowed = node_online_map;
> }
> 
> Any reason we statically set the top level cpuset to the boot time cpu
> online map?
> 

Are you suggesting that all possible cpus should be in the top cpuset, 
instead of all existing cpus ?

I'd prefer the hotplugged CPUs being added to the top cpuset afterwards.

	Simon.

