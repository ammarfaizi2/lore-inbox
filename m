Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRDJO3I>; Tue, 10 Apr 2001 10:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRDJO26>; Tue, 10 Apr 2001 10:28:58 -0400
Received: from iris.mc.com ([192.233.16.119]:11247 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S131986AbRDJO2n>;
	Tue, 10 Apr 2001 10:28:43 -0400
Message-ID: <3AD30C29.3E8D47A0@mc.com>
Date: Tue, 10 Apr 2001 09:35:37 -0400
From: root <mbs@mc.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: David Schleef <ds@schleef.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <Pine.LNX.3.96.1010410155723.28395A-100000@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:

> BTW. Why we need to redesign timers at all? The cost of timer interrupt
> each 1/100 second is nearly zero (1000 instances on S/390 VM is not common
> case - it is not reasonable to degradate performance of timers because of
> this).
>
> Timers more precise than 100HZ aren't probably needed - as MIN_RTO is 0.2s
> and MIN_DELACK is 0.04s, TCP would hardly benefit from them.
>

well, I can think dozens of real time applications off the top of my head that
need beter than 1ms timing resolution (think sensor fusion)  1000 clock
interrupts/sec is wasteful when what you need is 1 very precisely timed
interrupt.

why do we redesign anything?  to make it better.  TCP is not the only thing in
the system.


if you are in love with the existing system, it shouldn't be hard to make it a
config option.

