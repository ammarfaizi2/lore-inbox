Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUI1LU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUI1LU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 07:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUI1LU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 07:20:56 -0400
Received: from mail.dif.dk ([193.138.115.101]:60629 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266864AbUI1LUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 07:20:53 -0400
Date: Tue, 28 Sep 2004 13:18:28 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices
In-Reply-To: <1096306153.1729.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0409281316191.22088@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost>
 <1096306153.1729.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Stephen Hemminger wrote:

> Date: Mon, 27 Sep 2004 10:29:13 -0700
> From: Stephen Hemminger <shemminger@osdl.org>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>,
>     Nico Schottelius <nico-kernel@schottelius.org>
> Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices
> 
> On Mon, 2004-09-27 at 00:51 +0200, Jesper Juhl wrote:
> >  
> > +static ssize_t show_carrier(struct class_device *dev, char *buf)
> > +{
> > +	struct net_device *net = to_net_dev(dev);
> > +	if (netif_running(net)) {
> > +		if (netif_carrier_ok(net))
> > +			return snprintf(buf, 3, "%d\n", 1);
> > +		else
> > +			return snprintf(buf, 3, "%d\n", 0);
> 
> Using snprintf in this way is kind of silly. since buffer is PAGESIZE.
> The most concise format of this would be:
> 	return sprintf(buf, dec_fmt, !!netif_carrier_ok(dev));
> 

I see your point and I'll create a new patch this evening when I get home 
from work.
Thank you for your feedback.


--
Jesper Juhl



