Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWFBJel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWFBJel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWFBJel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:34:41 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:55484 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751360AbWFBJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:34:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 19:34:26 +1000
User-Agent: KMail/1.9.1
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
References: <000101c68627$4866eff0$0c4ce984@amr.corp.intel.com>
In-Reply-To: <000101c68627$4866eff0$0c4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021934.27420.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 19:31, Chen, Kenneth W wrote:
> Con Kolivas wrote on Friday, June 02, 2006 2:25 AM
>
> > On Friday 02 June 2006 19:17, Chen, Kenneth W wrote:
> > > What about the part in dependent_sleeper() being so bully and actively
> > > resched other low priority sibling tasks?  I think it would be better
> > > to just let the tasks running on sibling CPU to finish its current time
> > > slice and then let the backoff logic to kick in.
> >
> > That would defeat the purpose of smt nice if the higher priority task
> > starts after the lower priority task is running on its sibling cpu.
>
> But only for the duration of lower priority tasks' time slice.  When lower
> priority tasks time slice is used up, a resched is force from
> scheduler_tick(), isn't it?  And at that time, it is delayed to run because
> of smt_nice.  You are saying user can't tolerate that short period of time
> that CPU resource is shared?  It's hard to believe.

nice -20 vs nice 0 is 800ms vs 100ms. That's a long time to me.

-- 
-ck
