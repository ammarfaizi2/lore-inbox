Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269954AbTGaVH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269964AbTGaVH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:07:58 -0400
Received: from ip45.usw1.rb1.pdx.nwlink.com ([207.202.132.45]:53951 "EHLO
	consumption.net") by vger.kernel.org with ESMTP id S269954AbTGaVHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:07:48 -0400
Date: Thu, 31 Jul 2003 14:07:45 -0700 (PDT)
From: <crozierm@consumption.net>
To: linux-kernel@vger.kernel.org
Subject: Re: USB mouse "hang" with 2.5.75
In-Reply-To: <Pine.LNX.4.21.0307141151520.3036-100000@consumption.net>
Message-ID: <Pine.LNX.4.21.0307311400260.15389-100000@consumption.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two weeks ago I was having a problem with 2.5.75 where the mouse and
keyboard would intermittenly lock up while using xf86.  The problem turned
out to be the "Legacy USB mouse" setting in my BIOS.  As soon as the PS/2
emulation (or whatever it is) was turned off, the problem dissappeared.

This is not the case with recent 2.4 kernels on the same hardware, so I
thought it might be worth mentioning.

Intel E7505 motherboard w/ xeon + hyperthreading enabled

$ cat /proc/bus/usb/devices 

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 93/900 us (10%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test2 uhci-hcd
S:  Product=Intel Corp. 82801DB USB (Hub #3)
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c00c Rev=21.10
S:  Manufacturer=Logitech
S:  Product=USB Optical Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test2 uhci-hcd
S:  Product=Intel Corp. 82801DB USB (Hub #2)
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test2 uhci-hcd
S:  Product=Intel Corp. 82801DB USB (Hub #1)
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test2 ehci_hcd
S:  Product=Intel Corp. 82801DB USB EHCI Con
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms





On Tue, 15 Jul 2003 crozierm@consumption.net wrote:

> 
> Hello,
> 
> I'm experiencing odd USB mouse behaviour with 2.5.75 & 2.6.0-test1.  Those
> are the only 2.5.x flavors I've used on this particular computer, so I
> don't know if this is something new.
> 
> While using the mouse normally, it will suddenly stop responding.  If I
> cat /dev/input/mice and wiggle the mouse, nothing is returned.  No extra debug messages appear in the
> syslog until I unplug the mouse and plug it back it, at which point
> everything works normally.  I can't find specific steps to reproduce it,
> but with persistent use I can usually get it to hang up within a minute or
> two.
> 
> Also, if I leave XFree86 and go to the console, then switch back to
> XFree86, the mouse is restored.  Because of this I thought it must be X,
> but this has never happened with 2.4.x.
> 
> Below is usb debug logging and system info.  If I can provide any other
> information, please respond to me directly, as I'm not on the list.
> 
>  -Michael
> 
> The mouse is a logitech optical usb mouse.  More info below in the usb
> logging.
> 
> USB info:                                                                       
>                                                                                 
> 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)               
> 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)               
> 00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)               
> 00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)   
> 
> Syslog debugging when I unplug:
> 
> ehci_hcd 0000:00:1d.7: GetStatus port 5 status 001002 POWER sig=se0  CSC
> hub 1-0:0: port 5, status 100, change 1, 12 Mb/s
> hub 4-0:0: port 1, status 100, change 3, 12 Mb/s
> usb 4-1: USB disconnect, address 5
> usb 4-1: unregistering interfaces
> usb 4-1: hcd_unlink_urb f72ced00 fail -22
> usb 4-1: hcd_unlink_urb f72ce680 fail -22
> usb 4-1: unregistering device
> hub 4-0:0: port 1 enable change, status 100
> drivers/usb/host/uhci-hcd.c: ff40: suspend_hc
> 
> syslogging when I plug back in:
> 
> ehci_hcd 0000:00:1d.7: GetStatus port 5 status 001403 POWER sig=k  CSC
> CONNECT
> hub 1-0:0: port 5, status 501, change 1, 480 Mb/s
> hub 1-0:0: debounce: port 5: delay 100ms stable 4 status 0x501
> ehci_hcd 0000:00:1d.7: port 5 low speed --> companion
> ehci_hcd 0000:00:1d.7: GetStatus port 5 status 003002 POWER OWNER sig=se0
> CSC
> drivers/usb/host/uhci-hcd.c: ff40: wakeup_hc
> hub 4-0:0: port 1, status 301, change 1, 1.5 Mb/s
> hub 4-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
> hub 4-0:0: new USB device on port 1, assigned address 6
> usb 4-1: new device strings: Mfr=1, Product=2, SerialNumber=0
> usb 4-1: Product: USB Optical Mouse
> usb 4-1: Manufacturer: Logitech
> usb 4-1: usb_new_device - registering interface 4-1:0
> hid 4-1:0: usb_device_probe
> hid 4-1:0: usb_device_probe - got id
> input: USB HID v1.10 Mouse [Logitech USB Optical Mouse] on
> usb-0000:00:1d.2-1
> 
> 
> Other system info:
> 
> Intel E7505 w/ xeon
> 
> Linux version 2.6.0-test1 (crozierm@dentaku) (gcc version 3.3.1 20030626
> (Debian prerelease)) #6 SMP Tue Jul 15 12:12:40 PDT 2003
> 
> 
> 
>  -- 
> 
> 
> 
> 
> 

-- 


