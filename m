Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTHXLy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 07:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTHXLy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 07:54:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48146 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263482AbTHXLyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 07:54:18 -0400
Date: Sun, 24 Aug 2003 12:54:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       torvalds@osdl.org
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030824125413.B16635@flint.arm.linux.org.uk>
Mail-Followup-To: kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	torvalds@osdl.org
References: <20030822210800.GA4403@elf.ucw.cz> <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain> <20030823114738.B25729@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030823114738.B25729@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Aug 23, 2003 at 11:47:38AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 11:47:38AM +0100, Russell King wrote:
> I did ask to see the code and make preparations for this type of
> change...  Since the driver model and power management is fundamental
> to many subsystems, I think it would be a good thing to have at least
> a few days for review of the changes on lkml.

Pat, can we have a set of configuration options to disable a lot of the
generic (!) code in kernel/power/*.c which isn't useful on embedded
platforms?

I'm looking at stuff like the swsusp infrastructure for clearing out
memory, suspending to disk, the PM state management, etc?  This type
of stuff isn't at all useful on embedded platforms.

On these platforms, you'd typically suspend all the devices except for
a select few which would cause wake-up, put the RAM into self-refresh
mode, and send the CPU to sleep and put the whole device into a low
power "off" state.

This requires none of the swsusp-like infrastructure, so I don't need
most of the "generic" power code in kernel/power which I get for free
just by enabling CONFIG_PM.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

