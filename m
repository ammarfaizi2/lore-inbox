Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRJQIKO>; Wed, 17 Oct 2001 04:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272838AbRJQIKE>; Wed, 17 Oct 2001 04:10:04 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:15933 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271005AbRJQIJu>; Wed, 17 Oct 2001 04:09:50 -0400
From: "Steven A. DuChene" <sduchene@mindspring.com>
Date: Wed, 17 Oct 2001 04:10:14 -0400
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org, sduchene@mindspring.com
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
Message-ID: <20011017041014.B2015@lapsony.mydomain.here>
In-Reply-To: <1003288485.14282.100.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
In-Reply-To: <1003288485.14282.100.camel@thanatos>; from jdthood@mail.com on Tue, Oct 16, 2001 at 11:14:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I tried this with the Intel STL2 motherboard I also have and I got
a similar error when trying to load the correct i2c bus module when the
PnPBIOS stuff is compiled into the kernel.

modprobe i2c-piix4
/lib/modules/2.4.10-ac12pnp/kernel/drivers/i2c/i2c-piix4.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.10-ac12pnp/kernel/drivers/i2c/i2c-piix4.o: insmod /lib/modules/2.4.10-ac12pnp/kernel/drivers/i2c/i2c-piix4.o failed
/lib/modules/2.4.10-ac12pnp/kernel/drivers/i2c/i2c-piix4.o: insmod i2c-piix4 failed


dmesg
.
.
.
i2c-piix4.o version 2.6.1 (20010830)
i2c-piix4.o: Found OSB4 device
i2c-piix4.o: SMB region 0x580 already in use!
i2c-piix4.o: Device not detected, module not inserted.


cat /proc/ioports
.
.
.
04d0-04d1 : PnPBIOS PNP0c02
0580-058f : PnPBIOS PNP0c02
0840-084f : ServerWorks OSB4 IDE Controller
  0840-0847 : ide0
  0848-084f : ide1
0cd6-0cd7 : PnPBIOS PNP0c02
0cf8-0cff : PCI conf1
5000-50ff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
5400-543f : Intel Corporation 82557 [Ethernet Pro 100]
  5400-543f : eepro100
5440-547f : Intel Corporation 82557 [Ethernet Pro 100] (#2)
  5440-547f : eepro100
5800-58ff : Adaptec 7899P
6000-60ff : Adaptec 7899P (#2)
fe00-fe3f : PnPBIOS PNP0c02


So this is a problem on more than just those old Intel Lancewood L440GX
motherboards. The STL2 is a fairly recent dual processor motherboard
-- 
Steven A. DuChene	sad@ale.org
			linux-clusters@mindspring.com
			sduchene@mindspring.com

	http://www.mindspring.com/~sduchene/
