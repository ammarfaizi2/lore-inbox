Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUGPRpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUGPRpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUGPRpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:45:00 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:1758 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266357AbUGPRo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:44:58 -0400
Date: Fri, 16 Jul 2004 14:19:39 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
Message-ID: <20040716141939.B8270@mail.kroptech.com>
References: <10898500322333@kroah.com> <10898500321009@kroah.com> <20040716170716.GD8264@openzaurus.ucw.cz> <20040716171702.GA10598@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040716171702.GA10598@kroah.com>; from greg@kroah.com on Fri, Jul 16, 2004 at 10:17:03AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 10:17:03AM -0700, Greg KH wrote:
> On Fri, Jul 16, 2004 at 07:07:16PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > +menu "Dallas's 1-wire bus"
> > > +
> > > +config W1
> > > +	tristate "Dallas's 1-wire support"
> > > +	---help---
> > > +	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices 
> > > +	  such as iButtons and thermal sensors.
> > 
> > Just out of curiosity... are such devices really connected using one wire only,
> > or is it GND+5V+one data wire, or GND+power&data wire?
> 
> I'm pretty sure it's just 1 wire, at least for the devices I've seen.

It's GND+power&data. The device derives its power from transitions on
the data line driven by the master. Consequently there are some fairly
strict timing requirements on those pulses. Some devices can also be
powered by a dedicated VCC line which generally allows the device to
respond faster. A temperature sensor IC, for example, can usually
complete a conversion cycle much faster when it has dedicated power.

--Adam

