Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129224AbRBORIy>; Thu, 15 Feb 2001 12:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBORIo>; Thu, 15 Feb 2001 12:08:44 -0500
Received: from marine.sonic.net ([208.201.224.37]:17184 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S129119AbRBORI2>;
	Thu, 15 Feb 2001 12:08:28 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010215090807.C29356@sonic.net>
Date: Thu, 15 Feb 2001 09:08:07 -0800
From: David Hinds <dhinds@sonic.net>
To: Andrew Morton <andrewm@uow.edu.au>,
        Manfred Spraul <manfred@colorfullife.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network driver updates
In-Reply-To: <Pine.LNX.3.96.1010214020707.28011E-100000@mandrakesoft.mandrakesoft.com> <3A8A7159.AF0E6180@colorfullife.com> <3A8A8937.A77BA18D@uow.edu.au> <20010214093859.B20503@sonic.net> <3A8AC6B6.9790FF9C@colorfullife.com> <3A8BC242.2C62DAA1@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A8BC242.2C62DAA1@uow.edu.au>; from Andrew Morton on Thu, Feb 15, 2001 at 10:49:22PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2001 at 10:49:22PM +1100, Andrew Morton wrote:
> 
> Now, the thing I don't understand about David's design is the
> final one.  What 3c575_cb does is:
> 
> CONFIG_HOTPLUG=y, MODULE=true
>          If the hardware isn't there, register the driver and
>          hang around.
> 
> Why?

Merely that I was trying to disassociate the concepts of module
loading and device probing, and I thought it was most consistent to
then allow people to load modules whenever they want, whether or not a
device was present.

> BTW: How come CONFIG_PCMCIA requires CONFIG_HOTPLUG?  Doesn't
> it make sense to be able to have glued-in Cardbus devices?

I suppose it makes sense but I don't know if it is something worth the
trouble of supporting.

-- Dave
