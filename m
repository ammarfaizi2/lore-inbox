Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVBWUWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVBWUWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVBWUWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:22:02 -0500
Received: from hyperion.affordablehost.com ([12.164.25.86]:28067 "EHLO
	hyperion.affordablehost.com") by vger.kernel.org with ESMTP
	id S261558AbVBWUU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:20:27 -0500
Subject: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
From: Alan Kilian <kilian@bobodyne.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 23 Feb 2005 14:24:33 -0600
Message-Id: <1109190273.9116.307.camel@desk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hyperion.affordablehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bobodyne.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



    Folks,

	This group was instrumental in helping me get my first-ever
	linux/PCI-bus device driver working last year, and I'm back for
	some more help if you are willing.

	I have a PCI card that generates an interrupt when it completes
	a DMA transfer to the PCs RAM.

	This works just fine on a Dell 4400 running 2.6.10-1.766_FC3

	When I try to run the driver on a Dell 2300 FC2/2.6.5-1.358smp
	or a Sun W2100Z running FC2/2.6.10-1.14_FC2smp I can see the
	DMA-done bit set in the device, but my interrupt service routine
	never gets called.

	On the Sun, I booted with "noapic" option, and it booted OK,
	but then when my device generated an interrupt, there was a
	kernel message about Disabling IRQ #5 and the system was hung
	solidly.

	I think this has something to do with the different interrupt
	hardware on the more advanced servers compared to my desktop
	Dell 4400, and I somehow need to "enable" the IOAPIC system
	so that my interrupt gets through to my service routine, but I
	don't know how.

	I tried grepping through the kernel/drivers source, and I didn't
	find anything that jumped out at me.

	The Rubini drivers book didn't help in this area either, 
	although it's a wonderful book in other areas.

	I can post source somewhere if it will help.

	I can also post the essential bits from /var/log/messages about
	all the incredibly complicated IOAPIC configuration stuff.

	Thank you for your past help, and thank you in advance for any
	tips you can provide.

				-Alan

-- 
- Alan Kilian <kilian(at)bobodyne.com>


