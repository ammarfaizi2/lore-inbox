Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVBGPB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVBGPB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVBGPB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:01:26 -0500
Received: from gwout.thalesgroup.com ([195.101.39.227]:26129 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S261162AbVBGPBQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:01:16 -0500
Message-ID: <420782AE.9050505@fr.thalesgroup.com>
Date: Mon, 07 Feb 2005 16:01:02 +0100
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [WATCHDOG] support of motherboards with ICH6
References: <41FF9366.5030203@fr.thalesgroup.com> <42072E13.4000903@fr.thalesgroup.com> <20050207142030.GE1561@edu.joroinen.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Kärkkäinen
> Hi!
> 
> I have P8SCi motherboard, and I just tried the watchdog with Linux 2.6.10.
> 
> I loaded w83627hf_wdt driver, and the watchdog was detected:
> 
> WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
> w83627hf WDT: initialized. timeout=60 sec (nowayout=0)
> 
> But it is not working. I tried setting the timeout to 1 minute, and to
> 8 minute in the BIOS, but the machine reboots after the delay no matter what
> the delay is.. the watchdog driver is loaded before the timeout of course.
> 
> For some reason, the driver is not working.
> 
> I mailed supermicro support about this, and they told me one of their
> customers is using watchdog with Debian 2.6.10 kernel. 
> So it should work, but..
> 
> Is there some patches I could try? 
Hi !
I am so glad to find somebody interested in this issue ;-)

I am not sure about which watchdog is working in the P8SCi. On my P4Sci, the 
working watchdog was the one in Intel's southbridge with the i8xx-tco driver. I 
tried to use this driver with the P8SAA. To do that I had to use 2.6.11rc2bk9 to 
get ICH6 support in the i8xx-tco driver. But as you may know, the watchdog is 
not working on the P8SAA.

This might be a good bet for you.

	sincerely,

	P.O. Gaillard



