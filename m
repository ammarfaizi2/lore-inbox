Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWFSDbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWFSDbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 23:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWFSDbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 23:31:25 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:19949 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S1751089AbWFSDbZ (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 23:31:25 -0400
Message-Id: <5.1.1.5.2.20060619124345.0335fda0@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 19 Jun 2006 13:31:12 +1000
To: Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Re: New Metrics to measure Load average
Cc: linux-Kernel@vger.kernel.org
In-Reply-To: <20060617100415.07a040de.akpm@osdl.org>
References: <4492D948.8090300@in.ibm.com>
 <5.1.1.5.2.20060616110033.04483890@brain.sedal.usyd.edu.au>
 <4492D948.8090300@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Hi Nagar,

Thanks for your reply and for your time.

Few years ago the few additions I have explained, have been implemented in 
linux 2.4.18 kernel at  the Sydney Uni as part of a large research project.

Also few years ago I have posted many posts about this topic to this 
forum.  Few very experience hands  were advising me in coding at that time. 
To prove this I have all the e-mails with me. Yet then I had not explained 
to this forum about the research project which involved prediction 
algorithm as then it had not been published.

Thereafter few research papers have been published with regard to this. 1 
in US.

Currently I am preparing the changes to a more recent linux patch.

In fact my question in the post was about performance testing after the 
changes being done.

--2) Now about the tests
--As I have documented all this yet need to perform some standard tests for 
the sake of completion.
--What tests should I carry out to prove that the system is still intact?
--
--Please tell me whether the below is correct?

--(a) As suggested by the http://kernel-perf.sourceforge.net/ the lmbench 
and re-aim-7 test packages can be used to test the ----performance of the 
kernel before making changes and after. (Not done as yet)

--(-b) Further tests have been carried out to check the response time of 
short tasks before making changes and after making --changes. The results 
indicated that there was no difference in the response time after 
introducing the changes to the kernel (done)

---(c) Thereafter the tests have been carried out to check the runtime of 
long tasks before and after making changes. The results of the tests 
revealed that there is no change in reported runtime in both occasions.(done)


Thanks
Sena Seneviratne
Computer Engineering Lab
School of Electrical and Information Engineering
Sydney University
Australia



At 10:04 AM 6/17/2006 -0700, you wrote:
>On Fri, 16 Jun 2006 21:46:08 +0530
>Balbir Singh <balbir@in.ibm.com> wrote:
>
> > I think it is easier to make the changes to be per-task and then in
> > user-space account all information for the user (using the per-task data).
>
>Yes please try to do this.  There are all sorts of ways in which we could
>combine these stats on behalf of a particular application scenario.  Each
>scheme involves some sort of data loss, so each application needs new code
>to get the information which _it_ wants.
>
>We really should work on presenting the relevant information to userspace
>in a complete, efficient and un-post-processed manner so that
>application-specific userspace code can combine it in the manner which it
>desires.
>
>Balbir's new code (in -mm) is supposed to be the basis of _all_ new
>per-task accounting, so you should look at what additional information is
>needed and then find a way to transport it to userspace via Balbir's
>proposed framework, thanks.

