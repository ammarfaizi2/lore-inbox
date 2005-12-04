Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVLDPIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVLDPIl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLDPIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:08:41 -0500
Received: from hornet.berlios.de ([195.37.77.140]:42055 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S932245AbVLDPIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:08:40 -0500
From: Michael Frank <mhf@users.berlios.de>
Reply-To: mhf@users.berlios.de
To: Luke-Jr <luke-jr@utopios.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Sun, 4 Dec 2005 16:06:08 +0100
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051203152339.GK31395@stusta.de> <20051204002043.GA1879@kroah.com> <200512040446.32450.luke-jr@utopios.org>
In-Reply-To: <200512040446.32450.luke-jr@utopios.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20051204150949.647BB28EA@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 05:46, Luke-Jr wrote:
> On Sunday 04 December 2005 00:20, Greg KH wrote:
> > > Switch "broken bloaty bulky devfs" to "lean & clean
> > > devfs"?  This ship would have been flying the
> > > "clean-up nation" flags.
> >
> > Again, because an in-kernel devfs is not the correct
> > thing to do.  devfs has been disabled for a few months
> > now, and I don't think anyone has missed it yet :)
>
> Well, devfs does have some abilities udev doesn't:
> hotplug/udev doesn't detect everything, and can result in
> rarer or non-PnP devices not being automatically
> available; devfs has the effect of trying to load a
> module when a program looks for the devices it provides--
> while it can cause problems, it does have a possibility
> to work better. Interesting effects of switching my
> desktop from devfs to udev:
> 1. my DVD burners are left uninitialized until I manually
> modprobe ide-cd or (more recently) ide-scsi
> 2. my sound card is autodetected and the drivers loaded,
> but the OSS emulation modules are omitted; with devfs,
> they would be autoloaded when an app tried to use OSS
> devfs also has the advantage of keeping the module info
> all in one place-- the kernel or the module. In
> particular, with udev the detection and /dev info is
> scattered into different locations of the filesystem.
> This can probably be fixed easily simply by having udev
> read such info from modules or via a /sys entry, though.

Seems your complaints are related to missing/broken 
configuration (of your distribution). 

Here are some references which may be of help:

http://webpages.charter.net/decibelshelp/LinuxHelp_UDEVPrimer.html
http://www.gentoo.org/doc/en/udev-guide.xml
http://gentoo-wiki.com/HOWTO_Customizing_UDEV
http://ubuntuforums.org/archive/index.php/t-11718.html

IME, udev is easier to manage than devfs because there are 
tools such as udevtest.

Please see also manuals for udevstart udevtest, udevinfo, 
udevcontrol

Also strace udevstart is interesting...

