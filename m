Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280709AbRKJUh2>; Sat, 10 Nov 2001 15:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280714AbRKJUhR>; Sat, 10 Nov 2001 15:37:17 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:37664 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S280709AbRKJUhJ>; Sat, 10 Nov 2001 15:37:09 -0500
Posted-Date: Sat, 10 Nov 2001 20:35:35 GMT
Date: Sat, 10 Nov 2001 20:35:34 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <20011110210441.B19664@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0111102030150.12260-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

>> If any user can do that, then Linux is borken solid.

> Only root can do that.

Good.

>> Just out of curiosity, what is wrong with the idea of having the
>> kernel at iopl(0), any kernel modules at either iopl(1) or iopl(2)
>> and apps at iopl(3) ??? There is obviously something, but I've no
>> idea what.

> It ... just is not that way. Kernel + modules run at ring 0,
> userland at ring 3.

I know that much. I was just curious whether there was any particular
reason why it was that way.

Somebody suggested that it was because of "scheduling hooplas" causing a
serious loss of performance if modules were moved to ring 1. I've no
idea whether such is the case

>>> No. Aim is to leave /dev/rtc in kernel, but make kernel never write
>>> to RTC at its own will.

>> I've no problem with that at all, but the bulk of the comments I've
>> seen in this thread have been very clear about taking /dev/rtc out
>> of the kernel and into a userspace daemon, with the kernel just
>> providing access to the relevant ports to the first app to claim
>> them.

> I do not think so.
> 
> The person who tries to kill /dev/rtc from kernel is going to have
> some problems with me.

They've been getting problems from me - I just checked, and the main
suggestion appears to be to replace /dev/rtc with a sysctl call. I can't
see the point in that myself, and /dev/rtc makes far more sense to me.

I will add that I personally see no problem with the kernel reading RTC
on boot to set the syste clock, although some of the correspondents
appear to have problems with that idea as well.

Best wishes from Riley.

