Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTHYROY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTHYROY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:14:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49932 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262120AbTHYROU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:14:20 -0400
Date: Mon, 25 Aug 2003 18:14:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030825181415.F16790@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Porter <mporter@kernel.crashing.org>,
	Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
References: <20030823114738.B25729@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308250840360.1157-100000@cherise> <20030825172737.E16790@flint.arm.linux.org.uk> <20030825095720.B28149@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825095720.B28149@home.com>; from mporter@kernel.crashing.org on Mon, Aug 25, 2003 at 09:57:20AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 09:57:20AM -0700, Matt Porter wrote:
> Alternatively, you could leave the platform model as is (it's only
> for really dumb devices).

Thing is that we use the platform model for off chip devices as well.
On ARM, its gets used for any device which the platform code knows
where it is located.  ie, a platform device.

> On PPC, we have an OCP (on chip peripheral)
> model that is mostly integrated into the device model now.  OCP is
> just another bus/driver type and so PM works in the normal fashion.

Ah, but OCP can't be used to describe a platform dependent SMC91x
network interface that some random designer decided to drop into
their design - it isn't part of the SoC.

> There's a driver API around it as well so we can cleanly share drivers
> across various SoC implementations with different base address,
> IRQ mappings, etc.  It might be more useful to extende this across
> the architectures that need it.

Note that we've already done some public work on providing flexible
platform device support to satisfy the needs of platform people -
by adding the variable number of resources to the platform device.

Also note that most of the x86 ISA PCMCIA devices _are_ platform
devices today.  As of this new power management model, they're
broken due to the fact that they no longer receive power management
events.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

