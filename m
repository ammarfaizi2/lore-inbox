Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWHBH2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWHBH2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWHBH2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:28:51 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:43723 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1751314AbWHBH2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:28:50 -0400
Date: Wed, 2 Aug 2006 09:28:43 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Chris Boot <bootc@bootc.net>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
Message-ID: <20060802072843.GN10495@pengutronix.de>
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <44CFC6CC.8020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <44CFC6CC.8020106@gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 03:25:32PM -0600, Jim Cromie wrote:
> >I've attached the gpio framework we have developed a while ago; it is
> >not ready for upstream, only tested on pxa and has probably several
> >other drawbacks, but may be a start for your activities. One of the
> >problems we've recently seen is that for example on PowerPCs you don't
> >have such a clear "this is gpio pin x" nomenclature, so the question
> >would be how to do the mapping here.
> >
> >Robert 
> >  
> this is cool to see.  Using a class-driver is very different from the 
> vtable-approach
> that I used (struct nsc_gpio_ops) in pc8736x_gpio and scx200_gpio.
> 
> Are any of the limitation youve cited above related to the 
> /sys/class/gpio paths below ?
> 
> +	  To set pin 63 to low (to start the motor) do a:
> +	   $ echo 0 > /sys/class/gpio/gpio63/level
> +	  Or to stop the motor again:
> +	   $ echo 1 > /sys/class/gpio/gpio63/level
> +	  To get the level of the key (pin 8) do:
> +	   $ cat /sys/class/gpio/gpio8/level
> +	  The result will be 1 or 0.
> +
> +	  To add new GPIO pins at runtime (lets say pin 88 should be an 
> input)
> +	  you can do a:
> +	   $ echo 88:in > /sys/class/gpio/map_gpio
> +	  The same with a new GPIO pin 95, it should be an output and at 
> high level:
> +	   $ echo 95:out:hi > /sys/class/gpio/map_gpio
> +
 
Please re-read my original mail. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

