Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316655AbSE1Ooq>; Tue, 28 May 2002 10:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316657AbSE1Oop>; Tue, 28 May 2002 10:44:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48378 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316655AbSE1Ooo>; Tue, 28 May 2002 10:44:44 -0400
Subject: Re: Changing the current RTC device interface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020528162435.A4917@crystal.2d3d.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 16:46:35 +0100
Message-Id: <1022600795.4123.91.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 15:24, Abraham vd Merwe wrote:
> I have a board with multiple RTC chips (Built-in RTC in the processor +
> external battery backed RTC).
> 
> There are pros and cons to each RTC chip. The CPU's RTC doesn't have a
> battery, but have high resolution timing + multiple rtc counters/interrupts,
> so it is especially suited for apps that want to use /dev/rtc for high
> resolution timing.
> 
> On the other hand the external RTC chip can keep time, but its timing is
> crap (1hz to 8khz in steps of powers of two), so you don't want to use that
> for timing.
> 
> At the moment, Linux only allows for a single RTC device, so one can't reap
> the benefits of both chips mentioned above.
> 
> How about we get a major number assigned to rtc subsystem and then allows
> for multiple rtc devices.

I think you should wait until 2.5 has reached the point we have a
finished devicefs and 32bit dev_t. Basically we don't have enough device
numbering left for such trivialities right now.

