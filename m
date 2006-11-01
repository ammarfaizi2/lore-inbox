Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946642AbWKAHFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946642AbWKAHFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 02:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946652AbWKAHFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 02:05:46 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:8135 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1946642AbWKAHFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 02:05:45 -0500
Message-ID: <4548472A.50608@in.ibm.com>
Date: Wed, 01 Nov 2006 12:35:14 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>	<6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>	<4545FDCD.3080107@in.ibm.com>	<6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>	<454782D2.3040208@in.ibm.com> <6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>
In-Reply-To: <6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 10/31/06, Balbir Singh <balbir@in.ibm.com> wrote:
>> I am still a little concerned about how limit size changes will be implemented.
>> Will the cpuset "mems" field change to reflect the changed limits?
> 
> That's how we've been doing it - increasing limits is easy, shrinking
> them is harder ...
> 
>>> Page cache control is actually more essential that RSS control, in our
>>> experience - it's pretty easy to track RSS values from userspace, and
>>> react reasonably quickly to kill things that go over their limit, but
>>> determining page cache usage (i.e. determining which job on the system
>>> is flooding the page cache with dirty buffers) is pretty much
>>> impossible currently.
>>>
>> Hmm... interesting. Why do you think its impossible, what are the kinds of
>> issues you've run into?
>>
> 
> Issues such as:
> 
> - determining from userspace how much of the page cache is really
> "free" memory that can be given out to new jobs without impacting the
> performance of existing jobs
> 
> - determining which job on the system is flooding the page cache with
> dirty buffers
> 
> - accounting the active pagecache usage of a job as part of its memory
> footprint (if a process is only 1MB large but is seeking randomly
> through a 1GB file, treating it as only using/needing 1MB isn't
> practical).
> 
> Paul
> 

Thanks for the info!

I thought this would be hard to do in general, but with a page -->
container mapping that will come as a result of the memory controller,
will it still be that hard?

I'll dig deeper.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
