Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbSKZDFg>; Mon, 25 Nov 2002 22:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbSKZDFg>; Mon, 25 Nov 2002 22:05:36 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:272 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266064AbSKZDFf>;
	Mon, 25 Nov 2002 22:05:35 -0500
Date: Mon, 25 Nov 2002 19:05:09 -0800
From: Greg KH <greg@kroah.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       "Adam J. Richter" <adam@freya.yggdrasil.com>
Subject: Re: modutils for both redhat kernels and 2.5.x
Message-ID: <20021126030509.GA27006@kroah.com>
References: <Pine.GSO.4.33.0211251830050.6708-100000@sweetums.bluetronic.net> <20021126013330.93A962C365@lists.samba.org> <20021126021100.GB29814@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126021100.GB29814@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 02:11:00AM +0000, Jamie Lokier wrote:
> 
> Doesn't it?  When I upgraded from 2.5.45 to 2.5.48, and installed
> module-init-tools-0.7, a whole bunch of modules failed to load
> automatically, and I ended up with no pcmcia, no network, no
> af_packet, no loopback device...  I had to load them all manually.
> Also no USB, hence no USB keyboard and mouse, but I haven't tried
> loading those manually.
> 
> I thought it was depmod not working, but I must have been wrong.
> 
> So what happened - is there a known problem with module auto-loading
> at the moment?

Yes it is.  The hotplug package looks for the modules.*map files to
determine which modules to load when the devices show up.  As these are
not being generated anymore, that's why they are not getting loaded.

thanks,

greg k-h
