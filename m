Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280273AbRKIXCp>; Fri, 9 Nov 2001 18:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280275AbRKIXCg>; Fri, 9 Nov 2001 18:02:36 -0500
Received: from zeus.kernel.org ([204.152.189.113]:22418 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S280273AbRKIXCU>;
	Fri, 9 Nov 2001 18:02:20 -0500
Posted-Date: Fri, 9 Nov 2001 22:54:10 GMT
Date: Fri, 9 Nov 2001 22:54:10 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Pavel Machek <pavel@ucw.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <20011109223053.A964@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0111092247070.14996-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

>>>> According to your comments, you prefer (2).
>>>> I most definitely prefer (1).

>>> Hmm, and if some malicious software insmods kernel module to
>>> work around your printk()?

>> ...it gets "Port busy" when it tries to access the RTC ports that the
>> RTC driver built into the kernel already has opened exclusively. At
>> least, that's my understanding of the situation at present.

> It does not work that way. Userland does iopl(0), and then it just
> bangs any port it wants to.

If any user can do that, then Linux is borken solid.

Just out of curiosity, what is wrong with the idea of having the kernel
at iopl(0), any kernel modules at either iopl(1) or iopl(2) and apps at
iopl(3) ??? There is obviously something, but I've no idea what.

>>> We are talking root only here.

>> Are we?
>> 
>> Unless I've misunderstood the arguments so far, the aim is to take
>> the RTC driver out of the kernel altogether and replace it with a
>> usermode driver to do the same thing. As I see it, that opens up far
>> too many

> No. Aim is to leave /dev/rtc in kernel, but make kernel never write
> to RTC at its own will.

I've no problem with that at all, but the bulk of the comments I've seen
in this thread have been very clear about taking /dev/rtc out of the
kernel and into a userspace daemon, with the kernel just providing
access to the relevant ports to the first app to claim them.

Best wishes from Riley.

