Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTDEAs4 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 19:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTDEAs4 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 19:48:56 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:28391 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261623AbTDEAsy (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 19:48:54 -0500
Date: Sat, 5 Apr 2003 10:59:50 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, frodol@dds.nl, phil@netroedge.com
Subject: Re: 2.5.66: The I2C code ate my grandma...
Message-ID: <20030405005950.GA464@zip.com.au>
References: <20030404021152.GE466@zip.com.au> <20030404171424.GA1380@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404171424.GA1380@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 09:14:24AM -0800, Greg KH wrote:
> So if you disable the I2C config items, everything works just fine?

Yup.

> I did send out a bugfix for the i2c code for a problem in 2.5.66, it's
> now included in the latest -bk tree.  Could you grab that patch and see
> if it fixes your problem?

Ok. Running -bk10. Where, umm, is the userspace interface to it? I can't
find anything in /proc or /sys so I can't see if it's actually working.
Incase they're useful here are snippets from .config and dmesg:
 
 # I2C support
 CONFIG_I2C=y
 # CONFIG_I2C_ALGOBIT is not set
 # CONFIG_I2C_ALGOPCF is not set
 CONFIG_I2C_CHARDEV=y
 # I2C Hardware Sensors Mainboard support
 # CONFIG_I2C_ALI15X3 is not set
 # CONFIG_I2C_AMD756 is not set
 # CONFIG_I2C_AMD8111 is not set
 # CONFIG_I2C_I801 is not set
 CONFIG_I2C_PIIX4=y
 # I2C Hardware Sensors Chip support
 CONFIG_SENSORS_ADM1021=y
 # CONFIG_SENSORS_LM75 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_W83781D is not set
 CONFIG_I2C_SENSOR=y

i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-piix4 version 2.7.0 (20021208)
piix4 smbus 00:07.3: Found Intel Corp. 82371AB/EB/MB PIIX4  device
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
registering 0-004d
i2c i2c-0: Error: no response!

One question. Will I need ISA support in the kernel for this?

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
