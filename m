Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268827AbUHLWGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268827AbUHLWGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268812AbUHLWEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:04:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51466 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268844AbUHLWDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:03:42 -0400
Date: Thu, 12 Aug 2004 23:03:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, benh@kernel.crashing.org, david-b@pacbell.net
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040812230333.C13553@flint.arm.linux.org.uk>
Mail-Followup-To: Todd Poynor <tpoynor@mvista.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	linux-kernel@vger.kernel.org, pavel@ucw.cz,
	benh@kernel.crashing.org, david-b@pacbell.net
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <41197ABA.6080107@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41197ABA.6080107@mvista.com>; from tpoynor@mvista.com on Tue, Aug 10, 2004 at 06:47:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 06:47:38PM -0700, Todd Poynor wrote:
> Divorcing device power states from ACPI-defined integers would be very 
> nice for embedded platforms.  Usually the platform bus would be 
> involved.  Since the proposal tends to place more responsibility on the 
> bus driver, I'm interested in the intended usage for platform devices. 
> For example, are platform_device callbacks for 
> suspend/resume/save/restore of the particular device still needed?  How 
> does the platform bus driver map (platform-specific?) system states to 
> device states?

platform devices are still a reminance of the previous PM model
incarnation, and where merely patched over to make them work again
in todays model.

It would be nice to have a proper platform_device_driver structure
so we could finally kill the otherwise unused PM methods in struct
device_driver and finally get rid of the old PM model.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
