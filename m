Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVAaVqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVAaVqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVAaVqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:46:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10766 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261386AbVAaVqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:46:24 -0500
Date: Mon, 31 Jan 2005 22:46:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: Re: [2.6 patch] i2c-core.c: make some code static
Message-ID: <20050131214622.GF21437@stusta.de>
References: <20050131185955.GA18316@stusta.de> <20050131215050.61c2924c.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131215050.61c2924c.khali@linux-fr.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 09:50:50PM +0100, Jean Delvare wrote:

> Hi Adrian,

Hi Jean,

>...
> > -/* match always succeeds, as we want the probe() to tell if we really
> > accept this match */ -static int i2c_device_match(struct device *dev,
> > struct device_driver *drv) -{
> > -	return 1;
> > -}
> > -
> > -static int i2c_bus_suspend(struct device * dev, pm_message_t state)
> > -{
> > -	int rc = 0;
> > -
> > -	if (dev->driver && dev->driver->suspend)
> > -		rc = dev->driver->suspend(dev,state,0);
> > -	return rc;
> > -}
> > -
> > -static int i2c_bus_resume(struct device * dev)
> > -{
> > -	int rc = 0;
> > -	
> > -	if (dev->driver && dev->driver->resume)
> > -		rc = dev->driver->resume(dev,0);
> > -	return rc;
> > -}
> > -
> > -struct bus_type i2c_bus_type = {
> > -	.name =		"i2c",
> > -	.match =	i2c_device_match,
> > -	.suspend =      i2c_bus_suspend,
> > -	.resume =       i2c_bus_resume,
> > -};
> > -
> >  static int __init i2c_init(void)
> >  {
> >  	int retval;
> 
> Is moving that code around really necessary? Looks to me like only the
> i2c_bus_type structure needs to be moved.

i2c_bus_type requires i2c_device_match, i2c_bus_suspend and 
i2c_bus_resume...

> Thanks,
> Jean Delvare

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

