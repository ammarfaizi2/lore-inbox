Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbTLPHpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 02:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTLPHpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 02:45:55 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19952 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264361AbTLPHpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 02:45:54 -0500
Message-ID: <3FDEB82C.80908@mvista.com>
Date: Mon, 15 Dec 2003 23:45:48 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Nick Piggin <piggin@cyberone.com.au>, Guillaume Foliard <guifo@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: Scheduler degradation since 2.5.66
References: <200312142048.51579.guifo@wanadoo.fr> <3FDD205A.6040807@cyberone.com.au> <3FDD35F9.7090709@cyberone.com.au> <3FDE5449.60507@mvista.com> <20031216005251.GB3364@mail.shareable.org>
In-Reply-To: <20031216005251.GB3364@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> George Anzinger wrote:
> 
>>Try running the test with a requested sleep time of something less than 
>>0.999849 ms.  All this is for the x86 which is using this time to do the 
>>best it can with the PIT which can only get this close to 1 ms ticks.  You 
>>can even vary this number to see exactly where the round up actually 
>>happens.  Ah, life in the nano world :)
> 
> 
> Would it be better to program the PIT for lowest frequency that's >= 1.0ms.

Possibly.  I haven't attempted to analize it.  I do know it would make some of 
the math a bear.  Integers like to round down (read truncate) so...  But then, 
what we have isn't exactly fun :)

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

