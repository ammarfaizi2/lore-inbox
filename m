Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWCZCVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWCZCVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 21:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWCZCVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 21:21:42 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:5982 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751208AbWCZCVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 21:21:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sqJREtOg7LJgZJeuUm0vPgOHZO58HTqn4qVj9aYwEFMmL7e1CjgyfzZ6NmWvpAhRY5yEe3vHyA3B2ttWicEm1Af6UpJboHq7iLZptB7KvlMB786uTUytPHQ5o0ZYx0FAapsZJITdDDB8g8WN/DnesWxSkOjnotfBLksMo8ETCgs=  ;
Message-ID: <4425FAB0.70909@yahoo.com.au>
Date: Sun, 26 Mar 2006 12:21:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Question on build_sched_domains
References: <20060324025834.GD8903@in.ibm.com> <20060324071255.GB22150@in.ibm.com> <4423A391.4000301@yahoo.com.au> <20060325083619.GC17011@in.ibm.com>
In-Reply-To: <20060325083619.GC17011@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Fri, Mar 24, 2006 at 06:45:21PM +1100, Nick Piggin wrote:
> 
>>Yeah I think what's happening is that the sched groups structures
>>are not shared between nodes. (It's been a while since I looked at
>>this code, and it is a bit tricky to follow).
> 
> 
> Its really odd that sched group structure aren't shared between nodes in some 
> case (sched_group_nodes) and are shared in other cases (sched_group_cpus, 
> sched_group_core, sched_group_phys).
> 
> Also is the GFP_ATOMIC allocation really required (for
> sched_group_nodes) in build_sched_domains()?
> 

I don't see why. It should be changed to GFP_KERNEL.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
