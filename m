Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWHaRFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWHaRFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWHaRFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:05:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:18093 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932389AbWHaRFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:05:11 -0400
X-Authenticated: #14349625
Subject: Re: A nice CPU resource controller
From: Mike Galbraith <efault@gmx.de>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Martin Ohlin <martin.ohlin@control.lth.se>,
       Peter Williams <pwil3058@bigpond.net.au>, balbir@in.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <44F707F5.4090008@nortel.com>
References: <44F5AB45.8030109@control.lth.se>
	 <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
	 <44F6365A.8010201@bigpond.net.au>
	 <1157007190.6035.14.camel@Homer.simpson.net>
	 <1157010140.18561.23.camel@Homer.simpson.net>
	 <44F6BB8A.7090001@control.lth.se>  <44F707F5.4090008@nortel.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 19:14:19 +0000
Message-Id: <1157051660.6288.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 10:01 -0600, Chris Friesen wrote:
> Martin Ohlin wrote:
> 
> > Maybe I am wrong, but as I see it, if one wants to control on a group 
> > level, then the individual shares within the group are not that 
> > important. If the individual share is important, then it should be 
> > controlled on a per-task level. Please tell me if I am wrong.
> 
> The individual share within the group may not be important, but the 
> relative priority might be.
> 
> 
> We have instances were we would like to express something like:
> 
> --these tasks are all grouped together as "maintenance" tasks, and 
> should be guaranteed 3% of the system together
> 	--within the maintenance tasks, my network heartbeat application is the 
> most latency sensitive, so I want it to be higher-priority than the 
> other maintenance tasks

The latency issue is hard.

>  From my point of view, task group cpu allocation and relative task 
> priority should be orthogonal.
> 
> First you pick a task group (based on cpu share, priority, etc.) then 
> within the group you pick the task with highest priority.
> 
> This was something that CKRM did right (IMHO).

I'd really like to see what Kiril's suggestion looks like.

	-Mike

