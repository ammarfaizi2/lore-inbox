Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUHSU7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUHSU7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUHSU47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:56:59 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37615 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267401AbUHSU4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:56:08 -0400
Subject: Re: System time slowdown after upgrading from 2.4 to 2.6
From: john stultz <johnstul@us.ibm.com>
To: ivan.kalatchev@esg.ca
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <000501c48624$b1ac72f0$2e646434@ivans>
References: <000501c48624$b1ac72f0$2e646434@ivans>
Content-Type: text/plain
Message-Id: <1092949099.2429.427.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 19 Aug 2004 13:58:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 12:42, Ivan Kalatchev wrote:
> We have a project that uses PC-104 (ZFx86 100 MHz CPU) Linux box to acquire
> some seismological signals. System resides on a M-Systems DiskOnChip 2000.
> We have an ISA acquisition card that acquires data into FIFO buffer and
> triggers interrupt as soon as 341 points were acquired (then this data is
> read out in interrupt handler routine). System worked perfectly well when we
> used 2.4.18 kernel. When I printk-ed system time (do_gettimeofday)  in
> interrupt routine, at 1kHz sampling frequency interrupts were reported every
> 341 msec as they should do.
> But after I've switched to 2.6 kernel (2.6.7 - preempted, then I tried
> 2.6.8 - non-preempted) time between successive interrupts at 1kHz became 335
> msec, losing 6 msec at each interrupt. What is interesting, when sampling
> frequency is 10 kHz, with 2.4.18 kernel interrupts are reported every 34
> msec, which is right, but with 2.6 kernels interrupts are coming at 28 msec
> interval, again losing same 6 msec!
> 
> Any ideas why this might happen?

Hmm. Strange. Just to remove some variables, are you running NTP on the
system? Could you also send your 2.6 dmesg?

thanks
-john


