Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWFRFym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWFRFym (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 01:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWFRFym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 01:54:42 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:32165 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750987AbWFRFyl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 01:54:41 -0400
Message-ID: <4494EA66.8030305@vilain.net>
Date: Sun, 18 Jun 2006 17:53:42 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: vatsa@in.ibm.com, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au>
In-Reply-To: <4494DF50.2070509@yahoo.com.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
>> I think a proportional-share scheduler (which is what a CPU controller
>> may provide) has non-container uses also. Do you think nice (or sched 
>> policy) is enough to, say, provide guaranteed CPU usage for 
>> applications or limit their CPU usage? Moreover it is more flexible 
>> if guarantee/limit can be specified for a group of tasks, rather than 
>> individual tasks even in
>> non-container scenarios (like limiting CPU usage of all web-server 
>> tasks togther or for limiting CPU usage of make -j command).
>>
>
> Oh, I'm sure there are lots of things we *could* do that we currently 
> can't.
>
> What I want to establish first is: what exact functionality is 
> required, why, and by whom.

You make it sound like users should feel sorry for wanting features 
already commonly available on other high performance unix kernels.

The answer is quite simple, people who are consolidating systems and 
working with fewer, larger systems, want to mark processes, groups of 
processes or entire containers into CPU scheduling classes, then either 
fair balance between them, limit them or reserve them a portion of the 
CPU - depending on the user and what their requirements are. What is 
unclear about that?

Yes, this does get somewhat simpler if you strap yourself into a 
complete virtualisation straightjacket, but the current thread is not 
about that approach - and the continual suggestions that we are all just 
being stupid and going about it the wrong way are locally off-topic.

Bear in mind that we have on the table at least one group of scheduling 
solutions (timeslice scaling based ones, such as the VServer one) which 
is virtually no overhead and could potentially provide the "jumpers" 
necessary for implementing more complex scheduling policies.

Sam.

> Only then can we sanely discuss the fitness of solutions and propose 
> alternatives, and decide whether to merge.

