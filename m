Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266916AbUGMWPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266916AbUGMWPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267163AbUGMWPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:15:17 -0400
Received: from mail.tmr.com ([216.238.38.203]:37644 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266916AbUGMWO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:14:56 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption
   Patch
Date: Tue, 13 Jul 2004 18:17:07 -0400
Organization: TMR Associates, Inc
Message-ID: <cd1mj9$3ft$1@gatekeeper.tmr.com>
References: <1089677823.10777.64.camel@mindpipe><1089677823.10777.64.camel@mindpipe> <40F3E31D.9020504@gardena.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1089756585 3581 192.168.12.100 (13 Jul 2004 22:09:45 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <40F3E31D.9020504@gardena.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Senoner wrote:
> Lee Revell wrote:
> 
>> On Mon, 2004-07-12 at 19:31, Andrew Morton wrote:
>>  
>>
>>>
>>> OK, thanks.  The problem areas there are the timer-based route cache
>>> flushing and reiserfs.
>>>
>>> We can probably fix the route caceh thing by rescheduling the timer 
>>> after
>>> having handled 1000 routes or whatever, although I do wonder if this 
>>> is a
>>> thing we really need to bother about - what else was that machine up to?
>>>
>>>   
>>
>>
>> Gnutella client.  Forgot about that.  I agree, it is not reasonable to
>> expect low latency with this kind of network traffic happening.  I am
>> impressed it worked as well as it did.
>>  
>>
> 
> Why not reasonable ? It is very important that networking and HD I/O 
> both don't interfere with low latency audio.
> Think about large audio setups where you use PC hardware to act as 
> dedicated samplers, software synthesizers etc.
> Such clusters might be diskless and communicate with a GBit ethernet 
> with a high performance file server and
> in some cases lots of network I/O might occur during audio playback. So 
> having latency spikes during network I/O
> would be a big showstopper for many apps in certain setups.
> Even ardour if run on a diskless client would need low latency while 
> doing network I/O because it does lots of disk I/O
> which on the diskless client translate to lots of network I/O.
> Typical use could be educational or research institutions where diskless 
> clients drastically lower the cost of managing large number
> of boxes and allow sharing of resources. See the LTSP project.

Having used "diskless" systems off and on for almost two decades, I 
highly suggest that you are better off with a disk in the node, and use 
that for swap and temp. If you place any value on the time of people, 
this will eliminate a lot of performance (time and bandwidth) issues, 
and usually save on the cost of managing, since you have nothing to 
manage on the node and a lot less network traffic to handle.

I've done it with SunOS, Solaris and Linux.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
