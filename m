Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbUBWER7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 23:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUBWER7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 23:17:59 -0500
Received: from mother.pmc-sierra.com ([216.241.224.12]:50332 "HELO
	mother.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id S261801AbUBWER5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 23:17:57 -0500
Message-ID: <9DFF23E1E33391449FDC324526D1F25902253276@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
From: Manish Lachwani <Manish_Lachwani@pmc-sierra.com>
To: "'LM Sensors'" <sensors@stimpy.netroedge.com>,
       "'LKML'" <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: RE: i2c-yosemite
Date: Sun, 22 Feb 2004 20:12:33 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean

Couple of things. First of all, I did not have an idea that a driver existed for Atmel 24C32 EEPROM. In case of the Yosemite chip, the MAC address of the Gigabit subsystem is stored in the EEPROM. It needs to be fetched by the Gige driver using the I2C protocol. I could not find the driver in the 2.4 tree and hence wrote one for the yosemite. I could use the existing driver, which would make sense. 

Secondly, the reason why I mentioned:

"Currently, this Linux driver wont be integrated into the generic Linux
I2C framework."

is because at the time the driver was written, the chip did not exist. The idea was that once the chip is released and the driver tested, it could be checked in the generic i2c framework along with the driver for the MAX 1619 sensors chip. Now that the drivers already exist, I will use them instead. 

Thanks
Manish

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Sunday, February 22, 2004 1:41 AM
To: Manish Lachwani
Cc: LM Sensors; LKML; Greg KH
Subject: i2c-yosemite


Hi Manish,

I saw that there is a new driver named i2c-yosemite in Linux 2.6.3-mm2.
Quoting your words in the header:

"Currently, this Linux driver wont be integrated into the generic Linux
I2C framework."

Why that?

If everyone reimplements what already exists, the kernel is likely to go
bigger with no benefit. Also, you won't be able to use all user-space
tools that already exist, and will also have to write specific chip
drivers for the chips present on the yosemite bus, although these
drivers (Atmel 24C32 EEPROM and MAX 1619) already exist.

Please explain to us why you cannot/don't want to use the existing i2c
subsystem.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
