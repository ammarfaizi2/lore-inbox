Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbUAGKt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266184AbUAGKt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:49:59 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:1029 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265473AbUAGKt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:49:56 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Jens Axboe <axboe@suse.de>, Olaf Hering <olh@suse.de>
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Date: Wed, 7 Jan 2004 13:47:40 +0300
User-Agent: KMail/1.5.3
Cc: Andries Brouwer <aebr@win.tue.nl>, Greg KH <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200401012333.04930.arvidjaar@mail.ru> <20040107102515.GC22770@suse.de> <20040107103123.GZ3483@suse.de>
In-Reply-To: <20040107103123.GZ3483@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401071347.40328.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 January 2004 13:31, Jens Axboe wrote:
> On Wed, Jan 07 2004, Olaf Hering wrote:
> >  On Wed, Jan 07, Jens Axboe wrote:
> > > On Wed, Jan 07 2004, Olaf Hering wrote:
> > > >  On Wed, Jan 07, Jens Axboe wrote:
> > > > > No need to put it in the kernel, user space fits the bil nicely. I
> > > > > don't see how this would lead to IO errors?
> > > >
> > > > Ok, how should it be done on my SCSI and parallel port ZIP? An ATAPI
> > > > ZIP
> >
> >         ^^^
> >
> > "How"? We need a sane way to deal with removeable medias.
> > Do you have example code that can be put into the udev distribution?
>
> Depends. If the device supports event status notification, then that is
> what should be used. 

Would you please give some pointers to information about "event status 
notification".

thank you

> If not, you have to hack some code around test unit 
> ready (checking the sense info on return, if failed). You'd most likely
> want to do this manually, with SG_IO.

