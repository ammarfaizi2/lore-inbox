Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTDGRR1 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263569AbTDGRR0 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:17:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19329 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263568AbTDGRRZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 13:17:25 -0400
Date: Mon, 7 Apr 2003 09:32:32 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Vagn Scott <vagn@ranok.com>, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [2.5.66-bk9] : undefined reference to `i2c_detect'
Message-ID: <20030407163232.GC2553@kroah.com>
References: <E191DBZ-0004ac-00@Maya.ny.ranok.com> <20030403223901.GB6170@kroah.com> <20030404222922.GE20044@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404222922.GE20044@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 12:29:23AM +0200, Adrian Bunk wrote:
> On Thu, Apr 03, 2003 at 02:39:01PM -0800, Greg KH wrote:
> > On Thu, Apr 03, 2003 at 05:27:53PM -0500, Vagn Scott wrote:
> > > 
> > > CONFIG_SENSORS_LM75=y
> > > CONFIG_SENSORS_VIA686A=y
> > > CONFIG_I2C_SENSOR=m
> > 
> > Ok, I need a bit of Kconfig help for drivers/i2c/chips to set
> > CONFIG_I2C_SENSOR to be "y" if either of those two drivers are selected
> > as "y".  Anyone know how?
> 
> The following (untested) should work:
> 
> config I2C_SENSOR
>         tristate
>         default y if SENSORS_ADM1021=y || SENSORS_LM75=y || SENSORS_VIA686A=y   || SENSORS_W83781D=y
>         default m if SENSORS_ADM1021=m || SENSORS_LM75=m || SENSORS_VIA686A=m   || SENSORS_W83781D=m
>         default n

Thanks, that worked out great.  I'll make up a patch and send it on.

greg k-h
