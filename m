Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbWJSIJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWJSIJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWJSIJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:09:58 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:32369 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751569AbWJSIJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:09:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XFv2CBb20EhKXwZecEppKcQdB/EPQtn8uaWurSLnRoTEywe6VIjVRjBicmWutbx6Cmxt24N2we18w1d+jF4SfrMLM2cpjP4cg6jWHmjjtFGd60A4ZHqSWOXMW+ggq+Npg1jEIk/04JAgj9RPLk8MQN86HoW16CQPJhpQfEB3qqQ=  ;
Message-ID: <453732CF.7050801@yahoo.com.au>
Date: Thu, 19 Oct 2006 18:09:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: suresh.b.siddha@intel.com, dino@in.ibm.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>	<20061017114306.A19690@unix-os.sc.intel.com>	<20061017121823.e6f695aa.pj@sgi.com>	<20061017190144.A19901@unix-os.sc.intel.com>	<20061018000512.1d13aabd.pj@sgi.com>	<45371D96.8060003@yahoo.com.au> <20061019000303.f9d883e4.pj@sgi.com>
In-Reply-To: <20061019000303.f9d883e4.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>You don't have to worry about the details of the hierarchy. You just need
>>to know where the partitions are
> 
> 
> Cpusets is a hierarchical space.  What happens in a subtree
> of the /dev/cpuset hierarchy should not be affecting others.
> 
> Partitioning sched domains is a flat space - dividing the
> CPUs of a system into disjoint partitions.
> 
> Using details deep in the cpuset hierarchy to define global
> partitions leads to chaos in the minds of those coming at
> this from the cpuset side.

So don't do it, then. Just do the partitioning for disjoint
cpusets off the root cpuset, if you like. Or don't use it at
all, even.

But please don't let *users* try to deal with it.

> The lack of any means on a production system to view the
> resulting partition leads to ignorance of how deep is the
> chaos, a dangerous state of affairs.

It is much less complex than cpusets, as you note it is a flat
space.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
