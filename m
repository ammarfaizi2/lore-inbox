Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVLLGVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVLLGVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 01:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVLLGVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 01:21:43 -0500
Received: from mx1.suse.de ([195.135.220.2]:19886 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751153AbVLLGVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 01:21:43 -0500
Date: Mon, 12 Dec 2005 07:21:42 +0100
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-ID: <20051212062141.GB11190@wotan.suse.de>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com> <20051212032902.GW11190@wotan.suse.de> <20051211221110.f94ec92a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211221110.f94ec92a.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 10:11:10PM -0800, Paul Jackson wrote:
> > Thanks. But i guess it would be still a good idea to turn
> > ia "check that there is no cpuset" test into an inline
> > so that it can be done without a function call. 
> 
> Do you mean this check, in cpuset_update_task_memory_state()
> 
>         if (unlikely(!cs))
>                 return;

No - i mean a quick check if the cpuset allows all nodes
for memory allocation.

-Andi
