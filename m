Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932716AbVKCGVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbVKCGVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 01:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVKCGVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 01:21:03 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:37839 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S932716AbVKCGVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 01:21:01 -0500
Date: Thu, 3 Nov 2005 07:21:13 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Robert Schwebel <robert@schwebel.de>, Pavel Machek <pavel@suse.cz>,
       Robert Schwebel <r.schwebel@pengutronix.de>, vojtech@suse.cz,
       rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051103062113.GQ23316@pengutronix.de>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz> <20051102213354.GO23316@pengutronix.de> <38523.192.168.0.12.1130986361.squirrel@192.168.0.2>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <38523.192.168.0.12.1130986361.squirrel@192.168.0.2>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 08:52:41PM -0600, John Lenz wrote:
> Except the led code that is being proposed CAN sit on top of a generic
> GPIO layer.  If a generic GPIO layer is created, you can create a led
> driver that calls out to that GPIO layer.
> 
> You just need to fill in the following functions with some that raise and
> lower the GPIO on the correct line....
> 
> int (*color_get)(struct device *, struct led_properties *props);
> void (*color_set)(struct device *, struct led_properties *props, int value);
> 
> int (*brightness_get)(struct device *, struct led_properties *props);
> void (*brightness_set)(struct device *, struct led_properties *props, int
> value);
 
Ok, great! I'll see that I update my patch for 2.6.14. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

