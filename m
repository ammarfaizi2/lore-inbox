Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSEQSBE>; Fri, 17 May 2002 14:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316633AbSEQSBD>; Fri, 17 May 2002 14:01:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53509 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316609AbSEQSBC>; Fri, 17 May 2002 14:01:02 -0400
Date: Fri, 17 May 2002 13:57:26 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Q: x86 interrupt arrival after cli
In-Reply-To: <Pine.LNX.3.95.1020516124059.702A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1020517135353.15351B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Richard B. Johnson wrote:


> <--- HIGHEST    -------------------     LOWEST ---->
> 
> IRQ0, 1, 8, 9, 10, 11, 12, 13, 14, 15, 3, 4, 5, 6, 7
>    |  |  |                             |  |  |  |  |_ printer
>    |  |  |                             |  |  |  |____ Floppy
>    |  |  |                             |  |  |_______ Fixed disk
>    |  |  |                             |  |__________ Serial 0
>    |  |  |                             |_____________ Serial 1
>    |  |  |
>    |  |  |___________ IRQ2->IRQ8 cascade  RTC
>    |  |______________ Keyboard
>    |_________________ PIT channel 0
> 
> IFF the IO-APIC is programmed to emulate the old dual controllers.

Yes, and if anyone missed this subtle point, the priorities are
programmable! There have been patches, particularly back in 2.1.120+, to
diddle priority to make marginal system work, or move the failures to
something with more robust retries.

Nice diagram, I'm taking it to a meeting (credited to you of course) where
I will be talking about interrupt use on parallel ports.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

