Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRC2SdY>; Thu, 29 Mar 2001 13:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRC2SdO>; Thu, 29 Mar 2001 13:33:14 -0500
Received: from mail-oak-1.pilot.net ([198.232.147.16]:46996 "EHLO
	mail01-oak.pilot.net") by vger.kernel.org with ESMTP
	id <S132807AbRC2SdD>; Thu, 29 Mar 2001 13:33:03 -0500
Message-ID: <973C11FE0E3ED41183B200508BC7774C0124F0C2@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, andrew.grover@intel.com
Cc: pavel@suse.cz, sfr@canb.auug.org.au,
   "Woller, Thomas" <twoller@crystal.cirrus.com>, linux-kernel@vger.kernel.org
Subject: RE: Incorrect mdelay() results on Power Managed Machines x86
Date: Thu, 29 Mar 2001 12:30:36 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i talked with Keith Frechette at IBM, he is in charge of Linux for IBM.  he
indicated that they are working issues with INTEL speedstep and Linux for
their newer laptops, albeit not at a swift pace.  he will probably contact
the linux community at some point to help solve issues with SpeedStep, but
he affirms that INTEL treats this information as proprietary, so not sure
how much work can be done for linux.  he also indicated that some of the
older IBM models did some non-standard manipulation with the CPU speed at
runtime, e.g. what I am seeing with mdelay failing if booting on a 600X on
battery power.  most likely, no event notification would be available for
any of these CPU speed manipulations.  
I am going to send some info on the issue to Keith, and he is going to
forward to the technical IBM folks somewhere at IBM, but any solution would
most likely be specific to IBM for the cs46xx audio driver.  
It does sound like the PM timer is the best idea so far.
Tom
twoller@crystal.cirrus.com

> -----Original Message-----
> From:	Alan Cox [SMTP:alan@lxorguk.ukuu.org.uk]
> Sent:	Wednesday, March 28, 2001 10:11 PM
> To:	andrew.grover@intel.com
> Cc:	pavel@suse.cz; alan@lxorguk.ukuu.org.uk; sfr@canb.auug.org.au;
> twoller@crystal.cirrus.com; linux-kernel@vger.kernel.org
> Subject:	Re: Incorrect mdelay() results on Power Managed Machines x86
> 
> > I know on ACPI systems you are guaranteed a PM timer running at ~3.57
> Mhz.
> > Could udelay use that, or are there other timers that are better (maybe
> > without the ACPI dependency)? 
> 
> We could use that if ACPI was present. It might be worth exploring. Is
> this
> PM timer well defined for accesses  ?
