Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUAGKbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUAGKbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:31:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48798 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266181AbUAGKbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:31:37 -0500
Date: Wed, 7 Jan 2004 11:31:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Olaf Hering <olh@suse.de>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Andries Brouwer <aebr@win.tue.nl>,
       Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107103123.GZ3483@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103133749.A3393@pclin040.win.tue.nl> <20040103124216.GA31006@suse.de> <200401031905.31806.arvidjaar@mail.ru> <20040103175414.GX5523@suse.de> <20040107094321.GC21059@suse.de> <20040107095029.GX3483@suse.de> <20040107095632.GA22213@suse.de> <20040107095922.GY3483@suse.de> <20040107102515.GC22770@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107102515.GC22770@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07 2004, Olaf Hering wrote:
>  On Wed, Jan 07, Jens Axboe wrote:
> 
> > On Wed, Jan 07 2004, Olaf Hering wrote:
> > >  On Wed, Jan 07, Jens Axboe wrote:
> > > 
> > > > No need to put it in the kernel, user space fits the bil nicely. I don't
> > > > see how this would lead to IO errors?
> > > 
> > > Ok, how should it be done on my SCSI and parallel port ZIP? An ATAPI ZIP
>         ^^^
> 
> "How"? We need a sane way to deal with removeable medias.
> Do you have example code that can be put into the udev distribution?

Depends. If the device supports event status notification, then that is
what should be used. If not, you have to hack some code around test unit
ready (checking the sense info on return, if failed). You'd most likely
want to do this manually, with SG_IO.

-- 
Jens Axboe

