Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbUKCUFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUKCUFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUKCUFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:05:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:45987 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261843AbUKCUDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:03:40 -0500
Date: Wed, 3 Nov 2004 12:03:26 -0800
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: germano.barreiro@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041103200326.GA29718@kroah.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D81B@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D81B@minimail.digi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 01:55:51PM -0600, Kilau, Scott wrote:
> Hi Greg, all,
> 
> > What's wrong with the kobject in /sys/class/tty/ which has one object
> > per port?  I think we might not be exporting that class_device
> > structure, but I would not have a problem with doing that.
> > greg k-h
> 
> Using the simple class tty kobject that tty_io.c keeps might work for my
> needs.
> 
> However, there is one thing that stopped me from using it earlier...
> 
> The naming of the directory (tty name) in /sys/class/tty is forced to
> be:
> "sprintf(p, "%s%d", driver->name, index + driver->name_base);"
> 
> Is it possible we could change this to be more relaxed about the naming
> scheme?

Why?  That's the kernel name for this tty device, right?  Why would you
want to change this?

> Maybe we can allow a "custom" name to be sent into the
> tty_register_device() call?  Like add another option parameter called
> "custom_name" that if non-NULL, is used instead of the derived name?

Why?  What would you call it that would be any different from what we
use today?  I guess I don't understand why you don't like the kernel
names.

thanks,

greg k-h
