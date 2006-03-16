Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752165AbWCPEqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbWCPEqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 23:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbWCPEqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 23:46:19 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:15957 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752165AbWCPEqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 23:46:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qwLt/UsaxydyI+mnHNYjBD8gN2Lrg8mAIrj0g9XyB7XOTji1mOfE6GRzO10Duj2mIyOg9dUodfZihOtO+5BXRpXiTK/l19Sm7g+sn9R82GJhFCOrI9ZzKSGpf5IskyQyNYnOogxGbPnxjK/lG9IjuAZ9Y4DSp8Cw0bG210akP3w=  ;
Message-ID: <4418E4D8.1020603@yahoo.com.au>
Date: Thu, 16 Mar 2006 15:08:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines for_each_possible_cpu
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>	<4418DEEA.2000008@yahoo.com.au> <20060315195537.0a039f64.akpm@osdl.org>
In-Reply-To: <20060315195537.0a039f64.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>for_each_cpu() effectively is for_each_possible_cpu() as far as
>>generic code is concerned. In other words, nobody would ever expect
>>for_each_cpu to return an _impossible_ CPU, thus you are just
>>adding a redundant element to the name.
> 
> 
> We've had various screwups and confusions with these things.  I think the
> new naming is good - it makes developers _think_ before they use it. 
> Instead of "I want to touch all the CPUs, gee that looks right" they'll
> have to stop and decide whether they want to access the online, possible or
> present ones and then they'll (hopefully) have a little think about what
> happens when CPUs migrate between those states.
> 
> 

I think screwups probably came from unclear documentation (which it was
until recently, and some implementations were plain wrong IIRC), and the
recentish introduction of cpu hotplug.

I don't see the point in this though. If people don't want to even think
about these issues, then this change isn't going to make them.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
