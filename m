Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273296AbTG3TG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273297AbTG3TG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:06:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:34481 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S273296AbTG3TGV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:06:21 -0400
Date: Wed, 30 Jul 2003 21:06:18 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: herbert@13thfloor.at
Cc: Pavel Machek <pavel@suse.cz>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem
 ever
Message-Id: <20030730210618.5af8e5bb.gigerstyle@gmx.ch>
In-Reply-To: <20030730185659.GA7260@www.13thfloor.at>
References: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk>
	<20030730174457.GI10276@atrey.karlin.mff.cuni.cz>
	<20030730185659.GA7260@www.13thfloor.at>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 20:56:59 +0200
Herbert Pötzl <herbert@13thfloor.at> wrote:

> On Wed, Jul 30, 2003 at 07:44:57PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > But this kind of blinkenlights needed pretty fast LEDs. (At 486
> > > > time I decided that parport on ISA is fast enough..)
> > > 
> > > I'll buy some LEDs and build a parallel port connected LED panel
> > > tomorrow...  Do you think the overhead of driving the LEDs would
> > > have too much of a negative effect on system performance?  If so,
> > > or if we
> > 
> > I'm not sure. At 486 days I was pretty sure it did not matter. These
> > days you might get 10% slowdown on some microbenchmark, or something
> > like that. I do not think it can slow down common tasks.
> > 
> > My construction of LED lights is extremely flaky, and I'm afraid of
> > burning printer port. At 486 days ports were expected to survive
> > such abuse. Not sure if todays EPP/wtf ports can handle that.
> 
> parport uses 5V (actually a little less) so if you
> use normal (not extra super duper bright) leds and
> put a 1kOhm resistor in front of each led, then it
> will drain 5mA per led, which gives a total of 40mA
> for eight leds (for example)

5mA per LED on the same line. 40mA if you connect all to the same
dataline or GND-line.

> 
> now for the parport: depending on the technology
> and the age of the circuit, it provides between
> 2 and 14mA output at >2.4V (the led usually requires
> less than 1.5V to operate) so this would be within
> the range ... but, if you want either extra brightness
> or extra security, you could provide +5V and use
> the outputlines as sink, which then is between
> 15 and 25mA ...
> 
> anyway, parport should be short circuit safe, so
> the worst what could happen is, that the leds are
> not working ;) ...

Are you sure?? I thought this is true for serial-port...

> 
> HTH,
> Herbert
> 
> PS: I usually use 220Ohm and no external power ...

The same here...

greets

Marc
