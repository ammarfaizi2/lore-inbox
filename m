Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVBYDTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVBYDTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 22:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVBYDTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 22:19:10 -0500
Received: from smtp818.mail.sc5.yahoo.com ([66.163.170.4]:42359 "HELO
	smtp818.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262608AbVBYDTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 22:19:04 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.11-rc4-mm1
Date: Thu, 24 Feb 2005 22:18:59 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050223014233.6710fd73.akpm@osdl.org> <200502231840.06017.dtor_core@ameritech.net> <1109289975l.6462l.0l@werewolf.able.es>
In-Reply-To: <1109289975l.6462l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502242219.01480.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 February 2005 19:06, J.A. Magallon wrote:
> 
> On 02.24, Dmitry Torokhov wrote:
> > On Wednesday 23 February 2005 18:12, Ed Tomlinson wrote:
> > > On Wednesday 23 February 2005 17:38, J.A. Magallon wrote:
> > > > 
> > > > On 02.23, Andrew Morton wrote:
> > > > > 
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/
> > > > > 
> > > > > 
> > > > > - Various fixes and updates all over the place.  Things seem to have slowed
> > > > >   down a bit.
> > > > > 
> > > > > - Last, final, ultimate call: if anyone has patches in here which are 2.6.11
> > > > >   material, please tell me.
> > > > > 
> > > > 
> > > > Two points:
> > > > 
> > > > - I lost my keyboard :(. USB, but plugged into PS/2 with an adapter.
> > > 
> > > Mine too.  Details sent in another message...
> > > 
> > 
> > Does i8042.nopnp help?
> > 
> 
> Yes, that makes things work.
> Even better than ever before, now an USB mouse and a PS/2 logitech
> trackball work fine both at the same time. In console and in X.
> In previous kernels PS/2 was dead or jumped heavily when an usb mouse
> was plugged. The keyboard works both in PS/2 (with adapter) and in USB.
> 
> Now a tricky question: the mouse and the trackball move the pointer in X
> at different speeds. Is there any way to tell the kernel they have
> the same DPI ? Or can I tweak the speed/DPI settings for them separately
> to get a more or less similar movement ?
>

You can try changing PS/2 mouse rate and resolution via the following
sysfs attributes:

	/sys/bus/serio/devices/serioX/rate
	/sys/bus/serio/devices/serioX/resolution

like this:

	echo -n "200" > /sys/bus/serio/devices/serio1/resolution

Or you could try setting both mice as separate devices in X...

-- 
Dmitry
