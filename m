Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270654AbTHAT3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270655AbTHAT3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:29:14 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:22678
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S270654AbTHAT3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:29:12 -0400
Message-ID: <3F2ABF7E.4060006@candelatech.com>
Date: Fri, 01 Aug 2003 12:29:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: Stephen Anthony <stephena@cs.mun.ca>, linux-kernel@vger.kernel.org
Subject: Re: What's the timeslice size for kernel 2.6.0-test2, IA32?
References: <200308011404.46886.stephena@cs.mun.ca> <20030801183450.GC20001@mark.mielke.cc>
In-Reply-To: <20030801183450.GC20001@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> On Fri, Aug 01, 2003 at 02:04:46PM -0230, Stephen Anthony wrote:
> 
>>It would be great if sleeps were 1ms accurate instead of 10ms.  It would 
>>make synchronization code a lot easier.
> 
> 
> Doesn't this depend on what HZ you define for the kernel?
> 
> If you want 1ms sleep, just set HZ to 1000HZ+, and give your process a
> high priority?
> 
> mark
> 

 From user space, at least, you can configure /dev/rtc to 1024HZ and then
select on it's file descriptor.  That will give you fairly reliable 1ms (or so)
sleeps, especially if you set your niceness to a high-priority setting.

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


