Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269239AbUIYE55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269239AbUIYE55 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 00:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269240AbUIYE55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 00:57:57 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:12477 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269239AbUIYE5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 00:57:55 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [BK] Changing driver core/sysfs/kobject symbol exports to GPL only
Date: Fri, 24 Sep 2004 23:57:50 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, "" <greg@kroah.com>
References: <Pine.LNX.4.50.0409241202110.30766-200000@monsoon.he.net> <200409242324.38923.dtor_core@ameritech.net> <Pine.LNX.4.50.0409242133480.19236-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0409242133480.19236-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409242357.50977.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 September 2004 11:36 pm, Patrick Mochel wrote:
> 
> On Fri, 24 Sep 2004, Dmitry Torokhov wrote:
> 
> > On Friday 24 September 2004 10:42 pm, Patrick Mochel wrote:
> > > What's life without a little controversey once in a while?
> > >
> > > The attached patch and referenced BK tree changes all the symbol exports
> > > in the driver core, sysfs, and the kobject core to EXPORT_SYMBOL_GPL [1].
> >
> > May I ask to keep class_simple and maybe platform_device_register_simple
> > available to non-GPL modules. These functions offer limited and documented
> > semantic and while it is impossible to build entire new subsystem around
> > them it will allow non-GPL stuff still be somewhat integrated - standard
> > hotplug mostly I think...
> 
> I didn't touch class_simple.

OOps, my bad. I thought I've seen it there... Must be my tired eyes playing
tricks on me.

>                              Are there really external modules that use 
> platform_device_register_simple(), or you speaking hypothetically?

Since I just recently added it (for serio sysfs benefits mostly) I highly
doubt that anyone else uses it. On the other hand it is very very limited
and may be suited for "wierd" cases that do not use existing subsystems.
But then I doubt that any non-GPL would do anything besides PCI/USB/1394
Now that I gave it some more thought I am sure that
platform_device_register_simple can be safely switched to EXPORT_SYMBOL_GPL

Sorry for the noise.
 
-- 
Dmitry
