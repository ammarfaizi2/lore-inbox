Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVBZRUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVBZRUn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 12:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVBZRUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 12:20:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14092 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261237AbVBZRUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 12:20:25 -0500
Date: Sat, 26 Feb 2005 17:20:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] deprecate EXPORT_SYMBOL(do_settimeofday)
Message-ID: <20050226172018.A15124@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050226133337.GK3311@stusta.de> <20050226144635.B7151@flint.arm.linux.org.uk> <20050226162341.GN3311@stusta.de> <20050226164613.E7151@flint.arm.linux.org.uk> <20050226171325.GO3311@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050226171325.GO3311@stusta.de>; from bunk@stusta.de on Sat, Feb 26, 2005 at 06:13:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 06:13:25PM +0100, Adrian Bunk wrote:
> You call it "breakage" because you have a relatively dogmatic view 
> regarding the selection of user visible symbols.
> Other people care more about the usability of the kernel config system, 
> and therefore a select of one of the I2C* options is quite common from 
> both outside and inside the i2c subsystem.
> 
> There are two possbile situations:
> - these RTC drivers are nice add-ons that could be shown if all
>   required I2C* options are already enabled
> - these RTC drivers are pretty essential and should really be enabled
>   on the platforms they are for
> 
> Which of these two cases describes the situation of these RTC drivers?

Since RTCs aren't _actually_ essential for Linux kernel operation,
the former clearly applies.

Other people may have differing opinions, but having worked with a
large number of SoC platforms where the RTC is reset when the SoC
is reset, or even platforms where there is no RTC at all, it brings
a different perspective to this that people who have only ever
experienced systems where the RTC is always true do not have.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
