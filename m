Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265944AbUHIPRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUHIPRm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUHIPO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:14:59 -0400
Received: from kwisatz.net1.nerim.net ([80.65.225.31]:26629 "EHLO
	www.rubis.org") by vger.kernel.org with ESMTP id S266001AbUHIPNJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:13:09 -0400
Date: Mon, 9 Aug 2004 17:12:36 +0200
From: Stephane Jourdois <stephane@rubis.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Filip Van Raemdonck <filipvr@xs4all.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20040809151229.GA8651@diamant.rubis.org>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	Filip Van Raemdonck <filipvr@xs4all.be>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040808191912.GA620@elf.ucw.cz> <1092003277.2773.45.camel@pegasus> <20040809095425.GA12667@debian> <1092046959.21815.15.camel@pegasus> <20040809120705.GA23073@diamant.rubis.org> <1092057843.21815.21.camel@pegasus> <20040809133452.GA24530@diamant.rubis.org> <1092061267.4639.4.camel@pegasus>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1092061267.4639.4.camel@pegasus>
X-Operating-System: Linux 2.6.8-rc2-mm2
X-Send-From: diamant.tech.sitadelle.com
X-IMAPbase: 1078746539 16
User-Agent: Mutt/1.5.6+20040803i
X-SA-Exim-Connect-IP: 213.223.184.193
X-SA-Exim-Mail-From: kwisatz@rubis.org
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Report: * -4.9 BAYES_00 BODY: L'algorithme  =?ISO-8859-1?Q?=20Bay=E9sien?= a  =?ISO-8859-1?Q?=20=E9?=
	=?ISO-8859-1?Q?valu=E9?= la  =?ISO-8859-1?Q?=20probabilit=E9?= de spam entre 0 et 1%
	*      [score: 0.0000]
	*  0.4 AWL AWL: Auto-whitelist adjustment
X-SA-Exim-Version: 4.0 (built Sat, 24 Apr 2004 12:31:30 +0200)
X-SA-Exim-Scanned: Yes (on www.rubis.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Short answer : jump to the end of this mail.)

On Mon, Aug 09, 2004 at 04:21:08PM +0200, Marcel Holtmann wrote:
> > > I never used a -mm patch, so you must be a little bit more specific what
> > > is not working. What Bluetooth hardware are you using? Do the logfiles
> > > or dmesg include anything helpful?
> > 
> > I use a usb dongle, unfortunately included in my laptop, so I can't see
> > any serial number or anything.
> 
> I installed a 2.6.8-rc3-mm2 on my development machine and everything
> works like it should. I tried a RFCOMM connection to my mobile, a HCRP
> connection to my printer and I used a Bluetooth mouse. All stuff worked
> perfect.

Seems that I'll have to provide more debug info :-)

> Do "hciconfig -a" show your Bluetooth device? Do "/proc/bus/usb/devices"
> has an entry for it? Check "dmesg" for any USB related error messages.

BTW I tried a vanilla 2.6.8-rc3, and it works.


under 2.6.8-rc3-mm1 and  2.6.8-rc2-mm2 :

hciconfig -a gives nothing.

dmesg -s 1000000 | grep -i usb :
----
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
usbcore: registered new driver ub
hub 2-0:1.0: USB hub found
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
usb 3-2: new full speed USB device using address 2
usb 4-2: new full speed USB device using address 2
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
usb 4-2: can't set config #1, error -71
usb 3-2: USB disconnect, address 2
usb 3-2: new full speed USB device using address 3
usb 3-2: not running at top speed; connect to a high speed hub
usb 4-2: new full speed USB device using address 4
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
----


under 2.6.8-rc3 :

hciconfig -a :
----
hci0:   Type: USB
        BD Address: 00:10:60:A2:F9:30 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:24159 acl:1576 sco:0 events:160 errors:0
        TX bytes:1221 acl:24 sco:0 commands:52 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'diamant-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)
----

Here is relevant part of a
diff -u proc_bus_usb_devices_2.6.8-rc2-mm2 proc_bus_usb_devices_2.6.8-rc3 :
----
-T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
+T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
 D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
 P:  Vendor=0a12 ProdID=0001 Rev= 8.28
 C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
-I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
+I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
 E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
 E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
 E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
-I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
+I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
 E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
 E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
-I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
+I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
 E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
 E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
-I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
+I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
 E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
 E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
-I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
+I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
 E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
 E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
-I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
+I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
 E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
 E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
-I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
+I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
 E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
 E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
-I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=ub
+I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
----

I have quite same diff ("usb-storage" under -rc3, "ub" under -mm) for my
flash reader, which I tested under neither (I don't have any CF/SD card
here).

It seems that the wrong driver is used under -mm... After reading
bk-usb.patch, I see a new driver ub.c, which I enabled. With
CONFIG_BLK_DEV_UB disabled, 2.6.8-rc3-mm2 works.


So... my guess is that 2.6.8-rc2-mm* was broken, but as everything works
now in 2.6.8-rc3-mm2 it doesn't matter.

As I understand it, there is a bug in BLK_DEV_UB which make it says it
can handle hci devices, which is false. I'll leave BLK_DEV_UB disabled
for now.

Hope it helps,


Thanks for your help Marcel,
  Stephane.

-- 
 ///  Stephane Jourdois         /"\  ASCII RIBBON CAMPAIGN \\\
(((    Ingénieur développement  \ /    AGAINST HTML MAIL    )))
 \\\   24 rue Cauchy             X                         ///
  \\\  75015  Paris             / \    +33 6 8643 3085    ///
