Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWAHWLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWAHWLs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWAHWLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:11:48 -0500
Received: from mx02.stofanet.dk ([212.10.10.12]:4225 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S1161204AbWAHWLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:11:47 -0500
Message-ID: <43C18E09.9060600@stud.feec.vutbr.cz>
Date: Sun, 08 Jan 2006 23:11:21 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Knecht <markknecht@gmail.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rt2 - repeatable xrun - no good data in trace
References: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>	 <43C17E50.4060404@stud.feec.vutbr.cz>	 <Pine.LNX.4.61.0601082247170.17804@yvahk01.tjqt.qr> <5bdc1c8b0601081404n2a163ce1ya21919800546dfc8@mail.gmail.com>
In-Reply-To: <5bdc1c8b0601081404n2a163ce1ya21919800546dfc8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Knecht wrote:
> On 1/8/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>>>>  I did run across a way that I can create a repeatable xrun on my
>>>>AMD64 machine by burning a CD in k3b while Jack is running.
>>>>Unfortunately I do not see any good trace data in dmesg when I do it.
>>>Maybe your cdrecord is running with realtime priority higher than Jack?
>>>Michal
>>cdrecord does run with SCHED_RR/99 when started with proper privileges.
>>
> Ah, then it's likely that this isn't a real problem and it would be
> expected to cause an xrun?

By running cdrecord with a higher priority than Jack, you're telling the 
system that burning the CD is more important than not getting xruns in Jack.

> Anyway, it seems strange that the trace doesn't show anything. I
> suppose that's because cdrecord just grabs a lot of time at a higher
> priority than Jack and Jack ends up not getting serivces at all for
> 5-10mS?

I guess that's exactly what's happening.

> OK, back to the drawing board about debugging my problems!

Try running cdrecord as a normal user and don't give it SUID root.

Michal
