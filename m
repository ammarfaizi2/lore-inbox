Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVBGO76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVBGO76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVBGO76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:59:58 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:56495 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S261438AbVBGO7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:59:54 -0500
Date: Mon, 7 Feb 2005 16:59:53 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: P@draigBrady.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] support of motherboards with ICH6]
Message-ID: <20050207145953.GH1561@edu.joroinen.fi>
References: <20050207142141.GF1561@edu.joroinen.fi> <42077FD1.1070605@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42077FD1.1070605@draigBrady.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 02:48:49PM +0000, P@draigBrady.com wrote:
> Pasi Kärkkäinen wrote:
> >On Mon, Feb 07, 2005 at 10:00:03AM +0100, P.O. Gaillard wrote:
> >
> >>Hi,
> >>
> >>I am replying to myself so that people googling for similar problems can 
> >>find the answer.
> >>
> >>Supermicro says that the internal driver of the southbridge (and also the 
> >>W83627HF chip) are not useable because the necessary support hardware is 
> >>missing. They say that the P8SCi board has a working watchdog.
> >>
> >>	hope this can help somebody someday,
> >>
> >>	P.O. Gaillard
> >>
> >
> >
> >Hi!
> >
> >I have P8SCi motherboard, and I just tried the watchdog with Linux 2.6.10.
> >
> >I loaded w83627hf_wdt driver, and the watchdog was detected:
> >
> >WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
> >w83627hf WDT: initialized. timeout=60 sec (nowayout=0)
> 
> Note there is no detection. It just writes to a particular IO port
> (2E by default).
> 
> >But it is not working. I tried setting the timeout to 1 minute, and to
> >8 minute in the BIOS, but the machine reboots after the delay no matter 
> >what
> >the delay is.. the watchdog driver is loaded before the timeout of course.
> >
> >For some reason, the driver is not working.
> >
> >I mailed supermicro support about this, and they told me one of their
> >customers is using watchdog with Debian 2.6.10 kernel. 
> >So it should work, but..
> 
> You need to ask them what watchdog they use exactly.
> I've seen motherboards that have w83637hf chips but
> actually wire the intel watchdog up so you need the i8xx_tco driver
> 
> If they are using the w83726hf chip you need to ask
> what IO port they're using.
> 

Hi!

http://nrg.joroinen.fi/watchdog_function_project_description_P4SGL.doc

That is the document I got from supermicro.. it has the io ports / registers
they're using and also watchdog example in assembly.

It seems that they're using 0x2E..

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
