Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVCHFl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVCHFl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVCHFl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:41:56 -0500
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:40877 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S261479AbVCHFkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:40:07 -0500
Message-ID: <422D3AB2.9020409@bigpond.net.au>
Date: Tue, 08 Mar 2005 16:40:02 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Matt Mackall <mpm@selenic.com>, paul@linuxaudiosystems.com, joq@io.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050112185258.GG2940@waste.org>	<200501122116.j0CLGK3K022477@localhost.localdomain>	<20050307195020.510a1ceb.akpm@osdl.org>	<20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org>
In-Reply-To: <20050307204044.23e34019.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> 
>>I think Chris Wright's last rlimit patch is more sensible and ready to
>> go.
> 
> 
> I must say that I like rlimits - very straightforward, although somewhat
> awkward to use from userspace due to shortsighted shell design.
> 
> Does anyone have serious objections to this approach?

I don't object to rlimits per se and I think that they are useful but 
not as a sole solution to this problem.  Being able to give a task 
preferential treatment is a permissions issue and should be solved as one.

Having RT cpu usage limits on tasks is a useful tool to have when 
granting normal users the privilege of running tasks as RT tasks so that 
you can limit the damage that they can do BUT the presence of a limit on 
a task is not a very good criterion for granting that privilege.

The granting of the ability to switch to and from RT mode should require 
a means to specify which users it applies to and also which programs it 
applies to.  The RT rlimits mechanism doesn't meet these criteria.

In summary, IMHO you should put them both in but modify the RT rlimits 
patch so that it plays no part in the decision as to whether the task is 
allowed to run as RT or not.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
