Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbTFSLG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 07:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbTFSLGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 07:06:55 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:53736 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S265765AbTFSLGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 07:06:54 -0400
Subject: Re: 2.4.21: Bluetooth oopses with Acer USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Marius Gedminas <mgedmin@delfi.lt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030619101858.GA1745@gintaras>
References: <20030619072216.GB14665@gintaras>
	<1056014305.32273.90.camel@pegasus>  <20030619101858.GA1745@gintaras>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Jun 2003 13:19:57 +0200
Message-Id: <1056021604.32273.100.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marius,

> Small and black ;)

all of the Acer dongles are small and black, but not all of them use the
same Bluetooth chip :)

> I've a couple of photos that I was going to put on the web somewhere,
> but at the moment usb-storage.o is stuck in the initialization phase.
> Strange...  Perhaps 2.4.20 has other problems with this dongle confusing
> the USB subsystem?  I haven't tried using it with another USB device at
> the same time before.
> 
> > Please show us your data from
> > /proc/bus/usb/devices for this device.
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS= 8 #Cfgs=  1
> P:  Vendor=0b7a ProdID=07d0 Rev= 1.34
> S:  SerialNumber=3EC0B415
> C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

The problem is not the USB subsystem. It is the manufacturer of the
Bluetooth chip, because some of them didn't read the Bluetooth HCI spec.
part H2 carefully. At least every H2 USB Bluetooth device must have two
ISOC endpoints. Even if they don't support SCO voice transfer.

Regards

Marcel


