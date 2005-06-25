Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVFYUOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVFYUOc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 16:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVFYUOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 16:14:31 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:56462 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261314AbVFYUO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 16:14:28 -0400
Date: Sat, 25 Jun 2005 22:14:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Message-ID: <20050625201442.GB1591@ucw.cz>
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <20050625144736.GB7496@atrey.karlin.mff.cuni.cz> <20050625150030.GA1636@ucw.cz> <42BD9F1E.5090407@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BD9F1E.5090407@linuxwireless.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 01:14:54PM -0500, Alejandro Bonilla wrote:
> >>I think you got it... 2ports seem like enough for some kind of small
> >>u-controller...
> >>   
> >>
> >
> >Quite possibly the ACPI EC. Most likely a side entrance into the onboard 
> >8042.
> >
> > 
> >
> Vojtech,
> 
>    What is the onboads 8042?

Every PC has a small microprocessor on the mainboard, descended from the
ancient Intel i8042. It is primarily intended to take care of the
keyboard and mouse, but in notebooks the input functionality is
overshadowed by other uses.

Those often include: Battery monitoring and communication, display
backlight control, power on/off, and similar stuff.

It is usually accessible through ACPI, and ACPI calls it the EC -
embedded controller. ACPI doesn't mandate the EC to be the 8042, they
could be separate, but for cost reasons, they usually are the same chip.

Since the 8042 is the chip where you attach stuff that no other chip
wants, it's probably the primary choice for connecting the ADXL output.

A small problem is that the 8042 normally doesn't have any ADCs,
however, I assume most of the 8042 implementations in modern notebooks
do have at least a few ADCs, for battery monitoring, etc.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
