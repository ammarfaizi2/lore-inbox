Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbTIBMtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTIBMpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:45:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52191 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261499AbTIBMnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 08:43:50 -0400
Date: Mon, 1 Sep 2003 14:02:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030901120208.GC1358@openzaurus.ucw.cz>
References: <20030823114738.B25729@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308250840360.1157-100000@cherise> <20030825172737.E16790@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825172737.E16790@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I think we need to expand the platform device support to include the
> notion of platform drivers.  For example:
> 
> 	struct platform_driver {
> 		int (*probe)(struct platform_device *);
> 		int (*remove)(struct platform_device *);
> 		int (*suspend)(struct platform_device *, u32);
> 		int (*resume)(struct platform_device *);
> 		struct device_driver drv;
> 	};
> 
> (Aside: I like the movement of the suspend/resume methods to the bus_type,
> and I'd like to see the probe/remove methods also move there.  For the
> vast majority of cases, the probe/remove methods in struct device_driver
> end up pointing at the same functions for any particular bus.)

But what about those few devices that need special handling? Like flush write cache on
IDE disk but not on cdrom?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Hi!

> I think we need to expand the platform device support to include the
> notion of platform drivers.  For example:
> 
> 	struct platform_driver {
> 		int (*probe)(struct platform_device *);
> 		int (*remove)(struct platform_device *);
> 		int (*suspend)(struct platform_device *, u32);
> 		int (*resume)(struct platform_device *);
> 		struct device_driver drv;
> 	};
> 
> (Aside: I like the movement of the suspend/resume methods to the bus_type,
> and I'd like to see the probe/remove methods also move there.  For the
> vast majority of cases, the probe/remove methods in struct device_driver
> end up pointing at the same functions for any particular bus.)

But what about those few devices that need special handling? Like flush write cache on
IDE disk but not on cdrom?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

