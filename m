Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVIPWzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVIPWzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVIPWzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:55:42 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:18214 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750748AbVIPWzm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:55:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RfsZlsV3YJr3kohaD3Yb9dm/lcS656i97DLbqj5jHMVRrEj232UcUVucrCVeFsVa6fj/GhgOVvfek1/oePANPz/r50Aq4DddVVHWK8HxK5/0/45nIlLYoUpmRKA5AaiCIiZs9Th5IpDgYAGQrFBZ3bSz9VRzICcOGpFTKxW/PzI=
Message-ID: <d120d5000509161555b021a3d@mail.gmail.com>
Date: Fri, 16 Sep 2005 17:55:35 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
In-Reply-To: <20050916214841.GA13920@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050916002036.GA6149@suse.de>
	 <200509152136.08951.dtor_core@ameritech.net>
	 <20050916024351.GC13486@vrfy.org>
	 <200509160221.54587.dtor_core@ameritech.net>
	 <20050916214841.GA13920@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Greg KH <gregkh@suse.de> wrote:
> On Fri, Sep 16, 2005 at 02:21:53AM -0500, Dmitry Torokhov wrote:
> > > >
> > > > No, like your first picture, except 'interfaces/mice' will be a directory,
> > > > not a symlink, since it does not have class_device parent. I should have
> > > > said "Otherwise it gets added into _its_ class directory".
> > >
> >
> > Ok, this is _very_ raw and I am creating double symlinks somehow, but still
> > it shows it can be done:
> >
> > [dtor@core ~]$ tree /sys/class/input/
> > /sys/class/input/
> > |-- devices
> > |   |-- input0
> 
> Close, just drop the "devices" subdir, and you have my proposal, I'm
> glad we agree :)
> 

No, not entirely agree. I _want_ devices subdir to separate objects of
different [sub]classes. We don;'t mix SCSI class_devices with USB, why
messing it here?

> > `-- interfaces
> >     |-- event0 -> ../../../class/input/devices/input0/event0
> 
> I don't see why we need the interfaces subdir at all.
> 

For the same reasons you have hwmon stuff - one shoudl not hunt
through maze of subdirectories and filter unwanted data to get list of
objects of given class.

-- 
Dmitry
