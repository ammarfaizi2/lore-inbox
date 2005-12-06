Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbVLFWrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVLFWrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVLFWrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:47:35 -0500
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:5612 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S932651AbVLFWre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:47:34 -0500
Date: Tue, 6 Dec 2005 14:47:28 -0800
To: Jiri Benc <jbenc@suse.cz>, netdev@vger.kernel.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Michael Renzmann <netdev@nospam.otaku42.de>,
       Pavel Machek <pavel@suse.cz>, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051206224728.GA31894@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Benc wrote :
> On Mon, 05 Dec 2005 13:46:43 -0500, Jeff Garzik wrote:
> > Use the stack that's already in the kernel.
> > 
> > Encouraging otherwise hinders continued wireless progress under Linux.
> 
> There is nothing like a "802.11 stack" currently in the kernel,
> regardless what James Ketrenos is saying. Sorry.

	Hi,

	Sorry to intrude in your happy flamefest ;-)

	I take offense to what your are saying. There has been many
"802.11 stacks" floating over the years (check my web page). However,
only James went through the pain of getting one in the kernel. That's
not something that should be underestimated.
	Now, with respect to the "best" stacks. Some will argue that
the linux-wlan-ng has the most maturity. Some will argue that the
MadWifi stack is used by *BSD. Some will argue that the devicescape
has most features. All this arguing leads to nowhere...

	Personally, I'm a pragmatic a heart. The most important thing
to me is end-user support. 99% of our users don't care about advanced
features, they just want their hardware to work out of the box (and
the people who want the advanced features are usually willing to patch
their kernels). They don't care how we do the plumbing internally.
	Therefore, for me, a stack is only as good as the number of
drivers that support it. And this is where the devicescape stack is
lacking.

IPW stack :
	drivers using it : ipw2100, ipw2200
	drivers in progress : rt2x000, bcm430x
	potential drivers : r8180, adm8211, hostap

MadWifi stack :
	drivers using it : MadWifi (non GPL)
	drivers in progress : FreeHAL Atheros, Prism54 softMAC, ural-ralink

DeviceScape stack :
	drivers using it : ?
	potential drivers : hostap, ipw2100, ipw2200, r8180, adm8211

	If you want to use the DeviceScape stack instead of the IPW
stack, my first question is how do you plan to migrate the drivers
using it to the new stack. Currently, people are hard at work
targetting the IPW stack (see above), I don't want them to have to
throw away all their work.
	In particular, iwp2*00 are working today in the kernel, and I
expect that they would be migrated to the new stack at the stack
switchover. As both the IPW and the DeviceScape stacks are derived
from the HostAP stack, that should not be too hard.
	Also, what puzzle me is that Jouni doesn't seem to have
anounced any plan to port his HostAP driver to his DeviceScape
stack. If there is one driver that should use it, that's HostAP.

	Have fun...

	Jean

	
