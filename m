Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTDDWSA (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 17:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTDDWSA (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 17:18:00 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33477 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261366AbTDDWR7 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 17:17:59 -0500
Date: Sat, 5 Apr 2003 00:29:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg KH <greg@kroah.com>
Cc: Vagn Scott <vagn@ranok.com>, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [2.5.66-bk9] : undefined reference to `i2c_detect'
Message-ID: <20030404222922.GE20044@fs.tum.de>
References: <E191DBZ-0004ac-00@Maya.ny.ranok.com> <20030403223901.GB6170@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403223901.GB6170@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 02:39:01PM -0800, Greg KH wrote:
> On Thu, Apr 03, 2003 at 05:27:53PM -0500, Vagn Scott wrote:
> > 
> > CONFIG_SENSORS_LM75=y
> > CONFIG_SENSORS_VIA686A=y
> > CONFIG_I2C_SENSOR=m
> 
> Ok, I need a bit of Kconfig help for drivers/i2c/chips to set
> CONFIG_I2C_SENSOR to be "y" if either of those two drivers are selected
> as "y".  Anyone know how?

The following (untested) should work:

config I2C_SENSOR
        tristate
        default y if SENSORS_ADM1021=y || SENSORS_LM75=y || SENSORS_VIA686A=y   || SENSORS_W83781D=y
        default m if SENSORS_ADM1021=m || SENSORS_LM75=m || SENSORS_VIA686A=m   || SENSORS_W83781D=m
        default n


> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

