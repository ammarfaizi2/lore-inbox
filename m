Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbTHORTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270640AbTHORSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:18:36 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:11269 "EHLO
	mail3.cybertrails.com") by vger.kernel.org with ESMTP
	id S270652AbTHORSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:18:00 -0400
Date: Fri, 15 Aug 2003 10:17:53 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: USB:  full-speed hides low-speed devices
Message-Id: <20030815101753.5a706f73.dickson@permanentmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the USB devices listed below.  The hub is built into the keyboard.
I have the USB mouse and a storage device both connected into the
keyboard.

I can access the hard drive for a few short bursts, like ls, and the mouse
continues to work.  But when I copy files to/from the device, or do a du
--total, the mouse no longer works until I unplug and replug in the mouse.

There is no logged activity until I unplug the mouse.

So it appears that the low-speed mouse disappears once heavy traffic
occurs at full-speed.  Is this normal?

This notebook only has one physical USB port to connect everything.  I
don't currently have 2.6 setup on a computer with two USB ports to test
with a separate low-speed connection from the mouse to the computer.

This is 2.6.0-test3.

	-Paul


[root@violet 08:49:13]# cat /proc/bus/usb/devices
 
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=146/900 us (16%), #Int=  3, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test3 uhci-hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:07.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
 
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 3
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0472 ProdID=0065 Rev= 1.00
S:  Manufacturer=Chicony
S:  Product=Generic USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 90mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
 
T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0472 ProdID=0065 Rev= 1.00
S:  Manufacturer=Chicony
S:  Product=PFU-65 USB Keyboard
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=24ms
 
T:  Bus=01 Lev=02 Prnt=03 Port=01 Cnt=02 Dev#= 14 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
P:  Vendor=0d7d ProdID=0310 Rev= 1.00
S:  Manufacturer=
S:  Product=Usb Card Adapter
S:  SerialNumber=000140000AA7
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 4 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=255ms
E:  Ad=01(O) Atr=03(Int.) MxPS=  16 Ivl=255ms
 
T:  Bus=01 Lev=02 Prnt=03 Port=02 Cnt=03 Dev#= 12 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=1241 ProdID=1111 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=8ms
[root@violet 08:50:04]# 
