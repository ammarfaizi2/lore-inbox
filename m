Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268046AbTBNXS3>; Fri, 14 Feb 2003 18:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268048AbTBNXS3>; Fri, 14 Feb 2003 18:18:29 -0500
Received: from fmr01.intel.com ([192.55.52.18]:31741 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268046AbTBNXSY>;
	Fri, 14 Feb 2003 18:18:24 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
In-Reply-To: <20030214213542.GH23589@atrey.karlin.mff.cuni.cz>
References: <1045106216.1089.16.camel@vmhack>
	<1045160506.1721.22.camel@vmhack> <20030213230408.GA121@elf.ucw.cz>
	<1045260726.1854.7.camel@irongate.swansea.linux.org.uk> 
	<20030214213542.GH23589@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Feb 2003 15:17:30 -0800
Message-Id: <1045264651.13488.40.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 13:35, Pavel Machek wrote:
> Hi!
> 
> > > > temperature (RO)
> > > >   - show: prints temperature in degrees farenheit
> > > 
> > > Please, use degrees celsius to keep it consistent with ACPI and
> > > lm-sensors.
> > 
> > The ioctl interface is farenheit and has been since before Linux 2.0
> > That may not have been smart but we are stuck with it there at
> > least.
> 
> Oops, that's bad.
> 
> But I believe we should make it celsius in /sys, even if it means
> conversion somewhere.
> 
> 								Pavel

The watchdog infrastructure would just show what ever integer the driver
provides via the watchdog_ops.get_temperature() function pointer, so it
would be up to the driver developer to decide if the data is really
Fahrenheit or whatever.

    --rustyl 

