Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWGCKpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWGCKpu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWGCKpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:45:50 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:38685 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750719AbWGCKpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:45:49 -0400
Date: Mon, 3 Jul 2006 12:45:47 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch,
       benh@kernel.crashing.org, johannes@sipsolutions.net,
       chainsaw@gentoo.org
Subject: Re: [RFC] Apple Motion Sensor driver
Message-ID: <20060703104547.GA25342@hansmi.ch>
References: <20060702222649.GA13411@hansmi.ch> <1151921567.10711.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151921567.10711.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 12:12:47PM +0200, Stelian Pop wrote:
> > +
> > +static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
> > +	ams_mouse_show_mouse, ams_mouse_store_mouse);

> I would prefer three different files for x, y and z instead of a single
> one... 

Because of the way the values are calculated with orientation, that
would mean that if a program needs all three, either all values are read
three times or the ams_sensors function gets much more complicated.

To prevent it from having to read them three times in a row, I joined
all three values.

Do you think I should rewrite the ams_sensors function to only get the
correct value?

Thanks,
Michael

(All other issues, including those in the other mails, are clear and
will be addressed by a new patch)
