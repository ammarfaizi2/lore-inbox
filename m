Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWFRGL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWFRGL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 02:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWFRGL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 02:11:26 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:16997 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751099AbWFRGLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 02:11:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jY/MdpcXhsvH4YXPppH0ZTdQUgn/FVULAbYSxUMs6aD1lHusJfSMKZzzRxjtgPx8ns+iWWxEWhf5RhIPppvbf6j47x9x+rUnQE4sqqQoHyrrEXEBkyyiFV3WLNEMGg/PDbBJoXNdkL6/QZ36oo+sZka5nN0lpkHX1exSxvV8sfg=  ;
Message-ID: <4494EE86.7090209@yahoo.com.au>
Date: Sun, 18 Jun 2006 16:11:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: vatsa@in.ibm.com, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net>
In-Reply-To: <4494EA66.8030305@vilain.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Nick Piggin wrote:
> 
>>> I think a proportional-share scheduler (which is what a CPU controller
>>> may provide) has non-container uses also. Do you think nice (or sched 
>>> policy) is enough to, say, provide guaranteed CPU usage for 
>>> applications or limit their CPU usage? Moreover it is more flexible 
>>> if guarantee/limit can be specified for a group of tasks, rather than 
>>> individual tasks even in
>>> non-container scenarios (like limiting CPU usage of all web-server 
>>> tasks togther or for limiting CPU usage of make -j command).
>>>
>>
>> Oh, I'm sure there are lots of things we *could* do that we currently 
>> can't.
>>
>> What I want to establish first is: what exact functionality is 
>> required, why, and by whom.
> 
> 
> You make it sound like users should feel sorry for wanting features 
> already commonly available on other high performance unix kernels.

If telling me what exact functionality they want is going to cause them
so much pain, I suppose they should feel sorry for themselves.

And I don't care about any other kernels, unix or not. I care about what
Linux users want.

> 
> The answer is quite simple, people who are consolidating systems and 
> working with fewer, larger systems, want to mark processes, groups of 
> processes or entire containers into CPU scheduling classes, then either 
> fair balance between them, limit them or reserve them a portion of the 
> CPU - depending on the user and what their requirements are. What is 
> unclear about that?
> 

It is unclear whether we should have hard limits, or just nice like
priority levels. Whether virtualisation (+/- containers) could be a
good solution, etc.

If you want to *completely* isolate N groups of users, surely you
have to use virtualisation, unless you are willing to isolate memory
management, pagecache, slab caches, network and disk IO, etc.

> Yes, this does get somewhat simpler if you strap yourself into a 
> complete virtualisation straightjacket, but the current thread is not 
> about that approach - and the continual suggestions that we are all just 
> being stupid and going about it the wrong way are locally off-topic.

I'm sorry you cannot come up with a statement of the functionality you
require without badmouthing "complete" virtualisation or implying that
I'm saying you're stupid.

I think the containers people might also recognise that it may not be
the best solution to make containers the be all and end all of
consolidating systems, and virtualisation is a very relevant topic when
discussing pros and cons and alternate solutions.

But at this point I'm yet to be shown what the *problem* is. I'm not
trying to deny that one might exist.

> 
> Bear in mind that we have on the table at least one group of scheduling 
> solutions (timeslice scaling based ones, such as the VServer one) which 
> is virtually no overhead and could potentially provide the "jumpers" 
> necessary for implementing more complex scheduling policies.

Again, I don't care about the solutions at this stage. I want to know
what the problem is. Please?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
