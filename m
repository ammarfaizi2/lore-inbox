Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269931AbUICWZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269931AbUICWZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269933AbUICWZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:25:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42513 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269931AbUICWZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:25:13 -0400
Date: Fri, 3 Sep 2004 23:25:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org,
       Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040903232507.A8810@flint.arm.linux.org.uk>
Mail-Followup-To: John Lenz <lenz@cs.wisc.edu>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org,
	Kalin KOZHUHAROV <kalin@thinrope.net>
References: <1094157190l.4235l.2l@hydra> <ch8tdd$1uf$1@sea.gmane.org> <20040903120634.GK6985@lug-owl.de> <1094237243l.7429l.1l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094237243l.7429l.1l@hydra>; from lenz@cs.wisc.edu on Fri, Sep 03, 2004 at 06:47:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 06:47:23PM +0000, John Lenz wrote:
> On 09/03/04 07:06:34, Jan-Benedict Glaw wrote:
> > Is idle/timer/power hardware-controlled (eg. by a secondary processor,
> > direct chipset implementation) or is switching on/off controlled by
> > kernel (eg. heartbeat, IO and ethernet for the LEDs you can find on some
> > PA-RISC machines)?
> 
> Right now the kernel is in sole control.  The device I am testing this on  
> is a Sharp Zaurus SL5500, which has two leds that by default are used to  
> light when new mail arrives and if the power is plugged in.

The kernel is NOT in sole control today on ARM platforms:

echo claim > /sys/devices/system/leds/leds0/event
echo red on > /sys/devices/system/leds/leds0/event
echo green on > /sys/devices/system/leds/leds0/event
echo red off > /sys/devices/system/leds/leds0/event
echo release > /sys/devices/system/leds/leds0/event

etc

Sure, we have a weird naming scheme (red, green, amber, blue) but
that came around because that's what people were dealing with.
There's nothing really stopping us from having any name for a LED
in the existing scheme.

I just don't buy the "we must have one sysfs node for every LED"
argument.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
