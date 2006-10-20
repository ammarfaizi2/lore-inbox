Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992628AbWJTOw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992628AbWJTOw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992629AbWJTOw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:52:57 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:16750 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S2992628AbWJTOw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:52:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2lyYR0JpEebGta37hrsI9IvTKCMTNs/F4UfOWs7SAVDcXxv8zyGv8O0KsifFkEzPt1cBoQTQXMsnC52slLxArrNJS0x+GJIBt7Od3xh4EEvQAFD3Ek0pOD2BL8EYggvzaSQvHzhABLXmn7pt+IaFQgosCdfISwEcX0zUn2chh6c=  ;
Message-ID: <4538E2C2.8060307@yahoo.com.au>
Date: Sat, 21 Oct 2006 00:52:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>	<453750AA.1050803@yahoo.com.au>	<20061019105515.080675fb.pj@sgi.com>	<4537BEDA.8030005@yahoo.com.au>	<20061019115652.562054ca.pj@sgi.com>	<4537CC1E.60204@yahoo.com.au> <20061019203744.09b8c800.pj@sgi.com> <453882AC.3070500@yahoo.com.au>
In-Reply-To: <453882AC.3070500@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> set_cpus_allowed is a feature of the scheduler that allows you to
> restrict one task to a subset of all cpus. Right?
> 
> And cpusets uses this interface as the mechanism to implement the
> semantics which the user has asked for. Yes?
> 
> sched-domains partitioning is a feature of the scheduler that
> allows you to restrict zero or more tasks to the partition, and
> zero or more tasks to the complement of the partition. OK?
> 
> So if you have a particular policy you need to implement, which is
> one cpus_exclusive cpuset off the root, covering half the cpus in
> the system (as a simple example)... why is it good to implement
> that with set_cpus_allowed and bad to implement it with partitions?
> 
> Or, another question, how does my patch hijack cpus_allowed? In
> what way does it change the semantics of cpus_allowed?

That should be, in what way does it change the semantics of cpusets
in any way?

IOW, how could a user possibly notice or care that partitions are
being used to implement a given policy? (apart from the fact that
the balancing will work better).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
