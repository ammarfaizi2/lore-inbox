Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTJHHaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 03:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbTJHHaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 03:30:00 -0400
Received: from quechua.inka.de ([193.197.184.2]:44244 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261168AbTJHH37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 03:29:59 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: devfs and udev
Date: Wed, 08 Oct 2003 09:30:21 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.08.07.30.20.119386@dungeon.inka.de>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <200310072128.09666.insecure@mail.od.ua> <20031007194124.GA2670@kroah.com> <200310072347.41749.insecure@mail.od.ua> <20031007205244.GA2978@kroah.com> <1065561443.840.76.camel@clubneon.priv.hereintown.net> <20031007214848.GC3095@kroah.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Oct 2003 21:51:27 +0000, Greg KH wrote:
> And remember, _I_ did not submit that patch to the kernel marking devfs
> obsolete.  Other kernel developers did.  And for good reasons, which
> have all been explained before.  Even if udev wasn't even written yet,
> it would have been done.

"Note that devfs has been obsoleted by udev,"

Most people expect after reading that sentence, that udev can do the
work devfs did for them. But udev is not ready to do that, even by
far. Thats why people complain.

Also all the documentation you mention doesn't help very much:
if someone wants to sit down, use devfs, even improve some parts
of the kernel with sysfs support, so sysfs will show all devices -
there is no documentation or example how to do that. The whole
kobject / sysfs / driver model code is by far not as easy to
understand as those devfs function calls are.

> Patches are always gladly accepted.

How can we patch udev, if sysfs doesn't seem to have the necessary
information. for example devfs has disc, floppy, cdrom. sysfs has only
/sys/block/hd*. Sorry, but I don't see how udev can create a result like
devfs did, without the necessary information in /sys. And the kernel
code isn't easy.

> People, come on, please read the existing documentation

show me that I'm wrong, and those questions I asked are documented,
and I will be happy and appologize. But I'm very sorry: even reading
your papers a hundred times doesn't show how drivers are supposed to
create custom entries for more devices. With devfs it's a five minute
look at a few drivers like floppy.c and printers.c and you get the idea.

Also the documentation is actualy confusing: why is a usb printer put
into class "usb" and not class printer? Why does udev decide the type
of device by matching /sys/block, why not export that data explicit?
Why not export default permissions, like devfs does?

With some answers, we might understand udev and sysfs better and might
be able to help. But asking for patches is not going to work, if basic
questions are left without answers.

Regards, Andreas

