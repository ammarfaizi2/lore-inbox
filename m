Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVLEFyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVLEFyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 00:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVLEFyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 00:54:49 -0500
Received: from user-0c938qu.cable.mindspring.com ([24.145.163.94]:4783 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751059AbVLEFys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 00:54:48 -0500
From: Luke-Jr <luke-jr@utopios.org>
To: Greg KH <greg@kroah.com>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 5 Dec 2005 05:59:33 +0000
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051203152339.GK31395@stusta.de> <200512040446.32450.luke-jr@utopios.org> <20051204232205.GF8914@kroah.com>
In-Reply-To: <20051204232205.GF8914@kroah.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512050559.34464.luke-jr@utopios.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 23:22, Greg KH wrote:
> On Sun, Dec 04, 2005 at 04:46:31AM +0000, Luke-Jr wrote:
> > Well, devfs does have some abilities udev doesn't: hotplug/udev
> > doesn't detect everything, and can result in rarer or non-PnP devices
> > not being automatically available;
>
> Are you sure about that today?

Nope, but I don't see how udev can possibly detect something that doesn't let 
the OS know it's there-- except, of course, loading the driver for it and 
seeing if it works.

> And udev wasn't created to do everything that devfs does.

Which might be a case for leaving devfs in. *shrug*

> And devfs can't do everything that udev can (by far...)

Didn't say it could...

> > Interesting effects of switching my desktop from devfs to udev:
> > 1. my DVD burners are left uninitialized until I manually modprobe ide-cd
> > or (more recently) ide-scsi
>
> Sounds like a broken distro configuration :)

Well, I was assuming you kept Gentoo's udev packages up to date. ;)
[ebuild   R   ] sys-fs/udev-070-r1  (-selinux) -static 429 kB

> > devfs also has the advantage of keeping the module info all in one
> > place-- the kernel or the module.
> > In particular, with udev the detection and /dev info is scattered into
> > different locations of the filesystem. This can probably be fixed
> > easily simply by having udev read such info from modules or via a /sys
> > entry, though.
>
> What information are you talking about here?

I'm assuming everything in /etc/udev/rules.d/50-udev.rules used to be in the 
kernel for devfs-- perhaps it was PAM though, I'm not sure.
Other than that, I don't expect that simply installing a new kernel module 
will allow the device to be detected automatically, but that some hotplug or 
udev configurations will need to be updated also.
-- 
Luke-Jr
Developer, Utopios
http://utopios.org/
