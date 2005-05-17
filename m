Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVEQDbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVEQDbC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 23:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVEQDbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 23:31:01 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:58082 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261233AbVEQDax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 23:30:53 -0400
Date: Mon, 16 May 2005 21:29:47 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
In-reply-to: <44PRr-6mz-33@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4289652B.7020408@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <43Bnu-Ut-9@gated-at.bofh.it> <44sLm-3Mg-33@gated-at.bofh.it>
 <44sUX-42h-11@gated-at.bofh.it> <44teb-4fb-1@gated-at.bofh.it>
 <44uaj-4Z3-5@gated-at.bofh.it> <44LXu-2W6-15@gated-at.bofh.it>
 <44OVj-5xS-3@gated-at.bofh.it> <44PRr-6mz-33@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Then I suggest you never use such a drive. Anything that does this,
> will end up replacing a good track with garbage. Unless a disk drive
> has a built-in power source such as super-capacitors or batteries, what
> happens during a power-failure is that all electronics stops and
> the discs start coasting. Eventually the heads will crash onto

If the power to the drive is truly just cut, then this is basically what 
will happen. However, I have heard, for what it's worth, that in many 
cases if you pull the AC power from a typical PC, the Power Good signal 
from the PSU will be de-asserted, which triggers the Reset line on all 
the buses, which triggers the ATA reset line, which triggers the drive 
to finish writing out the sector it is doing. There is likely enough 
capacitance in the power supply to do that before the voltage drops off.

> the platter. Older discs had a magnetically released latch which would
> send the heads to an inside landing zone. Nobody bothers anymore.

Sure they do. All current or remotely recent drives (to my knowledge, 
anyway) will park the heads properly at the landing zone on power-off. 
If the drive is told to power off cleanly, this works as expected, and 
if the power is simply cut, the remaining energy in the spinning 
platters is used like a generator to provide power to move the head 
actuator to the park positon.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

