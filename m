Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWBIX4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWBIX4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWBIX4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:56:00 -0500
Received: from ws6-1.us4.outblaze.com ([205.158.62.196]:59595 "HELO
	ws6-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750849AbWBIX4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:56:00 -0500
Message-ID: <43EBD67E.9020308@acm.org>
Date: Thu, 09 Feb 2006 23:55:42 +0000
From: Dave Spring <dspring@acm.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
References: <43E0FC55.6080503@acm.org>
In-Reply-To: <43E0FC55.6080503@acm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0606-3, 09/02/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for closure's sake:
 This turned out to be a hardware problem.
Memtest86+ http://www.memtest.org/ found an intermittent and 
pattern-sensitive memory error,
and only appearing at one or two random locations within the 256M module.
Replacing the dodgy RAM module did the trick.
Dave Spring wrote:

>>> running kernels with or without PREEMPT enabled.
>>>
>> If you don't actually *need* accelerated 3D (or if you could do
>> without it for a while), switching to the "nv" driver for a few
>> days/weeks would be interresting. If the crashes go away that would
>> point towards the nvidia driver, if they don't go away we'll get a
>> nice untainted crash report.
>
>
> It's not the nv drivers - or at least not just them.
> I'm getting this bug once or twice a day on a mini-ITX (C3 533Mhz 
> processor) based server which doesn't even have X installed.
> For me, it appeared sometime after 2.6.12.
> I'm now running with gentoo 2.6.15-r1 with Hugh's recently posted patch,
> and waiting 8-|
>
> Dave Spring


