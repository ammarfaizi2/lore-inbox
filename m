Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264998AbRGSQfo>; Thu, 19 Jul 2001 12:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbRGSQfe>; Thu, 19 Jul 2001 12:35:34 -0400
Received: from pop.gmx.net ([194.221.183.20]:31896 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S264998AbRGSQfa>;
	Thu, 19 Jul 2001 12:35:30 -0400
Message-ID: <3B570CCD.BC6A16C7@gmx.at>
Date: Thu, 19 Jul 2001 18:37:33 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kevin@labsysgrp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.7-pre7 natsemi network driver random pauses
In-Reply-To: <00f101c1106e$a119e3c0$6baaa8c0@kevin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Kevin P. Fleming" wrote:
> 
> I upgraded two machines here from 2.4.7-pre6 to 2.4.7-pre7 yesterday
> afternoon.
> 
> The first machine I upgraded, my workstation, is a 1GHz Athlon on a VIA
> KT133 (not A) motherboard using a NetGear FA312TX network card. This machine
> has always run Linux just fine. After this upgrade, telnetting to my other
> Linux machine (not yet upgraded) and doing long directory listings (or tar
> tzvf linux-2.4.0.tar) exhibits random (and long) pauses in the output.
> Switching back to 2.4.7-pre6 makes the problem disappear. Note that at this
> time only the _client_ end of this connection had been upgraded to -pre7.
> 
> I then upgraded my server as well, which is a 700 MHz Coppermine Celeron on
> an SIS 630 motherboard, also using a NetGear FA312TX network card. Now this
> machine exhibits the same symptoms, even when the telnet client is on a
> Windows machine.
> 
> So, it appears that one of two things happened:
> 
> a) the natsemi driver had changes merged between -pre6 and -pre7 (not listed
> in the changelogs) that had negative effects on my systems
> 
> b) something else in the kernel caused irq/softirq/whatever random latency
> to appear
> 
> Any ideas where I should start looking?

Just for curiosity, do you have those messages in our logfiles:

eth0: Transmit error, Tx status register 82.
  Flags; bus-master 1, dirty 20979238(6) current 20979242(10)
  Transmit list 1f659290 vs. df659260.
  0: @df659200  length 800005ea status 000105ea
  1: @df659210  length 80000296 status 00010296
  2: @df659220  length 800005ea status 000105ea

I had those with 2.4.3-pre6. They disappeared in 2.4.4. Another user
reported the same on lkml with different kernel versions.

Wilfried
