Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWBVV5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWBVV5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWBVV5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:57:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:28634 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750854AbWBVV5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:57:49 -0500
Date: Wed, 22 Feb 2006 15:47:40 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: what's a platform device?
Message-ID: <Pine.LNX.4.44.0602221517370.21264-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

I was hoping to get your opinion on a question I had.  The question comes 
down to what we think a "platform device" is.

The situation I have is an FPGA connected over PCI.  The FPGA implements
various device functionality (serial ports, I2C controller, IR, etc.) as a
single PCI device/function.  The FPGA breaks any notion of a true PCI
device, it uses PCI as a device interconnect more than anything else.

In talking to Greg about this, he suggested I just create a new bus_type
for this similar to what is being done for usb-serial.  As I started to
think about what I wanted ended up being a platform_device plus a sysfs
entry for the MMIO region.

So, it seems that a "platform device" is a pretty generic concept now.  Do 
you guys thing its acceptable to use a platform device for my needs or 
should I create some new bus_type?  Do we have a better definition of what 
a platform device is or might be?

If we're ok with my use of platform device for this, I assume no one has
an issue with adding a sysfs attribute to platform devices to expose the
MMIO regions similar to what we do for PCI today.

thanks

- kumar

