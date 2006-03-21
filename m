Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWCUWsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWCUWsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWCUWsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:48:08 -0500
Received: from web60714.mail.yahoo.com ([209.73.178.217]:687 "HELO
	web60714.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964867AbWCUWsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:48:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=kmXGXyixmDLVIG4cWl2V3fr8fSyt8JCgYiovVFfiyWtMX6d5gR18qpeybo1qSiD4sDACL67htxslWpHnP/z4LKAJ6yt9GCdF1tM1hYSNRBNbU2f2VyGcFSdo12DJDIk0VKyW8xzq+ia7VaX204X28Y9okxTRCAmFK84mZeqg4Rw=  ;
Message-ID: <20060321224804.21790.qmail@web60714.mail.yahoo.com>
Date: Tue, 21 Mar 2006 14:48:04 -0800 (PST)
From: "Todd E. Johnson" <tejohnson@yahoo.com>
Reply-To: "Todd E. Johnson" <tejohnson@yahoo.com>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       Lanslott Gish <lanslott.gish@gmail.com>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, hc@mivu.no,
       vojtech@suse.cz
In-Reply-To: <200603212122.03398.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,
 
This has always been a bit of a fuzzy area to me since the 3M / Microtouch controllers support  calibration within the device.  (i.e.:  send raw output, or the devices internally calculated - calibrated - output.).  After asking this question long ago, I decided to document it and move on...  Is there a userland calibration mechanism for anything in the userspace besides something like QT Embedded?

 
Regards, 
 
Todd E. Johnson 


----- Original Message ----
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Lanslott Gish <lanslott.gish@gmail.com>
Cc: Greg KH <greg@kroah.com>; Dmitry Torokhov <dmitry.torokhov@gmail.com>; linux-kernel <linux-kernel@vger.kernel.org>; linux-usb <linux-usb-devel@lists.sourceforge.net>; tejohnson@yahoo.com; hc@mivu.no; vojtech@suse.cz
Sent: Tuesday, March 21, 2006 3:22:02 PM
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one


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
