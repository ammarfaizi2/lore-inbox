Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRKIVOP>; Fri, 9 Nov 2001 16:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280120AbRKIVOF>; Fri, 9 Nov 2001 16:14:05 -0500
Received: from modem-3508.lemur.dialup.pol.co.uk ([217.135.141.180]:9997 "EHLO
	Mail.MemAlpha.cx") by vger.kernel.org with ESMTP id <S279993AbRKIVOB>;
	Fri, 9 Nov 2001 16:14:01 -0500
Posted-Date: Fri, 9 Nov 2001 21:11:49 GMT
Date: Fri, 9 Nov 2001 21:11:48 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <20011109103254.B2620@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0111092102510.14996-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

>> Take the position of a sysadmin who can't understand why the system
>> clock on his computer keeps getting randomly changed under Linux,
>> and has verified using another operating system that it isn't a
>> hardware problem, then ask yourself what said sysadmin would expect
>> from the kernel to help him/her track the problem down. Would said
>> sysadmin prefer to be told...
>> 
>>  1. "Look in the system log - you'll get a message every time any
>>      program writes to the RTC."
>> 
>>  2. "Sorry, you'll have to go through every piece of software on
>>      your system and find the one that's updating the system clock
>>      that shouldn't be."
>> 
>> According to your comments, you prefer (2).
>>
>> I most definitely prefer (1).

> Hmm, and if some malicious software insmods kernel module to work
> around your printk()?

...it gets "Port busy" when it tries to access the RTC ports that the
RTC driver built into the kernel already has opened exclusively. At
least, that's my understanding of the situation at present.

> We are talking root only here.

Are we?

Unless I've misunderstood the arguments so far, the aim is to take the
RTC driver out of the kernel altogether and replace it with a usermode
driver to do the same thing. As I see it, that opens up far too many
problems to be seriously considered, not least the fact that setting
the RTC is not necessarily a root-only operation.

> If sofware with uid 0 is malicious, you have big problems.

True, but that's not what people appear to be talking about.

Best wishes from Riley.

