Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVBZRNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVBZRNa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 12:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVBZRNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 12:13:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50446 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261235AbVBZRN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 12:13:27 -0500
Date: Sat, 26 Feb 2005 18:13:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] deprecate EXPORT_SYMBOL(do_settimeofday)
Message-ID: <20050226171325.GO3311@stusta.de>
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050226133337.GK3311@stusta.de> <20050226144635.B7151@flint.arm.linux.org.uk> <20050226162341.GN3311@stusta.de> <20050226164613.E7151@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226164613.E7151@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 04:46:13PM +0000, Russell King wrote:
>...
> There are a number of ARM platforms which use a Ricoh RTC chip, and
> the driver for this will live in drivers/i2c/chips/ricoh-rtc.c.  This
> is a stand alone driver in its own sense, handling the power management
> issues (saving the time offset/restoring the time) and setting the
> system time upon its initialisation.  (In turn, this requires some i2c
> patches which add power management to the i2c subsystem to be merged
> first.)
> 
> It's already used in some ARM platforms, including one which I was
> involved in.  It just hasn't been merged.
> 
> As far as drivers/acorn/char i2c rtc stuff goes, I plan to make this
> a full and proper i2c citizen, so adding breakage to the Kconfig with
> random select statements for publically viewable symbols isn't the
> way to go.

You call it "breakage" because you have a relatively dogmatic view 
regarding the selection of user visible symbols.
Other people care more about the usability of the kernel config system, 
and therefore a select of one of the I2C* options is quite common from 
both outside and inside the i2c subsystem.

There are two possbile situations:
- these RTC drivers are nice add-ons that could be shown if all
  required I2C* options are already enabled
- these RTC drivers are pretty essential and should really be enabled
  on the platforms they are for

Which of these two cases describes the situation of these RTC drivers?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

