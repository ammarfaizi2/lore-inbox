Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWAREHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWAREHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 23:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWAREHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 23:07:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:53463 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964921AbWAREHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 23:07:48 -0500
Date: Tue, 17 Jan 2006 20:07:18 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev/hotplug and automatic /dev node creation
Message-ID: <20060118040718.GA6579@kroah.com>
References: <20060118024710.GB26895@quickstop.soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118024710.GB26895@quickstop.soohrt.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 03:47:10AM +0100, Horst Schirmeier wrote:
> Hi,
> 
> I'm looking for documentation regarding how to write a Linux kernel
> module that creates its own /dev node via udev/hotplug.
> register_chrdev() and a simple udev/rules.d/ entry don't seem to be
> sufficient...

Yes, register_chrdev() will do nothing for udev.

Take a look at the book, Linux Device Drivers, third edition (free
online).  In the chapter about the driver model, there is a section
about what udev needs.  The functions it says to use are no longer in
the kernel, but it should point you in the right direction (hint, use
class_device_create().)

If you have a pointer to your code, I can probably knock out a patch for
you very quickly.

thanks,

greg k-h
