Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133064AbRDLJ3e>; Thu, 12 Apr 2001 05:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133071AbRDLJ3Y>; Thu, 12 Apr 2001 05:29:24 -0400
Received: from [202.54.26.202] ([202.54.26.202]:17564 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S133064AbRDLJ3P>;
	Thu, 12 Apr 2001 05:29:15 -0400
X-Lotus-FromDomain: HSS
From: npunmia@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A2C.0032850D.00@sandesh.hss.hns.com>
Date: Thu, 12 Apr 2001 14:50:57 +0530
Subject: RTC !!
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi ,

The RTC interrupt  is programmable from 2 Hz to 8192 Hz, in powers of 2. So the
interrupts that you
could get are one of the following:      0.122ms, .244ms, .488ms, .977ms,
1.953ms, 3.906ms, 7.813ms, and so on.    Is there any  workaround , so that i
can use RTC
for meeting my requirement of an interrupt every 1.666..ms!!  ( I know that i
can use UTIME or #define HZ 600, but i want to know if i can use RTC for this
purpose )

With Regards,
--Niraj

---------------------- Forwarded by Niraj Punmia/HSS on 04/12/2001 02:33 PM
---------------------------


James Stevenson <mistral@stev.org> on 04/09/2001 06:42:44 PM

Please respond to mistral@stev.org

To:   Niraj Punmia/HSS@HSS
cc:

Subject:  Re: 1.6666.... ms interrupts needed!!





Hi

instead of modifing the time irq freq you could try using the
realt time clock (rtc) it will generate irqs with better timing
and you also wont hit system performance as much by modifing the timer
ever time the timer send an irq some code is run to see it schedule need
to be called the more times schedule is called a second the worse the
system performance is because of the task switching overhead.

In local.linux-kernel-list, you wrote:
>
>
>
>Hi.
>
>We are simulating air interface of GPRS on LAN. A TDMA(time division multiple
>access) frame duration is 40ms.  Each TDMA frame consists of 24 timeslots. Each
>timeslot  is  of 40/24 ms (i.e 1.66666.......ms) . To know  what current
>timeslot it is, we need a timer interrupt after every 1.6666... ms .   Since we
>are implementing this on LAN, minor jitters once in a while can be tolerated
>(say 0.2 ms more or less once a while would be OK).
>     As of now, we are modifying the HZ value in param.h to 600.  This gives us
>a CPU tick of  1.6666.... ms. (i.e 1/600sec).  I want to know if it would
affect
>the perfomance of the CPU.
>     Is there a better way to achieve the granularity of 1.666...ms .  Would
the
>UTIME patch be a better way from performance or any other point of view  than
>this method?
>
>With Regards,
>Niraj Punmia
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


--
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  1:10pm  up 13 days, 21:05,  5 users,  load average: 0.45, 0.45, 0.47




