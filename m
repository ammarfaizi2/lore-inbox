Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUGPFrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUGPFrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUGPFrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:47:00 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:49790 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266477AbUGPFqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 01:46:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PARCH] driver core: add driver_find to find a driver by name
Date: Thu, 15 Jul 2004 23:41:14 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200406272126.05220.dtor_core@ameritech.net> <20040714230246.GF3398@kroah.com> <20040715123018.GA17486@logos.cnet>
In-Reply-To: <20040715123018.GA17486@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407152341.14189.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 July 2004 07:30 am, Marcelo Tosatti wrote:
> On Wed, Jul 14, 2004 at 04:02:46PM -0700, Greg KH wrote:
> > On Sun, Jun 27, 2004 at 09:26:03PM -0500, Dmitry Torokhov wrote:
> > > Hi,
> > > 
> > > Here is a patch that adds driver_find() that allows to search for a driver
> > > on a bus by it's name. The function is similar to device_find already present
> > > in the tree. I need it for my serio sysfs patches where user can re-bind
> > > serio port to an alternate driver by echoing driver's name to serio port's
> > > driver attribute.
> > 
> > Applied, thanks.
> 
> Dmitry,
> 
> I remember you fixed kset_find_obj() to get a reference count on the kobject.
> 
> driver_find()/device_find() use that, maybe it would be nice to add a comment 
> on top of those saying the caller is responsible for putting the refcount 
> on the kobject?
> 
> Last time I looked at your patches there was no such comment on driver_find/device_find, 
> only kset_find_obj().
> 
> Just nitpicking.
> 

Hi Marcelo,

I tried to document driver_find, device_find and find_bus, please check out
the version that Greg has committed. If comments still somewhat unclear I
will try redoing them.

-- 
Dmitry
