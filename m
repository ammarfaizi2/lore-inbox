Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTEEIUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTEEIUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:20:52 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:12205 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S262066AbTEEIUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:20:49 -0400
Date: Mon, 5 May 2003 18:34:58 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
Message-ID: <20030505083458.GA621@zip.com.au>
References: <20030427115644.GA492@zip.com.au> <20030428205522.GA26160@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428205522.GA26160@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 01:55:22PM -0700, Greg KH wrote:
> On Sun, Apr 27, 2003 at 09:56:44PM +1000, CaT wrote:
> > I keep a-lookin but I can't find any data. Have I missed something?
> > 
> > # find | grep -i pii
> > ./bus/pci/drivers/piix4 smbus
> > ./bus/pci/drivers/piix4 smbus/00:07.3
> > ./bus/pci/drivers/PIIX IDE
> > ./bus/pci/drivers/PIIX IDE/00:07.1
> > # find | grep -i i2c
> > ./bus/i2c
> > ./bus/i2c/drivers
> > ./bus/i2c/drivers/lm75
> > ./bus/i2c/drivers/IT87xx
> > ./bus/i2c/drivers/dev driver
> > ./bus/i2c/devices
> 
> No devices?  Does 2.5.68 work for you?

Does not look like it:

# find | grep -i pii
./bus/pci/drivers/piix4 smbus
./bus/pci/drivers/piix4 smbus/00:07.3
./bus/pci/drivers/PIIX IDE
./bus/pci/drivers/PIIX IDE/00:07.1
# find | grep -i i2c
./bus/i2c
./bus/i2c/drivers
./bus/i2c/drivers/lm75
./bus/i2c/drivers/dev driver
./bus/i2c/devices
./devices/pci0/00:07.3/i2c-0
./devices/pci0/00:07.3/i2c-0/power
./devices/pci0/00:07.3/i2c-0/name
# uname -a
Linux theirongiant 2.5.68 #5 Sun May 4 23:59:51 EST 2003 i686 unknown
# grep '\(I2C\|SENSORS\)' .config
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PIIX4=y
CONFIG_SENSORS_LM75=y
CONFIG_I2C_SENSOR=y

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
