Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWGCLbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWGCLbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWGCLbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:31:25 -0400
Received: from sd291.sivit.org ([194.146.225.122]:23568 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1750866AbWGCLbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:31:25 -0400
Subject: Re: [RFC] Apple Motion Sensor driver
From: Stelian Pop <stelian@popies.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, khali@linux-fr.org,
       linux-kernel@killerfox.forkbomb.ch, johannes@sipsolutions.net,
       chainsaw@gentoo.org
In-Reply-To: <1151923799.19419.49.camel@localhost.localdomain>
References: <20060702222649.GA13411@hansmi.ch>
	 <1151921567.10711.22.camel@localhost.localdomain>
	 <20060703104547.GA25342@hansmi.ch>
	 <1151923799.19419.49.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 03 Jul 2006 13:31:18 +0200
Message-Id: <1151926278.10711.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 03 juillet 2006 à 20:49 +1000, Benjamin Herrenschmidt a écrit :
> On Mon, 2006-07-03 at 12:45 +0200, Michael Hanselmann wrote:
> > On Mon, Jul 03, 2006 at 12:12:47PM +0200, Stelian Pop wrote:
> > > > +
> > > > +static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
> > > > +	ams_mouse_show_mouse, ams_mouse_store_mouse);
> > 
> > > I would prefer three different files for x, y and z instead of a single
> > > one... 
> > 
> > Because of the way the values are calculated with orientation, that
> > would mean that if a program needs all three, either all values are read
> > three times or the ams_sensors function gets much more complicated.
> > 
> > To prevent it from having to read them three times in a row, I joined
> > all three values.
> > 
> > Do you think I should rewrite the ams_sensors function to only get the
> > correct value?
> 
> Cache the values and only re-read from the hardware after a given amount
> of time has elapsed ?

Seems to be a good idea indeed.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

