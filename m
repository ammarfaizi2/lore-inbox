Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUAGKyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266298AbUAGKyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:54:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41894 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266194AbUAGKym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:54:42 -0500
Date: Wed, 7 Jan 2004 11:54:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Olaf Hering <olh@suse.de>, Andries Brouwer <aebr@win.tue.nl>,
       Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107105435.GA3483@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040107102515.GC22770@suse.de> <20040107103123.GZ3483@suse.de> <200401071347.40328.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401071347.40328.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07 2004, Andrey Borzenkov wrote:
> On Wednesday 07 January 2004 13:31, Jens Axboe wrote:
> > On Wed, Jan 07 2004, Olaf Hering wrote:
> > >  On Wed, Jan 07, Jens Axboe wrote:
> > > > On Wed, Jan 07 2004, Olaf Hering wrote:
> > > > >  On Wed, Jan 07, Jens Axboe wrote:
> > > > > > No need to put it in the kernel, user space fits the bil nicely. I
> > > > > > don't see how this would lead to IO errors?
> > > > >
> > > > > Ok, how should it be done on my SCSI and parallel port ZIP? An ATAPI
> > > > > ZIP
> > >
> > >         ^^^
> > >
> > > "How"? We need a sane way to deal with removeable medias.
> > > Do you have example code that can be put into the udev distribution?
> >
> > Depends. If the device supports event status notification, then that is
> > what should be used. 
> 
> Would you please give some pointers to information about "event status 
> notification".

Sure, I'm talking about GPCMD_GET_EVENT_STATUS_NOTIFICATION (see
cdrom.h), opcode 0x4a in the mt fuji or mmc docs. You can fetch here:

ftp://ftp.avc-pioneer.com/Mtfuji5/

-- 
Jens Axboe

