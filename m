Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVIPV5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVIPV5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVIPV52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:57:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:37517 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750701AbVIPV50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:57:26 -0400
Date: Fri, 16 Sep 2005 14:48:41 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916214841.GA13920@suse.de>
References: <20050916002036.GA6149@suse.de> <200509152136.08951.dtor_core@ameritech.net> <20050916024351.GC13486@vrfy.org> <200509160221.54587.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509160221.54587.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 02:21:53AM -0500, Dmitry Torokhov wrote:
> > > 
> > > No, like your first picture, except 'interfaces/mice' will be a directory,
> > > not a symlink, since it does not have class_device parent. I should have
> > > said "Otherwise it gets added into _its_ class directory". 
> > 
> 
> Ok, this is _very_ raw and I am creating double symlinks somehow, but still
> it shows it can be done:
> 
> [dtor@core ~]$ tree /sys/class/input/
> /sys/class/input/
> |-- devices
> |   |-- input0

Close, just drop the "devices" subdir, and you have my proposal, I'm
glad we agree :)

> `-- interfaces
>     |-- event0 -> ../../../class/input/devices/input0/event0

I don't see why we need the interfaces subdir at all.

thanks,

greg k-h
