Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbULaVQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbULaVQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 16:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbULaVQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 16:16:42 -0500
Received: from mail.tmr.com ([216.238.38.203]:64455 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261163AbULaVQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 16:16:39 -0500
Message-ID: <41D5C459.8050601@tmr.com>
Date: Fri, 31 Dec 2004 16:27:53 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terry Hardie <terryh@orcas.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Asus P4C800-E Deluxe and Intel Pro/1000
References: <200411112003.43598.Gregor.Jasny@epost.de><6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com> <Pine.LNX.4.58.0412262127510.3478@orcas.net>
In-Reply-To: <Pine.LNX.4.58.0412262127510.3478@orcas.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Hardie wrote:
> Well, this has been plauging me for months, and finally figured it out.
> 
> Any 2.6 kernel on my board, would boot, then give errors (paraphrased,
> sorry) when I tried to bring up the ethernet:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> IRQ #18: Nobody cared!
> 
> And no ethernet conectivity.
> 
> The Fix: Update bios from asus' website. I guess their ACPI was screwed
> up. This is the second time I've had to update this MB to fix
> incompatibilities with Linux. So, watch out with Asus boards on Linux.
> 
> BTW - Linux 2.4's driver worked fine with the old bios. Only 2.6 didn't
> work.

Some additional info, I've been investigating this for a few hours, and 
it appears that (a) IRQ 18 on my system is shared by ide0 and ide1, and 
that the IRQ storm seems to start the first time I use ide1 (DVD only).

I will be posting a bunch of dmesg results when/if the system reboots, 
but acpi={off,ht} doesn't help, pollirq doesn't help, and system 
shutdown leaves the system unbootable without a full (pull the power 
cord) hardware power cycle.

Questions:
1 - do you have trouble rebooting after a failure?
2 - do you see the IRQ 18 storm start just after the first use of ide1?
3 - and of course if you can get up in console mode, are ide0 and ide1 
shared?

I may rebuild the kernel with IRQ share off just to see if that helps.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
