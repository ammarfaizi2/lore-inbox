Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162016AbWKOWiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162016AbWKOWiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162017AbWKOWiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:38:05 -0500
Received: from hosting.zipcon.net ([209.221.136.3]:52108 "EHLO
	hosting.zipcon.net") by vger.kernel.org with ESMTP id S1162016AbWKOWiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:38:03 -0500
Message-ID: <455B96C7.8010202@beezmo.com>
Date: Wed, 15 Nov 2006 14:37:59 -0800
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFCLUE3] flagging kernel interface changes
References: <455B9133.9030704@beezmo.com> <1163629533.31358.168.camel@laptopd505.fenrus.org>
In-Reply-To: <1163629533.31358.168.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.zipcon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - beezmo.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> I don't want to start an argument about	"stable_api_nonsense" or 
>> the wisdom of out-of-tree drivers.  Just curious about the - why - 
>> and whether it is indifference or antagonism toward drivers outside
>>  the fold. Or ???
> 
> 
> Hi,
> 
> in general the best approach has been to make the driver support the 
> NEW interface, and then do some compat thing to fake the old one. The
>  other way around is going to be MUCH more painful long term. So as 
> general rule: always follow the latest API, and use a compat.h hack 
> for older kernels inside your driver, but keep the normal code clean.
>  It's not always easy, but keeping old API and faking it to the new 
> one is only going to be really really painful; things will deviate 
> more and more over time and at some point you'll have to jump anyway.

Good point.  I actually try to do it that way.  Should have said

#ifndef NEW_INTERFACE
...

> In addition quite a few api changes are done in a way that make this
>  less painful than the other way around..

The other part of the question is why this irq_handler prototype change
in 2.6.19 isn't flagged to make things a little easier.

> however in general really there is pain to be out-of-tree; and to
> some degree that's an incentive to merge back  :)

No argument, but I don't have the stamina to try to get my 10+ year
old code out of the public domain and into the main line :)

Many thanks for your reply,
Bill
-- 
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch
