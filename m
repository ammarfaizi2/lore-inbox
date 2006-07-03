Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWGCIxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWGCIxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWGCIxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:53:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:12204 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750757AbWGCIxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:53:16 -0400
Subject: Re: [RFC] Apple Motion Sensor driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-kernel@killerfox.forkbomb.ch, johannes@sipsolutions.net,
       stelian@popies.net, chainsaw@gentoo.org
In-Reply-To: <20060703092958.8ca17e53.khali@linux-fr.org>
References: <20060702222649.GA13411@hansmi.ch>
	 <20060703092958.8ca17e53.khali@linux-fr.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 18:52:15 +1000
Message-Id: <1151916736.19419.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd rather leave it out for now, and merge it when it has a chance to
> work. Merging non-working code is confusing at best.

:)

> > I want this driver to be included in -mm as soon as possible, to get
> > test feedback and to get it included in 2.6.19 (or maybe 2.6.18? Who
> > knows. ;)). Thus I'd like to get your comments, suggestions, etc. on it.
> 
> 2.6.19 at best.

Oh, it's just a driver update for some powermac specific thingy, so
depending how long 2.6.18 takes, I have no problem as the powermac
maintainer letting that in once it's been properly fixed and reviewed.
(Which I don't have time to do right now neither, but possibly later).

There shouldn't be significant changes to the i2c side of it from
Stelian's driver anyway, more like a new backend using the PMU.

> > +config SENSORS_AMS
> > +	tristate "Motion sensor driver"
> > +	default y
> 
> No, not everyone has this device. We don't have a default for other
> hardware monitoring drivers.
> 
> This should depend on HWMON, and probably EXPERIMENTAL too, until it
> gets some wider testing.
> 
> Also please respect the alphabetical order.

It can stay default y as lons as it depends on PPC_PMAC (which it should
do anyway)

> If you are going to have many source files and a composite module,
> please create your own subdirectory under drivers/hwmon and put all
> your stuff here. The kernel build system is notoriously bad at handling
> multiple composite modules within the same subdirectory.

Agreed.

Cheers,
Ben.


