Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbSJMKgF>; Sun, 13 Oct 2002 06:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSJMKgF>; Sun, 13 Oct 2002 06:36:05 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:40123 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261489AbSJMKgF>; Sun, 13 Oct 2002 06:36:05 -0400
Message-ID: <3DA94F07.7070109@t-online.de>
Date: Sun, 13 Oct 2002 12:46:31 +0200
From: Ingo.Adlung@t-online.de (Ingo Adlung)
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Linus Torvalds" <"Linus Torvalds"@t-online.de>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
References: <3DA4B1EC.781174A6@mvista.com> <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:
> On Wed, 9 Oct 2002, george anzinger wrote:
> 
>>This patch, in conjunction with the "core" high-res-timers
>>patch implements high resolution timers on the i386
>>platforms.
> 
> 
> I really don't get the notion of partial ticks, and quite frankly, this 
> isn't going into my tree until some major distribution kicks me in the 
> head and explains to me why the hell we have partial ticks instead of just 
> making the ticks shorter.
> 
> 		Linus

In any kind of virtual environment you would rather prefer a completely 
tickless system alltogether than increased tick rates. In a S/390 
virtual machine, running many hundreds of virtual Linux servers the 
100Hz timer pops are already considerably painful, and going to a higher 
tick rate achieving higher timer resolution is completely prohibitive. 
Similar is true in many embedded systems related to power consumption of 
high frequency ticks.

However, George has shown that introducing the notion of a completely 
tickless system is expensive on Intel overhead wise, thus partial ticks 
seem to be a possibility addressing the needs for embedded and virtual 
environments, getting decent timer resolution as needed.

Ingo Adlung

