Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTKBSzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 13:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTKBSzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 13:55:50 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:55559 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261779AbTKBSzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 13:55:46 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Date: Sun, 2 Nov 2003 21:50:48 +0300
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
References: <200307152214.38825.arvidjaar@mail.ru> <200308312025.41472.arvidjaar@mail.ru> <20030922222910.GA306@kroah.com>
In-Reply-To: <20030922222910.GA306@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311022150.48638.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 September 2003 02:29, Greg KH wrote:
>
> Thanks, I've applied this and will send it off to Linus in a bit.
>

thank you.

> > it just arbitrarily (re-)names them. "min" is not hysteresis; name is
> > badly chosen.
>
> Do you have a proposed change to the current
> Documentation/i2c/sysfs-interface document?  If you can think of better
> names that make more sense, I'd be glad to change things to make it
> easier.
>

it is probably too late now to change sysfs names when some programs already 
use it. I'll check sysfs-interface, thank you for pointer.

> > > > 4. I do not have the slightest idea how ISA adapters look like in
> > > > sysfs and where they are located. Anyone can give me example?
> > >
> > > They show up on the legacy bus:
> > >
> > > $ tree /sys/class/i2c-adapter/i2c-1/
> > > /sys/class/i2c-adapter/i2c-1/
> > >
> > > |-- device -> ../../../devices/legacy/i2c-1
> >
> > This does not help much. Libsensors expects as adapter identification
> > either "i2c-N" or "isa". If I set it to "isa" I do not have any way to
> > determine sysfs path except by rescanning /sys/class/i2c-adapter every
> > time. Having /sys/class/i2-adapter/isa/... would be better, apparently it
> > is assumed that only one such adapter can exist.
>
> No, we internally do not differentiate between isa and non-isa adapters,
> so why should we force that on the user?  They work the same as far as
> users notice, and now we are consistant in our naming.
>

Well, I just tried to match what users get out of libsensors on 2.4. The 
reason was compatibility with /etc/sensors.conf where "isa" can possibly be 
used as part of chip name. But I'd like that someone from sensors developers 
comment on this.

thank you for your comments.

-andrey

