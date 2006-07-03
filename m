Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWGCKwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWGCKwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWGCKwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:52:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:10413 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750790AbWGCKwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:52:22 -0400
Subject: Re: [RFC] Apple Motion Sensor driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, khali@linux-fr.org,
       linux-kernel@killerfox.forkbomb.ch, johannes@sipsolutions.net,
       chainsaw@gentoo.org
In-Reply-To: <20060703104547.GA25342@hansmi.ch>
References: <20060702222649.GA13411@hansmi.ch>
	 <1151921567.10711.22.camel@localhost.localdomain>
	 <20060703104547.GA25342@hansmi.ch>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 20:49:59 +1000
Message-Id: <1151923799.19419.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 12:45 +0200, Michael Hanselmann wrote:
> On Mon, Jul 03, 2006 at 12:12:47PM +0200, Stelian Pop wrote:
> > > +
> > > +static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
> > > +	ams_mouse_show_mouse, ams_mouse_store_mouse);
> 
> > I would prefer three different files for x, y and z instead of a single
> > one... 
> 
> Because of the way the values are calculated with orientation, that
> would mean that if a program needs all three, either all values are read
> three times or the ams_sensors function gets much more complicated.
> 
> To prevent it from having to read them three times in a row, I joined
> all three values.
> 
> Do you think I should rewrite the ams_sensors function to only get the
> correct value?

Cache the values and only re-read from the hardware after a given amount
of time has elapsed ?

> Thanks,
> Michael
> 
> (All other issues, including those in the other mails, are clear and
> will be addressed by a new patch)

