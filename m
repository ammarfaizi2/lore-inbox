Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbUDQWJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 18:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbUDQWIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 18:08:38 -0400
Received: from guru.webcon.ca ([216.194.67.26]:47497 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S264056AbUDQWHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 18:07:39 -0400
Date: Sat, 17 Apr 2004 18:07:30 -0400 (EDT)
From: Ian Morgan <imorgan@webcon.ca>
To: Jean Delvare <khali@linux-fr.org>
cc: Ben Castricum <helpdeskie@bencastricum.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 Sensors & USB problems
In-Reply-To: <1081349796.407416a4c3739@imp.gcu.info>
Message-ID: <Pine.LNX.4.58.0404171756400.11374@dark.webcon.ca>
References: <1081349796.407416a4c3739@imp.gcu.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, Jean Delvare wrote:

> Hi Ben,
> 
> > 2.6.5-rc1 -> sensors broke (ERROR: Can't get <sensor> data!)
> 
> Your sensors problem will be resolved as soon as you switch to the just
> released lm_sensors 2.8.6.

I use the same w83781d and i2c_i801 drivers on my Asus P4PE box, and they
too went belly up with 2.6.5. However, I HAVE tried lm_sensors 2.8.6 and
that made no difference. They're just user-space tools that don't touch the
kernel any more in 2.6.x (right?).

The problem I am seeing now in 2.6.5 is that after loading the w83781d
module, nothing shows up in /sys or /proc, as though the module had not
loaded but lsmod says it is loaded.

In 2.6.4, my sensors showed up hare:
/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/* (w83781d)
/sys/devices/pci0000:00/0000:00:1f.3/i2c-1/1-0050/* (eeprom)

Now in 2.6.5, with both eeprom and w83781d modules loaded, I only get the
eeprom, and the w83781d is nowhere to be found:
/sys/devices/pci0000:00/0000:00:1f.3/i2c-1/1-0050/* (eeprom)

# find /sys/bus/i2c/drivers/
/sys/bus/i2c/drivers/
/sys/bus/i2c/drivers/w83781d
/sys/bus/i2c/drivers/eeprom
/sys/bus/i2c/drivers/eeprom/1-0050
/sys/bus/i2c/drivers/dev_driver
/sys/bus/i2c/drivers/i2c_adapter

This certainly shows that the driver is loaded, but has not found/registered
any devices?

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan at webcon dot ca        PGP: #2DA40D07      www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------
