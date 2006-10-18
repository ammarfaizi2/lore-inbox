Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWJROvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWJROvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWJROvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:51:37 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:23205 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161085AbWJROvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:51:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=D92Y0pGUU9iBMPE2Kj2lcgn5NJXgcopU+/kXx15nJXYxQKlh/ImaY04HCF84mR++gzDgnGSnh6L4BR23LewMWrkLcdXa7W9HrW9/6slwCpqQBLKP3avi8OIWugW+FRruPuEVf5AcxkFLfSeimXkS9wOZCJTe40wzFMBCx0Hk0DU=  ;
Message-ID: <45363F74.4090500@yahoo.com.au>
Date: Thu, 19 Oct 2006 00:51:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Paul Jackson <pj@sgi.com>, Robin Holt <holt@sgi.com>, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
References: <20061017192547.B19901@unix-os.sc.intel.com> <20061018001424.0c22a64b.pj@sgi.com> <20061018095621.GB15877@lnx-holt.americas.sgi.com> <20061018031021.9920552e.pj@sgi.com> <45361B32.8040604@yahoo.com.au> <20061018071447.A25760@unix-os.sc.intel.com>
In-Reply-To: <20061018071447.A25760@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Wed, Oct 18, 2006 at 10:16:50PM +1000, Nick Piggin wrote:
> 
>>Paul Jackson wrote:
>>
>>> 1) I don't know how to tell what sched domains/groups a system has, nor
> 
> 
> Paul, atleast for debugging one can know that by defining SCHED_DOMAIN_DEBUG

Yep. This is meant to be useful precisely for things like making cpusets
partition the domains properly or ensuring a system's topology is built
correctly.

>>>    how to tell my customers how to see what sched domains they have, and
>>
>>I don't know if you want customers do know what domains they have. I think
> 
> 
> At the first glance, I have to agree with Nick. All the customer wants is a
> mechanism to specify group these cpus together for scheduling...
> 
> But looking at how cpusets interact with sched-domains and especially for
> large systems, it will probably be useful if we export the topology through /sys

I'll concede that point. It would probably be useful for a sysadmin to be
able to look at how they can better make cpuset placements such that they
get the best partitioning.

I would still prefer not to say "use an exclusive domain for this cpuset".
cpusets should be able to do the optimal thing with the data it has, so
this is one less complication to deal with.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
