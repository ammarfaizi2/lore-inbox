Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVBGOVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVBGOVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVBGOVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:21:45 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:24238 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S261422AbVBGOVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:21:42 -0500
Date: Mon, 7 Feb 2005 16:21:41 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] support of motherboards with ICH6]
Message-ID: <20050207142141.GF1561@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 10:00:03AM +0100, P.O. Gaillard wrote:
> Hi,
> 
> I am replying to myself so that people googling for similar problems can 
> find the answer.
> 
> Supermicro says that the internal driver of the southbridge (and also the 
> W83627HF chip) are not useable because the necessary support hardware is 
> missing. They say that the P8SCi board has a working watchdog.
> 
> 	hope this can help somebody someday,
> 
> 	P.O. Gaillard
> 

Hi!

I have P8SCi motherboard, and I just tried the watchdog with Linux 2.6.10.

I loaded w83627hf_wdt driver, and the watchdog was detected:

WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
w83627hf WDT: initialized. timeout=60 sec (nowayout=0)

But it is not working. I tried setting the timeout to 1 minute, and to
8 minute in the BIOS, but the machine reboots after the delay no matter what
the delay is.. the watchdog driver is loaded before the timeout of course.

For some reason, the driver is not working.

I mailed supermicro support about this, and they told me one of their
customers is using watchdog with Debian 2.6.10 kernel. 
So it should work, but..

Is there some patches I could try? 

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

