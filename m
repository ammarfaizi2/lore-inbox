Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSKMRAf>; Wed, 13 Nov 2002 12:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSKMRAf>; Wed, 13 Nov 2002 12:00:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45586 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262128AbSKMRAe>;
	Wed, 13 Nov 2002 12:00:34 -0500
Date: Wed, 13 Nov 2002 09:02:04 -0800
From: Greg KH <greg@kroah.com>
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: Oliver Neukum <oliver@neukum.name>, Sean Neakums <sneakums@zork.net>,
       linux-kernel@vger.kernel.org
Subject: Re: hotplug (was devfs)
Message-ID: <20021113170204.GC5446@kroah.com>
References: <20021112093259.3d770f6e.spyro@f2s.com> <20021112094949.GE17478@higherplane.net> <6uadkf9kdt.fsf@zork.zork.net> <200211121351.08328.oliver@neukum.name> <20021113104809.D2386@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113104809.D2386@axis.demon.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 10:48:09AM +0000, Nick Craig-Wood wrote:
> 
> We fixed these problems by removing hotplug and loading the relevant
> kernel modules in the correct order and voila a perfectly
> deterministic order for the /dev/ttyUSBs with all devices initialised.

deterministic for you :)

What hotplug will do is allow you to assign a /dev entry to a specific
device, so that you can go off of the topology, and not just the order
in which the devices are found.  That is how this problem will be
solved properly.

> Plugging in our USB bus with 24 devices on it does indeed produce a
> mini-forkbomb effect ;-) (Especially since these Keyspan devices are
> initialised twice - once without firmware and once with firmware.)
> 
> So - perhaps hotplug ought to be serialised?

No, it's not needed for this problem.  There has been talk of
serializing stuff in userspace, which is the proper way to handle some
of the remove before add was seen problems.

thanks,

greg k-h
