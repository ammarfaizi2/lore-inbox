Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVHYALJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVHYALJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVHYALJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:11:09 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:8287 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932403AbVHYALG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:11:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XHQgZHkY4oZAIFh6dQ4G0o4W7BjxQJuXjT5uaTQNdB1Qw8kxIwb07Zv7CyB/I0mh7pCWobD1jn8H2veV2I8rEPKhRgfDeJata5uZrUuBNSRjMt2NPCCxfpPrPNAClpJkc7sYbJtwcdtxHOJ7yQjr9AsL3NNBo+3Itwf4CwOpCxg=  ;
Message-ID: <430D0A95.30208@yahoo.com.au>
Date: Thu, 25 Aug 2005 10:02:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: dino@in.ibm.com, paulus@samba.org, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, hawkes@sgi.com
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix
References: <20050824111510.11478.49764.sendpatchset@jackhammer.engr.sgi.com>	<20050824112640.GB5197@in.ibm.com>	<20050824044648.66f7e25a.pj@sgi.com>	<430C617E.8080002@yahoo.com.au> <20050824133107.2ca733c3.pj@sgi.com>
In-Reply-To: <20050824133107.2ca733c3.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> So long as the cpuset code stops making any calls to partition_sched_domains()
> whatsoever, then we should be back where we were in 2.6.12, so far as the
> scheduler is concerned - right?
> 

That's right - sorry I just meant disabling the dynamic sched
domains behaviour of the cpu_exclusive cpusets.

> I hope that the following (untested, unbuilt) patch, that I suggested
> in my "Mon, 22 Aug 2005 13:38:23 -0700" message best meets you
> suggestion above ... and I quote:
> 

I apologise, I missed that patch you sent. I think it looks OK,
and that it looks like what I was thinking about.

We need to revert to a stable behaviour, however we can't risk
major surgery to get there.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
