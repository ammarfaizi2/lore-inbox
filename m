Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131799AbRAFUUV>; Sat, 6 Jan 2001 15:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132938AbRAFUUM>; Sat, 6 Jan 2001 15:20:12 -0500
Received: from relay.planetinternet.be ([194.119.232.24]:11270 "EHLO
	relay.planetinternet.be") by vger.kernel.org with ESMTP
	id <S131799AbRAFUTy>; Sat, 6 Jan 2001 15:19:54 -0500
Date: Sat, 6 Jan 2001 21:19:42 +0100
From: Kurt Roeckx <Q@ping.be>
To: BJerrick@easystreet.com
Cc: aeb@cwi.nl, linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com
Subject: Re: 500 ms offset in i386 Real Time Clock setting
Message-ID: <20010106211942.A5514@ping.be>
In-Reply-To: <200101061935.f06JZqx18624@enzo.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <200101061935.f06JZqx18624@enzo.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 11:35:52AM -0800, BJerrick@easystreet.com wrote:
>     Neither hwclock nor the /dev/rtc driver takes the following comment from
> set_rtc_mmss() in arch/i386/kernel/time.c into account.  As a result, using
> hwclock --systohc or --adjust always leaves the Hardware Clock 500 ms ahead of
> the System Clock:

I mailed a patch to Andries Brouwer yesterday for exactly the
same problem if hwclock writes writes to the cmos directly, and
said to check if other places have the same problem.

I added an usleep() of 500 ms in cmos.c


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
