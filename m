Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWBYBQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWBYBQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 20:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWBYBQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 20:16:28 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:20410 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964833AbWBYBQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 20:16:28 -0500
Message-ID: <43FFAFE9.8000206@bigpond.net.au>
Date: Sat, 25 Feb 2006 12:16:25 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: MIke Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, kernel@kolivas.org, nickpiggin@yahoo.com.au,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
References: <1140183903.14128.77.camel@homer>	<1140812981.8713.35.camel@homer> <20060224141505.41b1a627.akpm@osdl.org>
In-Reply-To: <20060224141505.41b1a627.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omtas01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 25 Feb 2006 01:11:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> MIke Galbraith <efault@gmx.de> wrote:
> 
>>Not many comments came back, zero actually.
>>
> 
> 
> That's because everyone's terribly busy chasing down those final bugs so we
> get a really great 2.6.16 release (heh, I kill me).
> 
> I'm a bit reluctant to add changes like this until we get the smpnice stuff
> settled down and validated.  I guess that means once Ken's run all his
> performance tests across it.
> 
> Of course, if Ken does his testing with just mainline+smpnice then any
> coupling becomes less of a problem.  But I would like to see some feedback
> from the other sched developers first.

Personally, I'd rather see PlugSched merged in and this patch be used to 
create a new scheduler inside PlugSched.  But I'm biased :-)

As I see it, the problem that this patch is addressing is caused by the 
fact that the current scheduler is overly complicated.  This patch just 
makes it more complicated.  Some of the schedulers in PlugSched already 
handle this problem adequately and some of them are simpler than the 
current scheduler -- the intersection of these two sets is not empty.

So now that it's been acknowledged that the current scheduler has 
problems, I think that we should be looking at other solutions in 
addition to just making the current one more complicated.

Peter
PS I agree this should wait until the current scheduler changes in -mm 
have had a chance to settle down and/or migrate to the vanilla kernel.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
