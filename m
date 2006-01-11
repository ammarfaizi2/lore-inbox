Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030708AbWAKDGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030708AbWAKDGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWAKDGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:06:44 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:50857 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030708AbWAKDGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:06:43 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Wed, 11 Jan 2006 14:07:05 +1100
User-Agent: KMail/1.8.2
Cc: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <43C45BDC.1050402@google.com> <200601111249.05881.kernel@kolivas.org> <43C46F99.1000902@bigpond.net.au>
In-Reply-To: <43C46F99.1000902@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2051
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601111407.05738.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 01:38 pm, Peter Williams wrote:
> Con Kolivas wrote:
>  > I guess we need to check whether reversing this patch helps.
>
> It would be interesting to see if it does.
>
> If it does we probably have to wear the cost (and try to reduce it) as
> without this change smp nice support is fairly ineffective due to the
> fact that it moves exactly the same tasks as would be moved without it.
>   At the most it changes the frequency at which load balancing occurs.

I disagree. I think the current implementation changes the balancing according 
to nice much more effectively than previously where by their very nature, low 
priority tasks were balanced more frequently and ended up getting their own 
cpu. No it does not provide firm 'nice' handling that we can achieve on UP 
configurations but it is also free in throughput terms and miles better than 
without it. I would like to see your more robust (and nicer code) solution 
incorporated but I also want to see it cost us as little as possible. We 
haven't confirmed anything just yet...

Cheers,
Con
