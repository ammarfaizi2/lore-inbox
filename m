Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132730AbRDILti>; Mon, 9 Apr 2001 07:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132729AbRDILt2>; Mon, 9 Apr 2001 07:49:28 -0400
Received: from [202.54.26.202] ([202.54.26.202]:8070 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132730AbRDILtO>;
	Mon, 9 Apr 2001 07:49:14 -0400
X-Lotus-FromDomain: HSS
From: npunmia@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A29.003F97A4.00@sandesh.hss.hns.com>
Date: Mon, 9 Apr 2001 17:15:53 +0530
Subject: 1.6666.... ms interrupts needed!!
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

We are simulating air interface of GPRS on LAN. A TDMA(time division multiple
access) frame duration is 40ms.  Each TDMA frame consists of 24 timeslots. Each
timeslot  is  of 40/24 ms (i.e 1.66666.......ms) . To know  what current
timeslot it is, we need a timer interrupt after every 1.6666... ms .   Since we
are implementing this on LAN, minor jitters once in a while can be tolerated
(say 0.2 ms more or less once a while would be OK).
     As of now, we are modifying the HZ value in param.h to 600.  This gives us
a CPU tick of  1.6666.... ms. (i.e 1/600sec).  I want to know if it would affect
the perfomance of the CPU.
     Is there a better way to achieve the granularity of 1.666...ms .  Would the
UTIME patch be a better way from performance or any other point of view  than
this method?

With Regards,
Niraj Punmia



