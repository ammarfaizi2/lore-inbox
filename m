Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbTGJWhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbTGJWhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:37:37 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:27386 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP id S266519AbTGJWgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:36:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Greg KH <greg@kroah.com>
Subject: Re: USB stops working with any of 2.4.22-pre's after 2.4.21
Date: Thu, 10 Jul 2003 18:51:14 -0400
User-Agent: KMail/1.5.1
Cc: John Wong <kernel@implode.net>, linux-kernel@vger.kernel.org
References: <20030710065801.GA351@gambit.implode.net> <200307101335.34266.gene.heskett@verizon.net> <20030710175045.GA12533@kroah.com>
In-Reply-To: <20030710175045.GA12533@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307101851.14757.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [151.205.62.27] at Thu, 10 Jul 2003 17:51:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 13:50, Greg KH wrote:
>On Thu, Jul 10, 2003 at 01:35:34PM -0400, Gene Heskett wrote:
>> And my ability to use it, while never great due to config problems
>> on the other end of the cable, seems now to have gone away.  There
>> has also been some pretty heavy lightning activity in the area,
>> during which time it may have been hooked up, and something blown
>> from the EMP of a nearby strike.  I usually leave it unplugged on
>> the seriel side because of that.
>>
>> Does this look normal?  ISTR it used to ID itself all the time,
>> not just in dmesg.
>
>What does /proc/bus/usb/devices show for this device?
>
>thanks,
>
>greg k-h

A cat of that looks like this:

[root@coyote root]# cat /proc/bus/usb/devices

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=e400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 22/900 us ( 2%), #Int=  2, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=e000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03eb ProdID=3301 Rev= 3.00
S:  Product=Standard USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr= 64mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=1453 ProdID=4026 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=serial
E:  Ad=81(I) Atr=03(Int.) MxPS=  10 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  8 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=04b8 ProdID=0005 Rev= 1.00
S:  Manufacturer=EPSON
S:  Product=USB Printer
S:  SerialNumber=W02L20201172205420
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=02 Lev=02 Prnt=02 Port=02 Cnt=03 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=0900 Rev= 0.90
C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 
Driver=Connectix QuickCam VC
E:  Ad=81(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 0 Alt= 1 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 
Driver=Connectix QuickCam VC
E:  Ad=81(I) Atr=01(Isoc) MxPS= 128 Ivl=1ms
I:  If#= 0 Alt= 2 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 
Driver=Connectix QuickCam VC
E:  Ad=81(I) Atr=01(Isoc) MxPS= 384 Ivl=1ms
I:  If#= 0 Alt= 3 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 
Driver=Connectix QuickCam VC
E:  Ad=81(I) Atr=01(Isoc) MxPS= 512 Ivl=1ms
I:  If#= 0 Alt= 4 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 
Driver=Connectix QuickCam VC
E:  Ad=81(I) Atr=01(Isoc) MxPS= 640 Ivl=1ms
I:  If#= 0 Alt= 5 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 
Driver=Connectix QuickCam VC
E:  Ad=81(I) Atr=01(Isoc) MxPS= 768 Ivl=1ms
I:  If#= 0 Alt= 6 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 
Driver=Connectix QuickCam VC
E:  Ad=81(I) Atr=01(Isoc) MxPS= 896 Ivl=1ms
I:  If#= 0 Alt= 7 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 
Driver=Connectix QuickCam VC
E:  Ad=81(I) Atr=01(Isoc) MxPS=1023 Ivl=1ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 
Driver=Connectix QuickCam VC
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=   1 Ivl=8ms
The above doesn't work yet

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=ff MxPS= 8 #Cfgs=  1
P:  Vendor=04b8 ProdID=010f Rev= 1.00
S:  Manufacturer=EPSON
S:  Product=EPSON Scanner 010F
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=ff 
Driver=usbscanner
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=16ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 93/900 us (10%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=dc00
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c00e Rev=11.00
S:  Manufacturer=Logitech
S:  Product=USB-PS/2 Optical Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=04b8 ProdID=0005 Rev= 1.00
S:  Manufacturer=EPSON
S:  Product=USB Printer
S:  SerialNumber=RL0200301161041200
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0msPS=  64 Ivl=0ms
r=02(Bulk) MxPS=  64 Ivl=0ms

And yes, there are two printers attached.  The 820 is for sale.
And, sort of as an afterthought, lemme toss in that the Belkin Bulldog 
UPS monitor soft, runs on a real serial port, /dev/ttyS1, hasn't 
worked since about 2.4.18 or so.  Somewhere about that time anyway.  
I've yelled at Belkin since it was compiled on a RH5.2 system and 
they've refused to update their proprietary drivers.  Or to release 
the API even if I'd have signed an NDA.  NDI why.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

