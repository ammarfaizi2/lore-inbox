Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTHWKro (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 06:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbTHWKro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 06:47:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23055 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262491AbTHWKrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 06:47:42 -0400
Date: Sat, 23 Aug 2003 11:47:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030823114738.B25729@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Pavel Machek <pavel@ucw.cz>, torvalds@osdl.org,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030822210800.GA4403@elf.ucw.cz> <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain>; from mochel@osdl.org on Fri, Aug 22, 2003 at 02:25:46PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 02:25:46PM -0700, Patrick Mochel wrote:
> > As far as I can see, I'm still maintainer of software suspend. That
> > did not stop you from crying "split those patches" when I tried to
> > submit changes to my code, and you were pretty pissed off when I tried
> > to push trivial one liners without contacting maintainers.
> 
> Ok, I'm sorry. I should not have broken anything in your code, and 
> actually significantly improved it. 

There is however a pretty large problem which now needs to be fixed,
and it goes by the name of "power management".

There is a hell of a lot of work which now needs to be done to re-fix
everything which was working.  For example, there is no sign of any
power management for platform devices currently.  Could you give some
clues as to what you'd like to see there?

There's also a fair number of drivers to update to this new power
management model - eg, ARM device drivers, PCMCIA socket drivers to
name just two.

We also need to fix the device model probing so we can have a generic
PCI bridge driver but override it if we have a more specific driver.

I did ask to see the code and make preparations for this type of
change...  Since the driver model and power management is fundamental
to many subsystems, I think it would be a good thing to have at least
a few days for review of the changes on lkml.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

