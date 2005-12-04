Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVLDXZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVLDXZq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVLDXZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:25:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:52430 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932212AbVLDXZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:25:45 -0500
Date: Sun, 4 Dec 2005 15:22:05 -0800
From: Greg KH <greg@kroah.com>
To: Luke-Jr <luke-jr@utopios.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204232205.GF8914@kroah.com>
References: <20051203152339.GK31395@stusta.de> <20051203225020.GF25722@merlin.emma.line.org> <20051204002043.GA1879@kroah.com> <200512040446.32450.luke-jr@utopios.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512040446.32450.luke-jr@utopios.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 04:46:31AM +0000, Luke-Jr wrote:
> Well, devfs does have some abilities udev doesn't: hotplug/udev
> doesn't detect everything, and can result in rarer or non-PnP devices
> not being automatically available;

Are you sure about that today?  And udev wasn't created to do everything
that devfs does.  And devfs can't do everything that udev can (by
far...)

> devfs has the effect of trying to load a module when a program looks
> for the devices it provides-- while it can cause problems, it does
> have a possibility to work better.

Sorry, but that model of loading modules is very broken and it is good
that we don't do that anymore (as you allude to.)

> Interesting effects of switching my desktop from devfs to udev:
> 1. my DVD burners are left uninitialized until I manually modprobe ide-cd or 
> (more recently) ide-scsi

Sounds like a broken distro configuration :)

> 2. my sound card is autodetected and the drivers loaded, but the OSS emulation 
> modules are omitted; with devfs, they would be autoloaded when an app tried 
> to use OSS

Again, broken distro configuration :)

> devfs also has the advantage of keeping the module info all in one place-- the 
> kernel or the module.

What?

> In particular, with udev the detection and /dev info is scattered into
> different locations of the filesystem. This can probably be fixed
> easily simply by having udev read such info from modules or via a /sys
> entry, though.

What information are you talking about here?

thanks,

greg k-h
