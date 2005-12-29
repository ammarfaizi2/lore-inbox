Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbVL2IWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVL2IWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVL2IWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:22:10 -0500
Received: from smtp110.plus.mail.mud.yahoo.com ([68.142.206.243]:41837 "HELO
	smtp110.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965051AbVL2IWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:22:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AF/mnRYGKvygI61bI7mn6GdIKMyVuyxmXHBwZO4X1dSJnUaVQn/+YBw1RWmwQ3NZVeA/w5Sa1DNdabpZcUl81H6Mm/jUjC/SgAmbxma2rxC6Oh2lKrJ57nCJ0IYvkQU8gpR8vZX1Mm+WlKzjPVQRXLsWU2C500Gs/dBjquUp98E=  ;
Message-ID: <43B39CAD.9040002@yahoo.com.au>
Date: Thu, 29 Dec 2005 19:22:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] CPU scheduler: Simplified interactive bonus mechanism
References: <43B22FBA.5040008@bigpond.net.au> <200512281735.00992.kernel@kolivas.org> <43B242F4.3050004@yahoo.com.au> <43B35D43.40902@bigpond.net.au>
In-Reply-To: <43B35D43.40902@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Nick Piggin wrote:

>> Back on topic: I don't think that this patch isn't clearly
> 
> 
> I assume that the double negative here is accidental and you mean that 
> this scheduler isn't clearly better than the current one.
> 

Yep.

>> better than what currently exists, nor would require less
>> testing than any other large scale changes to the scheduler
>> behaviour.
>>
>> So, as Con seems to imply, it is JASW (just another scheduler
>> rewrite).
> 
> 
> Not a rewrite just some major surgery to one small part (at least when 
> compared to nicksched, staircase and the SPA schedulers).  This doesn't 
> effect the run queue structure or the load balancing mechanisms.  Or, 

Well, the runqueue structure is the "easy" part of it. And load balancing
should not be changed at all[*] by any of these things because we are talking
about a per-CPU runqueue model.

[*] Apart from obvious and really hard to analyse things like which task is
     actually running at a point in time, and changing the cache-hotness of
     things...

> for that matter, even the bonus mechanism itself other than the 
> calculation of the bonus as the way the bonus is applied once calculated 
> is unchanged.
> 

OK maybe it isn't as large scale a change as one of the rewrites, however
it still is going to probably wildly change behaviour of situations outside
the little box you analysed and found it to be an improvement for.

But points to you for experimenting and trying new things. Don't let me
put you off because I'm not much of an expert on ingosched so it may not
be as large a change as I'm making it out to be.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
