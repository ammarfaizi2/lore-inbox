Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUDHW6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUDHW6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:58:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38059 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262906AbUDHW6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:58:44 -0400
Subject: Re: Failing back to INSANE timesource :) Time stopped today.
From: john stultz <johnstul@us.ibm.com>
To: Niclas Gustafsson <niclas.gustafsson@codesense.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1081416100.6425.45.camel@gmg.codesense.com>
References: <1081416100.6425.45.camel@gmg.codesense.com>
Content-Type: text/plain
Message-Id: <1081465114.4705.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 08 Apr 2004 15:58:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 02:21, Niclas Gustafsson wrote:
> Hi,
> 
> I'm running Linux 2.6.5  on a IBM xSeries 305 with a Intel P4 2.8Ghz.
> 
> And something is very very wrong, I'm getting the following last
> messages in dmesg:
> 
> ------
> set_rtc_mmss: can't update from 52 to 0
> set_rtc_mmss: can't update from 53 to 1
> set_rtc_mmss: can't update from 54 to 2
> set_rtc_mmss: can't update from 55 to 3
> set_rtc_mmss: can't update from 56 to 4
> set_rtc_mmss: can't update from 57 to 5
> set_rtc_mmss: can't update from 58 to 6
> Losing too many ticks!
> TSC cannot be used as a timesource.  <4>Possible reasons for this are:
>   You're running with Speedstep,
>   You don't have DMA enabled for your hard disk (see hdparm),
>   Incorrect TSC synchronization on an SMP system (see dmesg).
> ------
> 
> The problem seesm to be related to heavy loads.
> I experienced a similar problem yesterday. The machine completly hung
> after that and i had to cut the power to reboot it. Now however it is
> responsive and I can log on to it through ssh.
> 
> Problem is that the clock stopped completly! - I've never seen anything
> like this before. 
> 
> Local time is about 11 am here and a time gives me:
> 
> [root@s151 root]# date
> Thu Apr  8 03:51:21 CEST 2004
> 
> ...10 s later, using my wristwatch, not sleep 10 ;)
> 
> [root@s151 root]# date
> Thu Apr  8 03:51:21 CEST 2004
> 
> 
> Any ideas anyone, I'd really like to know why it is behaving this way.

Huh. Very very odd.  

Does /proc/interrupts show timer ticks increasing? 
Does setting the date change anything? 

Would you mind sending me your complete dmesg? 

I'll look into reproducing the error here if you can give me a better
description of what triggers it and how frequently you see the problem.

thanks
-john


