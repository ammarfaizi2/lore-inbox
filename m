Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWH1C2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWH1C2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 22:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWH1C2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 22:28:25 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:28072 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S932343AbWH1C2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 22:28:24 -0400
Message-Id: <5.1.1.5.2.20060828120653.03334040@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 28 Aug 2006 12:29:10 +1000
To: Peter Williams <pwil3058@bigpond.net.au>
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Re: Fwd: Re: New Metrics to measure Load average
Cc: fekete@cs.usyd.edu.au, david Levy <dlevy@ee.usyd.edu.au>,
       balbir@in.ibm.com, nagar@watson.ibm.com, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <44F24DF6.3000001@bigpond.net.au>
References: <5.1.1.5.2.20060828105624.033aecc8@brain.sedal.usyd.edu.au>
 <5.1.1.5.2.20060828105624.033aecc8@brain.sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Currently we are on our own. For my PhD I only need to separate the CPU and 
Disk loads according to the  login user.
Previously as you too suggested I need to refine it. I will refine it with 
Balbir Singh and Naga's work. In fact this IBM team  is splitting and 
measuring resources  per task level.

Yes I have read the early papers on their CKRM or Control frame as well. In 
those they were talking about some class base measuring system. Certainly 
this for the controller.

But currently I am only interested in "per task delay accounting" which 
were posted to kernel group since 2005 December. In this regard both Balbir 
Singh and Shailabh Naga have done a good job. Also there is avenue to build 
on their work.

Thanks
Sena Seneviraten
School of Electrical and Information Engineering
Sydney University
Australia



At 11:59 AM 8/28/2006 +1000, you wrote:
>sena seneviratne wrote:
>>Dear Sir,
>>Dr Fekete,
>>Few months ago I had some correspondence through 
>>"inux-kernel@vger.kernel.org"  working group.
>>(1) I am forwarding one of the last correspondence with this IBM team.
>>As they are from IBM and it looks a rather general project, I agreed to 
>>incorporate/build on with them in the future.
>>This is where we concluded and agreed yet before that we had few e-mails.
>>Currently for the Phd, I am using division of load as per login users and 
>>this is what I want to have for HPC and for the "Task Profiling Model".
>>  They have done something in general at the task level. I will see how I 
>> can use theirs or what changes I need to add on top of theirs. This will 
>> happen after finishing the Phd. I will install their Linux patch and 
>> test it first.
>
>OK.  Be very wary if their planned CPU controller as the model that they 
>intend to use (i.e. allocating different time slices) will only work with 
>CPU bound processes.
>
>>(2) Other work done by the researchers from  Computer Science was also 
>>involved the measuring resources,  yet they have not introduced any 
>>metric as such and therefore there is no overlapping with our project. 
>>Their main concern was changing the internal scheduler.
>>Thanks
>>Sena Seneviratne
>>Computer Engineering Lab
>>School of Electrical and Information Engineering
>>Sydney University
>>
>>>Date: Tue, 20 Jun 2006 14:29:14 +0530
>>>From: Balbir Singh <balbir@in.ibm.com>
>>>Reply-To: balbir@in.ibm.com
>>>Organization: IBM India Private Limited
>>>User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) 
>>>Gecko/20060413 Red Hat/1.7.13-1.4.1
>>>X-Accept-Language: en-us, en
>>>To: sena seneviratne <auntvini@cel.usyd.edu.au>
>>>Cc: vatsa@in.ibm.com, Shailabh Nagar <nagar@watson.ibm.com>
>>>Subject: Re: New Metrics to measure Load average
>>>
>>>sena seneviratne wrote:
>>>>Dear Balbir Singh,
>>>>Thanks for your valuable reply.
>>>>Balbir  It looks like that there is a general project where we all can 
>>>>incorporate our work.
>>>
>>>
>>>Yes it is. It is currently in -mm and we hope that it makes it into
>>>2.6.18. The folder Documentation/accounting contains all the necessary
>>>details for you to build on top of delay stats.
>>>
>>>
>>>>--How do you calculate disk load? Is it the
>>>>---number of uninterruptible tasks in the system?  Yes I started at 
>>>>that point
>>>>
>>>>Few years ago the few additions I have explained, have been implemented 
>>>>in linux 2.4.18 kernel at  the Sydney Uni as part of a large research project.
>>>>Also few years ago I have posted many posts about this topic to this 
>>>>forum.  Few very experience hands  were advising me in coding at that 
>>>>time. To prove this I have all the e-mails with me. Yet then I had not 
>>>>explained to this forum about the research project which involved 
>>>>prediction algorithm as then it had not been published.
>>>>Thereafter few research papers have been published with regard to this. 
>>>>1 in US.
>>>>Currently I am preparing the changes to a more recent linux patch. In 
>>>>fact this is not hard as I have already changed the previous linux 2.4.18.
>>>
>>>Please cc us when you post the patches.
>>>
>>>>Before coming to do research I had worked as a Senior software engineer 
>>>>in few companies and my last was LogicaCMG. Yet as far as the kernel 
>>>>programming is concerned I will ask for your comments and advice.
>>>
>>>Let us know if you need any help for coding on top of taskstats.
>>>
>>>>Thanks
>>>>Sena Seneviratne
>>>>Computer Engineering Lab
>>>>School of Electrical and Information Engineering
>>>>Sydney University
>>>>Australia
>
>Good luck,
>Peter
>--
>Peter Williams                                   pwil3058@bigpond.net.au
>
>"Learning, n. The kind of ignorance distinguishing the studious."
>  -- Ambrose Bierce

