Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUAGJum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbUAGJul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:50:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28562 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266156AbUAGJui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:50:38 -0500
Date: Wed, 7 Jan 2004 10:50:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Olaf Hering <olh@suse.de>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Andries Brouwer <aebr@win.tue.nl>,
       Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107095029.GX3483@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103133749.A3393@pclin040.win.tue.nl> <20040103124216.GA31006@suse.de> <200401031905.31806.arvidjaar@mail.ru> <20040103175414.GX5523@suse.de> <20040107094321.GC21059@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107094321.GC21059@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07 2004, Olaf Hering wrote:
>  On Sat, Jan 03, Jens Axboe wrote:
> 
> > On Sat, Jan 03 2004, Andrey Borzenkov wrote:
> > > > Is there really no way to get a media change notification from ZIP or
> > > > JAZ drives?
> > > 
> > > If anyone knows please tell me - I will put it into supermount ...
> > > 
> > > AFAIK in case of SCSI this is impossible simply by virtue of protocol - SCSI 
> > > device is not initiator. So you need something to poll device for status. 
> > > That is usually done on device open except in this case you can't open 
> > > because you do not yet have handle.
> > 
> > You could queue a media notification request for long periods of time,
> > being completed by the drive when a media change happens. At least mmc
> > allows for this, doubt anyone has ever done it.
> > 
> > So yeah, poll...
> 
> Poll how? "kmediachangethread"? Or polling in userland? The latter would
> (probably) lead to endless IO errors. Not very good.

No need to put it in the kernel, user space fits the bil nicely. I don't
see how this would lead to IO errors?

> If I understand the Darwin sources correctly, a polling is used. But I
> havent looked hard how they do it.

It's the only way to do it.

-- 
Jens Axboe

