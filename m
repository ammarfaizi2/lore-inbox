Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312375AbSDNRZ1>; Sun, 14 Apr 2002 13:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312379AbSDNRZ0>; Sun, 14 Apr 2002 13:25:26 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:2139 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S312375AbSDNRZZ>; Sun, 14 Apr 2002 13:25:25 -0400
Date: Sun, 14 Apr 2002 18:32:47 +0100
From: Ian Molton <spyro@armlinux.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
Message-Id: <20020414183247.016a2ec3.spyro@armlinux.org>
In-Reply-To: <20020414150719.GA17826@kroah.com>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.4cvs5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH Awoke this dragon, who will now respond:

> On Sun, Apr 14, 2002 at 12:40:22AM +0100, Ian Molton wrote:
> > Hi
> > 
> > I'm not familiar with the USB code, but I've been hitting a BUG() with
> > my new OHCI card (sorry, it was cheap :(   )
> > 
> > the BUG() is at line 464 in usb-ohci.h, which seems to be a linked-list
> > traversal failing to find an entry.
> 
> So your "Subject:" is wrong?  Which driver are you having problems with?
> usb-ohci.c or usb-uhci.c?

yes. sh*t. sorry :-/

its usb-ohci.

> What platform are you running this on, x86?

yes

> What devices do you have plugged in?

one alcatel usb speedtouch ADSL modem, using the 'user mode' driver.

> What were you doing when the BUG() call happened?

surfin' the net ;) it appears to occur randomly - its been fine the whole
day today, although less stressed than yesterday.

> Are there any kernel log entries before the BUG()?

nope.

> What is your .config?

I can mail it if necessary.

> What is the output of /proc/bus/usb/devices with your USB device plugged
> in?

bash-2.05$ cat /proc/bus/usb/devices 
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=c583b000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=06b9 ProdID=4061 Rev= 0.00
S:  Manufacturer=ALCATEL
S:  Product=Speed Touch USB 
S:  SerialNumber=0090D047C395
C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbdevfs
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=50ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbdevfs
I:  If#= 1 Alt= 1 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbdevfs
E:  Ad=06(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 2 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbdevfs
E:  Ad=06(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 3 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbdevfs
E:  Ad=06(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=05(O) Atr=02(Bulk) MxPS=   8 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=   8 Ivl=0ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=c5839000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
