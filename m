Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262894AbTCSCMK>; Tue, 18 Mar 2003 21:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262896AbTCSCMK>; Tue, 18 Mar 2003 21:12:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60915 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262894AbTCSCMH>;
	Tue, 18 Mar 2003 21:12:07 -0500
Message-ID: <3E77D46F.5070709@mvista.com>
Date: Tue, 18 Mar 2003 18:22:39 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
 due to wrmsr (performance)
References: <3E7765DE.10609@didntduck.org> <Pine.LNX.4.44.0303181113590.13708-100000@home.transmeta.com> <b58edl$au1$1@cesium.transmeta.com>
In-Reply-To: <b58edl$au1$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.44.0303181113590.13708-100000@home.transmeta.com>
> By author:    Linus Torvalds <torvalds@transmeta.com>
> In newsgroup: linux.dev.kernel
> 
>>Wow. There aren't many things that AMD tends to show the P4-like "big
>>latency in rare cases" behaviour.
>>
>>But quite honestly, I think they made the right call, and I _expect_ that
>>of modern CPU's. The fact is, modern CPU's tend to need to pre-decode the
>>instruction stream some way, and storing to it while running from it is
>>just a really really bad idea. And since it's so easy to avoid it, you
>>really just shouldn't do it.
>>
> 
> 
> AMD, I believe, has an "annotated" icache

Here is an SMP:

vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) MP 2000+
stepping	: 2
cpu MHz		: 1680.368
cache size	: 256 KB

empty overhead=11 cycles
load overhead=6 cycles
I$ load overhead=5 cycles
I$ load overhead=6 cycles
I$ store overhead=1051 cycles


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

