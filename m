Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVFTUHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVFTUHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFTUHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:07:11 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:8092 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261539AbVFTTv5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:51:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QenA6a66hxisLwGzkCr2Em+F+3AyPF7PJdJFBX3m4SkC35ENAGupXkmRQbXMHkm0RuqN9zPNBncYxY6Ha1w20KcBDb9yGvphoRm9envVvDu0LTpTFmRBUZdi1askPAcR/m6MkeDPO/2AKyFBv/pj00WKSxPmLcLDKUd1ensjaE8=
Message-ID: <25381867050620125136e58c6d@mail.gmail.com>
Date: Mon, 20 Jun 2005 15:51:55 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: abonilla@linuxwireless.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
In-Reply-To: <005b01c575bd$724fac60$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42B6F6F6.2040704@zipman.it>
	 <005b01c575bd$724fac60$600cc60a@amer.sykes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alejandro,

You aren't the only one interested in a Linux active protection
driver, and unfortunately you aren't the first person to try to get
IBM/Lenevo to release the specs for the interface (the chip
documentation itself is useless without it). Lenevo has clearly stated
in the past that it will not open up the specifications and/or write
an open source Linux driver for it at the moment because they consider
it a competitive advantage, if you search back through the lm_sensors
or lkml archives (I can't remember which I saw it in) you will find
the statement.

I myself have tried to determine where it is interfaced from. I
checked ACPI and I2c/Smbus (I don't recommend the latter, although
experimenting with lm_sensors/i2cdump on a thinkpad is often fatal
I've been lucky on my T42p) but with no luck. I had come to the
conclusion myself that it is interfaced through the embedded
controller. Unfortunately the embedded controller is not that well
supported by Linux itself, except what is supported through the
thinkpad (and company) kernel modules, and Lenz seems to think this is
not the case anyway.

If anyone managed to work out how to interface to the sensors (there
is I believe two sensors, an accelerometer and gyroscope) then I might
be willing to help, although I'm sure I haven't got the agility to
drop my notebook and catch it a few hundred times ;-).

On 6/20/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> >
> > > Well, some piece of software needs to park the HDD when the
> > notebook is
> > > falling, and that piece of software should better be
> > running since the
> > > notebook is powered on. Hence my suspicion it's in the
> > BIOS. It doesn't
> > > have to be visible to the user, at all.
> >
> > No, the software, under Windows, is an application; you can control
> > the behaviour of the disk based on the response of the chip.

Actually it is kind of both, notice when you are booting the thinkpad
pauses as it calibrates/initializes the sensor. If you are unlucky
enough to be on a bumpy train ride like I have been at times when
trying to boot the sensor subsystem can't calibrate/initialize and
won't let you boot. After that initial test though control seems to be
left to the userspace driver.

Yani
