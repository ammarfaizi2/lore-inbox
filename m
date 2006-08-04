Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWHDOva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWHDOva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWHDOva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:51:30 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:42962 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161251AbWHDOv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:51:29 -0400
Message-ID: <44D35EB7.4000700@in.ibm.com>
Date: Fri, 04 Aug 2006 20:20:31 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: vatsa@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Sam Vilain <sam@vilain.net>,
       linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [ RFC, PATCH 1/5 ] CPU controller - base changes
References: <20060804050753.GD27194@in.ibm.com> <20060804050932.GE27194@in.ibm.com> <44D35AD8.2090506@sw.ru>
In-Reply-To: <44D35AD8.2090506@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> Srivatsa,
> 
> AFAICS, you wanted to go the way we used in OpenVZ - 2-level scheduling.
> However, you don't do any process balancing between runqueues taking 
> into account
> other groups.

The plan is to do load balancing using the smpnice feature, which is yet to be 
worked on

 From vatsa's comments

	"Works only on UP for now (boot with maxcpus=1). IMO group-aware SMP
	 load-balancing can be met using smpnice feature. I will work on this
	 feature next."

> What do you think about a full runqueue virtualization, so that
> first level CPU scheduler could select task-group on any basis and then
> arbitrary runqueue was selected for running?

The patch selects the task group first, based on priority. From the patch

"+    /* Pick a task group first */
+#ifdef CONFIG_CPUMETER "

Did I miss something?

> 
> Thanks,
> Kirill
> P.S. BTW, this patch doesn't allow hierarchy in CPU controler.
> 


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
