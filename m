Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWGCNQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWGCNQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWGCNQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:16:45 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:15209 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751141AbWGCNQo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:16:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAPe0qESBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [RFC] Apple Motion Sensor driver
Date: Mon, 3 Jul 2006 09:16:36 -0400
User-Agent: KMail/1.9.3
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch,
       johannes@sipsolutions.net, chainsaw@gentoo.org
References: <20060702222649.GA13411@hansmi.ch> <1151923799.19419.49.camel@localhost.localdomain> <1151926278.10711.25.camel@localhost.localdomain>
In-Reply-To: <1151926278.10711.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607030916.37896.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 07:31, Stelian Pop wrote:
> Le lundi 03 juillet 2006 à 20:49 +1000, Benjamin Herrenschmidt a écrit :
> > On Mon, 2006-07-03 at 12:45 +0200, Michael Hanselmann wrote:
> > > On Mon, Jul 03, 2006 at 12:12:47PM +0200, Stelian Pop wrote:
> > > > > +
> > > > > +static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
> > > > > +	ams_mouse_show_mouse, ams_mouse_store_mouse);
> > > 
> > > > I would prefer three different files for x, y and z instead of a single
> > > > one... 
> > > 
> > > Because of the way the values are calculated with orientation, that
> > > would mean that if a program needs all three, either all values are read
> > > three times or the ams_sensors function gets much more complicated.
> > > 
> > > To prevent it from having to read them three times in a row, I joined
> > > all three values.
> > > 
> > > Do you think I should rewrite the ams_sensors function to only get the
> > > correct value?
> > 
> > Cache the values and only re-read from the hardware after a given amount
> > of time has elapsed ?
> 
> Seems to be a good idea indeed.
>

But what is the purpose of that attribute anyway? I'd just drop it completely. 

-- 
Dmitry
