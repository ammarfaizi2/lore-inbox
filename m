Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVLNKEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVLNKEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVLNKEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:04:22 -0500
Received: from mx.laposte.net ([81.255.54.11]:34399 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932267AbVLNKEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:04:22 -0500
Message-ID: <34966.192.54.193.35.1134554604.squirrel@rousalka.dyndns.org>
In-Reply-To: <439F5B91.4010903@mvista.com>
References: <17594.192.54.193.25.1134477932.squirrel@rousalka.dyndns.org>
    <439F5B91.4010903@mvista.com>
Date: Wed, 14 Dec 2005 11:03:24 +0100 (CET)
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: george@mvista.com
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
       "Roman Zippel" <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20051204.1.fc5.1.nim
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mer 14 décembre 2005 00:38, George Anzinger wrote:
> Nicolas Mailhot wrote:
>> "This is your interpretation and I disagree.
>>
>> If I set up a timer with a 24 hour interval, which should go off
>> everyday at 6:00 AM, then I expect that this timer does this even when
>> the clock is set e.g. by daylight saving. I think, that this is a
>> completely valid interpretation and makes a lot of sense from a
>> practical point of view. The existing implementation does it that way
>> already, so why do we want to change this ?"
>
> I think that there is a miss understanding here.  The kernel timers,
> at this time, do not know or care about daylight savings time.  This
> is not really a clock set but a time zone change which does not
> intrude on the kernels notion of time (that being, more or less UTC).

Probably. I freely admit I didn't follow the whole discussion. But the
example quoted strongly hinted at fudging timers in case of DST, which
would be very bad if done systematically and not on explicit user request.

What I meant to write is "do not assume any random clock adjustement
should change timer duration". Some people want it, others definitely
don't.

I case of kernel code legal time should be pretty much irrelevant, so if
24h timers are adjusted so they still go of at the same legal hour, that
would be a bug IMHO.

-- 
Nicolas Mailhot

