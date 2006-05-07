Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWEGMdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWEGMdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 08:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWEGMdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 08:33:46 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:59751 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932137AbWEGMdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 08:33:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=JLlbihR24MXt9c+2ZpOikoK8jbE+XNsVd5v2ENOcFcomeQVvjvOaqTbd8+Ar0/4nkvX5Ml/u/0JMOvOoSGkAIUC2E86pX1ylq+KLYI7VXcKnN0ArebK60lJOUj+6n9T4TJrd385TraSam1d4qEirGvq4re12fM7wNcOVvZe3Mlk=  ;
Message-ID: <445DE925.9010006@yahoo.com.au>
Date: Sun, 07 May 2006 22:33:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Andi Kleen <ak@suse.de>, Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk>	 <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>	 <200605021859.18948.ak@suse.de>  <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer>
In-Reply-To: <1146640155.7526.27.camel@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Wed, 2006-05-03 at 03:07 +1000, Nick Piggin wrote:
> 
>>Other problem is that some people didn't RTFM and have started trying to
>>use it for precise accounting :(
> 
> 
> Are you talking about me perchance?  I don't really care about precision
> _that_ much, though I certainly do want to tighten timeslice accounting.

No, sched_clock is fine to be used in CPU scheduling choices, which are
heuristic anyway (although strictly speaking, even using it for timeslicing
within a single CPU could cause slight unfairness).

I'm talking about the update_cpu_clock() / task_struct->sched_time stuff.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
