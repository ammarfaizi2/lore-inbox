Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVBGOwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVBGOwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVBGOwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:52:22 -0500
Received: from gate.corvil.net ([213.94.219.177]:15114 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261438AbVBGOtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:49:11 -0500
Message-ID: <42077FD1.1070605@draigBrady.com>
Date: Mon, 07 Feb 2005 14:48:49 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] support of motherboards with ICH6]
References: <20050207142141.GF1561@edu.joroinen.fi>
In-Reply-To: <20050207142141.GF1561@edu.joroinen.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Kärkkäinen wrote:
> On Mon, Feb 07, 2005 at 10:00:03AM +0100, P.O. Gaillard wrote:
> 
>>Hi,
>>
>>I am replying to myself so that people googling for similar problems can 
>>find the answer.
>>
>>Supermicro says that the internal driver of the southbridge (and also the 
>>W83627HF chip) are not useable because the necessary support hardware is 
>>missing. They say that the P8SCi board has a working watchdog.
>>
>>	hope this can help somebody someday,
>>
>>	P.O. Gaillard
>>
> 
> 
> Hi!
> 
> I have P8SCi motherboard, and I just tried the watchdog with Linux 2.6.10.
> 
> I loaded w83627hf_wdt driver, and the watchdog was detected:
> 
> WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
> w83627hf WDT: initialized. timeout=60 sec (nowayout=0)

Note there is no detection. It just writes to a particular IO port
(2E by default).

> But it is not working. I tried setting the timeout to 1 minute, and to
> 8 minute in the BIOS, but the machine reboots after the delay no matter what
> the delay is.. the watchdog driver is loaded before the timeout of course.
> 
> For some reason, the driver is not working.
> 
> I mailed supermicro support about this, and they told me one of their
> customers is using watchdog with Debian 2.6.10 kernel. 
> So it should work, but..

You need to ask them what watchdog they use exactly.
I've seen motherboards that have w83637hf chips but
actually wire the intel watchdog up so you need the i8xx_tco driver

If they are using the w83726hf chip you need to ask
what IO port they're using.

Pádraig.
