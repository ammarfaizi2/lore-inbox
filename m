Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWCXHp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWCXHp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWCXHp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:45:29 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:49280 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751575AbWCXHp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:45:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Zeg5+MhZcpWc8EJFF6MQ5Gf81o7JipNPIyIgFDd2w369pSVXk9yd3Z/czlLb9x4kf8+VYENpI1AUlQtQgZ8pJkXwW4GJPEIB0dS96waS3QoM4r2l/Pej/g7Z6iE7D3EZYJGIu4YbWACawLswHAnb+i3iB00RRBFnHZdDkg4j+uo=  ;
Message-ID: <4423A391.4000301@yahoo.com.au>
Date: Fri, 24 Mar 2006 18:45:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Question on build_sched_domains
References: <20060324025834.GD8903@in.ibm.com> <20060324071255.GB22150@in.ibm.com>
In-Reply-To: <20060324071255.GB22150@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Fri, Mar 24, 2006 at 08:28:34AM +0530, Srivatsa Vaddagiri wrote:
> 
>>Taking the example of 4 node system which are in the same
>>sched_domain_node_span(), I see that we end up allocating 16
>>times (when 4 would have sufficed?).
> 
> 
> Maybe this is it to avoid touching same memory from different nodes?
> 

Yeah I think what's happening is that the sched groups structures
are not shared between nodes. (It's been a while since I looked at
this code, and it is a bit tricky to follow).

Aside, it should be using kmalloc_node now...

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
