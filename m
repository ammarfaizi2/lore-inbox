Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUFJOsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUFJOsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 10:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUFJOrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 10:47:24 -0400
Received: from web81309.mail.yahoo.com ([206.190.37.84]:42846 "HELO
	web81309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261426AbUFJOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 10:46:59 -0400
Message-ID: <20040610144658.31403.qmail@web81309.mail.yahoo.com>
Date: Thu, 10 Jun 2004 07:46:58 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 0/3] Couple of sysfs patches
To: Russell King <rmk@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Jun 10, 2004 at 07:55:59AM -0500, Dmitry Torokhov wrote:
> > On Thursday 10 June 2004 05:16 am, Russell King wrote:
> > >
> > > As this currently stands, you have no chance to add resources to the
> > > platform device before it's made available to the driver.  It's likely
> > > that any attached resources will have the same lifetime as the
> > > device itself, so it makes sense to allocate them together with the
> > > platform device.
> > >
> >
> > Are you suggesting adding pointer to resources as a 3rd argument and
> > automotically release it for the user? It probably could be done but users
> > will be tempted to use static module data and bad things would happen.
> 
> Please read my second sentence again.  It implies a copy of the resources
> is kept with the platform device, so both have the same lifetime.
> 

Ok, so function pointer to allocate resources and associate with the
device? You can't just allocate memory for resources structure, you
need to populate it with data if you want it to be used by a driver
immediately after registration... And have actually release all
resources, not only memory? It is getting beyond the "*_simple"
approach though.

Or do I still misunderstand you?

--
Dmitry


