Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbUBEBEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUBEBC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:02:56 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:40629
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265113AbUBDXxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:53:42 -0500
Message-ID: <40218659.7090605@tmr.com>
Date: Wed, 04 Feb 2004 18:55:05 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: VM patches (please review)
References: <402128D0.2020509@tmr.com> <Pine.LNX.4.44.0402041239311.24515-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402041239311.24515-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Wed, 4 Feb 2004, Bill Davidsen wrote:
> 
> 
>>Since this is broken down nicely, a line or two about what each patch 
>>does or doesn't address would be useful. In particular, having just 
>>gotten a working RSS I'm suspicious of the patch named vm-no-rss-limit 
>>being desirable ;-)
> 
> 
> The bug with the RSS limit patch is that I forgot to
> change the exec() code, so when init is exec()d it
> gets an RSS limit of zero, which is inherited by all
> its children --> always over the RSS limit, no page
> aging, etc.
> 
> I need to find the cleanest way to add the inheriting
> of RSS limit at exec time and send a patchlet for that
> to akpm...

Thank you! I had assumed that the info was being carried through exec, 
fork, and pthread_* and similar, and just not enforced.

I still think this will be great for those applications known to 
occasionally get a tough data set and not converge or recurse beyond all 
sense.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
