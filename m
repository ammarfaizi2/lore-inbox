Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVAKA1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVAKA1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVAKATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:19:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:47318 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262759AbVAKAIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:08:15 -0500
Date: Mon, 10 Jan 2005 15:47:26 -0800
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export symbol from I2C eeprom driver
Message-ID: <20050110234726.GE3286@kroah.com>
References: <9e47339105010721347fbeb907@mail.gmail.com> <20050108055315.GC8571@kroah.com> <9e473391050107220875baa32b@mail.gmail.com> <20050108222719.GA3226@kroah.com> <9e473391050108161426b36e4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050108161426b36e4d@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 07:14:48PM -0500, Jon Smirl wrote:
> On Sat, 8 Jan 2005 14:27:19 -0800, Greg KH <greg@kroah.com> wrote:
> > And why do you need the eeprom driver for the radeon driver to work
> > properly?
> 
> In the new radeon driver at hotplug time a user space app reads the
> DDC from the monitor and sets the list of valid modes into the driver.
> The radeon driver includes an I2C driver. The eeprom driver finds the
> radeon DDC ROMs and makes them visible to the userspace driver through
> sysfs. I could add code to the radeon driver to export the DDC ROMs to
> sysfs but the eeprom driver works fine.
> 
> I don't want to load the driver from the script because the radeon
> driver is creating a sysfs link into the eeprom directory from the
> radeon one.

How are you getting the kobject to the eeprom directory from the radeon
driver?

thanks,

greg k-h
