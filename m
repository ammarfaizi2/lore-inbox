Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWCYT0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWCYT0i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWCYT0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:26:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24080 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750830AbWCYT0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:26:37 -0500
Date: Sat, 25 Mar 2006 20:26:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Security downgrade? CONFIG_HOTPLUG required in 2.6.16?
Message-ID: <20060325192635.GQ4053@stusta.de>
References: <44237D87.70300@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44237D87.70300@tlinx.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 09:03:03PM -0800, Linda Walsh wrote:
> I had this config'ed out in 2.6.15 for machine that didn't have
> any hotpluggable devices.  It is also configured with all the
> modules it needs and has kernel-module loading disabled.
> 
> What has changed in 2.6.16 that my "static" machine now
> needs hotplugging?  As I understand it, hotplugging requires 
> application-level support code (in /etc/) and a special
> application level "demon" to run in order to support these
> requests.
> 
> I'd prefer my kernel not to be dependent on a run-time demon
> to load "arbitrary" (user defined) segments of code that could
> come from any source -- usually outside the vanilla kernel tree.
> 
> If I don't want a specific kernel or machine to be dynamically
> reconfigurable after boot, why do I need to build in a mechanism for
> runtime loading of modules?

- hotplugging devices != module loading
- CONFIG_HOTPLUG does not load any code into the kernel.
- hotplugging devices can work without any userspace support

As an example, hotplugging an USB hard disk works fine with 
CONFIG_MODULES=n and without any userspace support (assuming
a static /dev).

> Linda

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

