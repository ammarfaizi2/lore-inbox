Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261422AbSJAAwM>; Mon, 30 Sep 2002 20:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbSJAAwM>; Mon, 30 Sep 2002 20:52:12 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:12806 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261422AbSJAAwL>;
	Mon, 30 Sep 2002 20:52:11 -0400
Date: Mon, 30 Sep 2002 17:55:21 -0700
From: Greg KH <greg@kroah.com>
To: arnd@bergmann-dalldorf.de
Cc: Arjan van de Ven <arjanv@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] 2.5.39 s390 (3/26): drivers.
Message-ID: <20021001005521.GA4331@kroah.com>
References: <1033396763.1718.1.camel@localhost.localdomain> <200209301957.04743.arnd@bergmann-dalldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209301957.04743.arnd@bergmann-dalldorf.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 07:58:10PM +0200, Arnd Bergmann wrote:
> > Ehm. Ok. This code STILL tries to read and parse config files. If you're
> > fixing it, can you please fix it to NOT read and parse config files from
> > inside the kernel? Please? 
> 
> This is just a fix to keep chandev working as long as it's there and
> drivers depend on it. We're working on getting rid of chandev altogether,
> as we don't need any more it once driverfs and hotplug are working well 
> for s390 ccw devices.

With the last patch I just sent to Linus, I think you have everything
you need (from the driver core, exported to /sbin/hotplug.)  Let me know
if there's any changes that can help you out.

I'll work on adding /sbin/hotplug support for classes later this week,
but I don't think your code would need that, correct?

thanks,

greg k-h
