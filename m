Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWCUUVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWCUUVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWCUUVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:21:45 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:936 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932438AbWCUUVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:21:44 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: "Lanslott Gish" <lanslott.gish@gmail.com>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Date: Tue, 21 Mar 2006 21:22:02 +0100
User-Agent: KMail/1.7.2
Cc: "Greg KH" <greg@kroah.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com> <200603172250.16667.daniel.ritz-ml@swissonline.ch> <38c09b90603202023s6c495cceu683db19c68fcc5e0@mail.gmail.com>
In-Reply-To: <38c09b90603202023s6c495cceu683db19c68fcc5e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603212122.03398.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-03.tornado.cablecom.ch 32700;
	Body=8 Fuz1=8 Fuz2=8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 05.23, Lanslott Gish wrote:
> On 3/18/06, Daniel Ritz <daniel.ritz-ml@swissonline.ch> wrote:
> > On Friday 17 March 2006 03.46, Lanslott Gish wrote:
> > >
> > > BTW, may i also suggest add more module_param to max_x, max_y, min_x, min_y  ?
> > > i think these options is useful, too.
> >
> > no chance. (and if i remember correctly it's possible via evdev ioctl)
> >
> 
> 
> i could use my device in X without evtouch.o or any X-module or any
> xorg.conf modified, but wrong positions to cursor.
> 
> and consider using touchscreens in console(framebuffer) mode, or
> without evtouch in X, or devices do not provide several functions.
> 
> suppose we can something in /etc/rc.d/rc.local or some files:
> 
> /sbin/modprobe usbtouchscreen swap_xy=1,min_x=123,max_y=456,....
> 
> we don't need any calibrate tool or guest several functions from
> devices, and complete this module.
> 
> 
> 
> Anyway, just some suggestions. thx :)

well, all nice and good, but...it doesn't belong into the driver.
it would belong into the input subsystem or evdev. there are other
absolute devices not handled by this driver that need the same
calibration...
but i still think it should be in userspace...

still, it might be worth discussing it with the input hackers.

> 
> regards,
> 
> Lanslott Gish
> 

rgds
-daniel
