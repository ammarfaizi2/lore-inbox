Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261455AbTC0XAS>; Thu, 27 Mar 2003 18:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbTC0XAS>; Thu, 27 Mar 2003 18:00:18 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10249 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261455AbTC0XAR>;
	Thu, 27 Mar 2003 18:00:17 -0500
Date: Thu, 27 Mar 2003 15:10:27 -0800
From: Greg KH <greg@kroah.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030327231027.GC1687@kroah.com>
References: <1048806052.10675.4440.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048806052.10675.4440.camel@cube>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 06:00:51PM -0500, Albert Cahalan wrote:
> Greg KH writes:
> 
> > temp_max[1-3]   Temperature max value.
> >                 Fixed point value in form XXXXX and
> >                 should be divided by
> >                 100 to get degrees Celsius.
> >                 Read/Write value.
> 
> Celsius can go negative, which may be yucky
> and hard to test. Kelvin generally doesn't
> suffer this problem. (yeah, yeah, quantum stuff...)

Wow, only 4 hours before someone mentioned Kelvin, I think I lost a bet
with someone :)

Seriously, let the value go negative, no problem.  As long as it isn't
floating point input which has to be parsed by the kernel.  That's all I
care about.

> Getting temperature display into "top" would sure
> be nice, but not if that means requiring a library
> that almost nobody has installed. It's good to give
> apps a simple way to get CPU temperature, including
> per-CPU data for SMP systems when available.

libsensors is installed on almost all distros these days.

> Info about sensor quality would be good. For example,
> my CPU measures temperature in 4-degree increments
> and is not calibrated.

I doubt the kernel driver knows this information.

thanks,

greg k-h
