Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbTH2VJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTH2VJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 17:09:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:65164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261663AbTH2VJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 17:09:47 -0400
Date: Fri, 29 Aug 2003 14:09:53 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (5/8): common i/o layer.
Message-ID: <20030829210953.GB2771@kroah.com>
References: <pV54.523.43@gated-at.bofh.it> <20030829204017.GA2580@kroah.com> <20030829205034.GA2649@kroah.com> <200308292306.18178.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308292306.18178.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 11:06:18PM +0200, Arnd Bergmann wrote:
> On Friday 29 August 2003 22:50, Greg KH wrote:
> > diff -Nru a/drivers/usb/core/file.c b/drivers/usb/core/file.c
> > --- a/drivers/usb/core/file.c   Fri Aug 29 13:49:19 2003
> > +++ b/drivers/usb/core/file.c   Fri Aug 29 13:49:20 2003
> > @@ -129,7 +129,7 @@
> >         int retval = -EINVAL;
> >         int minor_base = class_driver->minor_base;
> >         int minor = 0;
> > -       char name[DEVICE_ID_SIZE];
> > +       char name[BUS_ID_SIZE];
> >         struct class_device *class_dev;
> >         char *temp;
> >  
> 
> In your case, BUS_ID_SIZE doesn't look appropriate here either, because
> the name is never used directly as a bus_id. You should probably use
> your own constant here.

Look a little lower and see where I copy that name into a struct
class_device.class_id, which is BUS_ID_SIZE big :)

thanks,

greg k-h
