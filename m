Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLOTWO>; Fri, 15 Dec 2000 14:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129521AbQLOTWF>; Fri, 15 Dec 2000 14:22:05 -0500
Received: from 216-80-74-178.dsl.enteract.com ([216.80.74.178]:63236 "EHLO
	kre8tive.org") by vger.kernel.org with ESMTP id <S129421AbQLOTVt>;
	Fri, 15 Dec 2000 14:21:49 -0500
Date: Fri, 15 Dec 2000 12:50:15 -0600
From: mike@kre8tive.org
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test12 lockups -- need feedback
Message-ID: <20001215125015.A1259@lingas.basement.bogus>
Reply-To: mike@kre8tive.org
In-Reply-To: <00121418523403.16098@eckhard> <20001215194735.K829@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001215194735.K829@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Fri, Dec 15, 2000 at 07:47:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a DLink DFE-530TX+ with a RTL8139 and I lock up cold
every once in a while too.  2.4.0-test12-pre3 is the latest
kernel I've tried.  The machine is a dual PII450 on a Tyan
Tiger 100 BX board w/ 128MB.

Locks up cold meaning "It's dead Jim".  Non sysrq facilities
available and no Oops trail.

I don't see the old Becker 8139 driver in the 2.4 tree so
I don't know if it happens with 2.4 and the old driver.

I can provide what ever info that is available and would
be useful.

NOTE also: I have an old Dell P133 48MB masquerading machine 
with 2 of these same boards that Panic's on current 2.4 
kernels with the "Aieee killing interrupt handler" message
to the console but doesn't get around to writing the console
to the log before going toe up.  2.4.0-test12-pre3.  Before
that I get a bunch of the RxFIFOOwv interrupt sending it
into the rtl8139_weird_interrupt routine, but it says
in the driver code that this could be related to CPU speed
and the machine's a P133.  Should the machine panic though?

I can't get the console off to the serial port cause the
ports are dead on this machine for some reason.  The BIOS
allocates irq 4 to the second of the 8139 cards and neither
serial port is recognised so I'm not sure how to get any
major chunk of the Panic info off teh 14" screen.  Note 
that this machine runs 2.2.18 fine albiet my OnStream 
drive doesn't function right so maybe the old Becker driver
does solve some of the problems.  Arg!  =)

-mwe


On Fri, Dec 15, 2000 at 07:47:35PM +0100, Ingo Oeser wrote:
> On Thu, Dec 14, 2000 at 06:52:34PM +0000, Eckhard Jokisch wrote:
> > Is it possible that there is something wrong with the 8139too driver? 
> > ( I also use a card with 8139 chip )
> > Or do you use the "old" rtl8139 ? With that I don't have any problems.
> > I have an extra machine here where I can do all testing - how can I help?
> 
> I have no Realtek-Card and have the same lockup.
> 
> I also got a hard lockup (but with Oops) while calling the
> "vendor CPU init" function during system boot.
> 
> This was on Cyrix III.
> 
> PS: CC'ed hpa, because he is cpu-detection maintainer and davej,
>    because he added Cyrix III support and might know details ;-)
> 
> Regards
> 
> Ingo Oeser

-- 
Mike Elmore
mike@kre8tive.org

"Never confuse activity with accomplishment."
				-unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
