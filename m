Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVASIho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVASIho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVASIer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:34:47 -0500
Received: from alcatraz.copyleft.no ([66.154.115.120]:41223 "EHLO
	mail9.copyleft.no") by vger.kernel.org with ESMTP id S261679AbVASI0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:26:08 -0500
Subject: dmesg output for Transcend 6-in-1 USB card reader
From: Joakim Ziegler <joakim@avmaria.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 19 Jan 2005 02:25:58 -0600
Message-Id: <1106123158.5270.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I needed to make scsi_mod probe all luns on this device to be able to
use it. After some Googling, it seems it's encouraged to send dmesg
output to this list to get the device added to the list of devices which
should have all luns probed automatically. If I'm mistaken about that,
my apologies. dmesg output follows:

usb 2-1: new full speed USB device using address 8
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor:           Model: USB Card Reader   Rev: 1.0a
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
  Vendor:           Model: USB Card Reader   Rev: 1.0a
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdc at scsi1, channel 0, id 0, lun 1
  Vendor:           Model: USB Card Reader   Rev: 1.0a
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sde at scsi1, channel 0, id 0, lun 2
  Vendor:           Model: USB Card Reader   Rev: 1.0a
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdf at scsi1, channel 0, id 0, lun 3
USB Mass Storage device found at 8


And /proc/bus/usb/devices:

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  8 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0d7d ProdID=0240 Rev= 1.00
S:  Manufacturer=
S:  Product=USB Reader
S:  SerialNumber=30370A0030B9
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=350mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-
storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=1ms


Hope this is useful. Not a member of the list, Cc: me on replies, etc.

-- 
Joakim Ziegler <joakim@avmaria.com>

