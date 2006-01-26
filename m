Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWAZTVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWAZTVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWAZTVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:21:13 -0500
Received: from styx.suse.cz ([82.119.242.94]:14734 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964846AbWAZTVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:21:11 -0500
Date: Thu, 26 Jan 2006 20:21:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126192131.GA10332@suse.cz>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <20060126175506.GA32972@dspnet.fr.eu.org> <20060126181034.GA9694@suse.cz> <20060126182818.GA44822@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126182818.GA44822@dspnet.fr.eu.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 07:28:18PM +0100, Olivier Galibert wrote:
> On Thu, Jan 26, 2006 at 07:10:34PM +0100, Vojtech Pavlik wrote:
> > The kernel interface is sysfs and hotplug.
> 
> Hotplug, of course, can't be used from a program.  As for sysfs, as
> said in the mail to Jens, I'm not sure how to:
> 
> - find the devices, what should I scan/filter on.  udev seems likes it
>   needs to run a program (/sbin/cdrom_id) or scan
>   /proc/sys/dev/cdrom/info just to know if a device is a cdrom...
> 
> - find the /dev name associated to a sysfs-found device.

That's why I said that sysfs/hotplug are kernel interfaces. They are the
interfaces the kernel uses to tell the rest of the system what devices
are there.

They are by no means interfaces that common tools should use. 

> > Udev interfaces that and can be set up so that it assigns
> > /dev/cdrecorder0, 1, ... to evey recorder in the system, implementing
> > the userspace interface.
> 
> Problem is, udev doesn't. Or at least it varies from distribution to
> distribution. 

Yes. That is something that can be fixed, though. It's some work, but
it's just that - no controversies involved.

> For instance recent gentoo creates /dev/cdrom*,
> /dev/cdrw*, /dev/dvd*, /dev/dvdrw*.  Fedora core 3 creates
> /dev/cdrom*, /dev/cdwriter*, /dev/dvd*, /dev/dvdwriter*.  I guess from
> your email that SuSE does /dev/cdrecorder*.  And I'm not able to
> guess what fedora core 5, mandrake, debian, slackware and infinite
> number of derivatives do.

That's what LSB and other standards are for. Defining standard
filesystem layout for programs to use (this includes /dev !).

And that's what also distros are for - setting correct defaults in the
programs when they package them.

In the end, on a well done distribution it works. And some time after
one is created, the distributions do follow the standard, too.

> > HAL interfaces the above and implements the desktop interface.
> 
> I'm not sure how trustable HAL is at that point given what's going on
> with udev and I'm not too happy to have to require to daemons (dbus
> system and hald) to run to find the devices, but heh...

It's mostly required if you run GNOME or KDE, so for desktop
applications it makes perfect sense.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
