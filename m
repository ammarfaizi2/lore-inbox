Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261396AbTCYDYB>; Mon, 24 Mar 2003 22:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbTCYDYB>; Mon, 24 Mar 2003 22:24:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:42000 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261396AbTCYDYA>;
	Mon, 24 Mar 2003 22:24:00 -0500
Date: Mon, 24 Mar 2003 19:34:36 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@codemonkey.org.uk>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
Message-ID: <20030325033436.GC11874@kroah.com>
References: <10482950873871@kroah.com> <10482950921680@kroah.com> <20030325093550.GD1083@zaurus.ucw.cz> <20030325012923.GA10879@kroah.com> <20030325020418.GB8048@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325020418.GB8048@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 02:04:19AM +0000, Dave Jones wrote:
> On Mon, Mar 24, 2003 at 05:29:23PM -0800, Greg KH wrote:
> 
>  > > > +	.name		= "ADM1021-MAX1617",
>  > > Why dash here
>  > > > +	.name		= "LM75 sensor",
>  > > And space here? Also you should have 
>  > > either 2x "sensor" or none at all. 
>  > What do you mwan "2x"?
> 
> The way I parsed it, either have..
>  .name = "ADM1021-MAX1617 sensor",
>  .name = "LM75 sensor",
> 
> or
> 
>  .name = "ADM1021-MAX1617",
>  .name = "LM75",
> 
> ie, both, or all. Personally the latter looks better to me.

Ah, yes, that makes more sense now.

Yes, we shouldn't have the "sensor" in the name.

> Especially given the 16 char limit.  Aren't these going to
> be in a sysfs heirarchy where its obvious they are sensors
> anyway ? like i2c/sensors/lm75 ?

Yes, they show up as bus/i2c/drivers/

thanks,

greg k-h
