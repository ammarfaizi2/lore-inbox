Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVACLR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVACLR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 06:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVACLR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 06:17:27 -0500
Received: from mail.x-echo.com ([195.101.94.2]:55021 "EHLO mail.x-echo.com")
	by vger.kernel.org with ESMTP id S261426AbVACLRO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 06:17:14 -0500
From: Serge Tchesmeli <zztchesmeli@echo.fr>
Organization: Transiciel
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: 2.6.10 and speedtouch usb
Date: Mon, 3 Jan 2005 12:17:07 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Roman Kagan <rkagan@mail.ru>
References: <200412271108.47578.zztchesmeli@echo.fr> <20041229161829.GA9076@panda.itep.ru> <200412301300.30105.duncan.sands@math.u-psud.fr>
In-Reply-To: <200412301300.30105.duncan.sands@math.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501031217.07912.zztchesmeli@echo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Jeudi 30 Décembre 2004 13:00, Duncan Sands a écrit :
> > It looks like the line status monitoring implemented in the driver in
> > 2.6.10 interferes with that in modem_run.  Unless you have a reason to
> > keep using modem_run, you can let it go and use the line status
> > monitoring and firmware loading facilities provided by the driver
> > itself.  Just follow Andrew's advice.
>
> Hi Roman, yes, but it would be good to understand what is going wrong - the
> debug info should help.  It would also be good to know the modem revision.
> Serge, what revision do you see in /proc/bus/usb/devices?
>
> All the best,
>
Hi all, HAPPY NEW YEAR 2005!! :)

So, here the informatios asked:

- Modem revision: 

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=06b9 ProdID=4061 Rev= 0.00
S:  Manufacturer=ALCATEL
S:  Product=Speed Touch USB
S:  SerialNumber=0090D02E7A5A
C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=50ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=speedtch
I:  If#= 1 Alt= 1 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=speedtch
E:  Ad=06(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 2 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=speedtch
E:  Ad=06(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 3 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=speedtch
E:  Ad=06(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=05(O) Atr=02(Bulk) MxPS=   8 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=   8 Ivl=0ms



- Debug log:

Dec 31 22:53:05 gateway kernel: usb 2-1: bogus endpoint ep7in in 
usb_submit_urb (bad maxpacket 0)<7>divert: not allocating divert_blk for 
non-ethernet device ppp0
Dec 31 22:53:05 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:05 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:08 gateway last message repeated 403 times
Dec 31 22:53:08 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:08 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:11 gateway last message repeated 410 times
Dec 31 22:53:11 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:11 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:14 gateway last message repeated 407 times
Dec 31 22:53:14 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:14 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:17 gateway last message repeated 409 times
Dec 31 22:53:17 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:17 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:20 gateway last message repeated 408 times
Dec 31 22:53:20 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:20 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:23 gateway last message repeated 406 times
Dec 31 22:53:23 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:23 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:26 gateway last message repeated 407 times
Dec 31 22:53:26 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:26 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:29 gateway last message repeated 412 times
Dec 31 22:53:29 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:29 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:32 gateway last message repeated 407 times
Dec 31 22:53:32 gateway kernel: usb 2-1: bogus endpoint ep7out in 
usb_submit_urb (bad maxpacket 0)<4>usb 2-1: usbfs: process 6023 (modem_run) 
did not claim interface 0 before use
Dec 31 22:53:32 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:53:35 gateway last message repeated 409 times
Dec 31 22:53:35 gateway kernel: divert: no divert_blk to free, ppp0 not 
ethernet
Dec 31 22:53:35 gateway kernel: usb 2-1: usbfs: process 6023 (modem_run) did 
not claim interface 0 before use
Dec 31 22:54:05 gateway last message repeated 4089 times


and some other log in messages:

Dec 31 22:53:35 gateway modem_run[6023]: Error reading interrupts
Dec 31 22:54:01 gateway last message repeated 3538 times


Note: 
I don't have try to change modem_run with the kernel firmware loader, i was 
very busy this week end (new year + my grand mother die :( ), i'm still in 
2.6.9 with modem_run and kernel speedtouch.







