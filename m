Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283031AbRK1Pv0>; Wed, 28 Nov 2001 10:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283078AbRK1PvN>; Wed, 28 Nov 2001 10:51:13 -0500
Received: from hermes.toad.net ([162.33.130.251]:38545 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S283062AbRK1Pty>;
	Wed, 28 Nov 2001 10:49:54 -0500
Subject: Re: PNP Bios
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 10:50:42 -0500
Message-Id: <1006962643.11753.2.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I plan to submit PnP BIOS to 2.5 but not 2.4 - it needs more study yet

I presume that the aspect of the driver that needs more study
is the interface between the pnpbios driver and other device
drivers.

The pnpbios driver the -ac kernels had a driver registration
interface.  Is that the only or the best way for drivers to
use the PnP BIOS?  Given that a lot of drivers already use
the isa-pnp driver, wouldn't it be cleaner if the pnpbios
driver were integrated with the isa-pnp driver, such that
isa-pnp could used pnpbios as a slave to do its configuration
dirty work?  Then there would be just one pnp interface for
all drivers to use.

However we decide to make pnpbios services available to
drivers, we have smp and hotplug issues to sort out too.

Although it may be appropriate for us to think more about the
latter issues, I see no reason why we shouldn't put the core
functions of the pnpbios driver (viz., the PnP BIOS interface
functions), along with the /proc interface to these, into 2.5
right away.  For that matter, they can go into 2.4 as well.
They have been pretty well tested by now.  This would at least
allow us to use lspnp and setpnp to control the way the
PnP BIOS configures our machines.  Mark the driver
"experimental" if you like, but please put it in.

Thomas


