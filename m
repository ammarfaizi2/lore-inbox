Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbUDOQWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbUDOQWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:22:54 -0400
Received: from mail.tmr.com ([216.238.38.203]:6919 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264343AbUDOQWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:22:52 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Benchmarking objrmap under memory pressure
Date: Thu, 15 Apr 2004 12:23:36 -0400
Organization: TMR Associates, Inc
Message-ID: <c5mcoc$s9l$1@gatekeeper.tmr.com>
References: <20040414233931.GU2150@dualathlon.random> <Pine.LNX.4.44.0404151050370.6938-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1082046028 28981 192.168.12.100 (15 Apr 2004 16:20:28 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.44.0404151050370.6938-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>>Last but not the least, you cannot know if any important app is going to
>>be hurted with mremap doing copies and invalidating important
>>optimizations for any application doing similar things that kde is doing
>>to save memory and speedup startup times (we don't even know yet if kde
>>itself is going to be hurted), you can take these risks with mainline, I
>>cannot risk with -aa, and anon-vma provides other minor benefits too
>>that we already discussed plus the IMHO important scalability point above.
> 
> 
> You're on shakier ground there.
> 
> The worst that will happen with anonmm's mremap move, is that some
> app might go slower and need more swap.  Unlikely, but agreed possible.

It appears that users on small memory machines running kde are not of 
concern to you. Unfortunately that describes a fair number of people, 
not everyone has the big memory fast system. I will try to get some 
reproducible numbers, but "consistently feels faster" is a reason to 
keep running -aa even if I can't quantify it.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
