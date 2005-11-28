Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVK1RSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVK1RSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVK1RSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:18:20 -0500
Received: from khc.piap.pl ([195.187.100.11]:1028 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932126AbVK1RST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:18:19 -0500
To: Duncan Sands <duncan.sands@free.fr>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: speedtch driver, 2.6.14.2
References: <200511232125.25254.s0348365@sms.ed.ac.uk>
	<200511280929.56230.duncan.sands@free.fr>
	<m3psolum07.fsf@defiant.localdomain>
	<200511281234.45023.duncan.sands@free.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 28 Nov 2005 18:18:16 +0100
In-Reply-To: <200511281234.45023.duncan.sands@free.fr> (Duncan Sands's
 message of "Mon, 28 Nov 2005 12:34:44 +0100")
Message-ID: <m3sltgu1wn.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands <duncan.sands@free.fr> writes:

> If you turn on CONFIG_USB_DEBUG, enough info should turn up to be able
> to work out which urbs are failing.  That would be helpful.

dmesg | egrep -i 'usb|atm|speedt' attached.

Firmware? Didn't know I have options :-)
I think it's version 3.012, I got it with ADSL subscriber package
and extracted using (probably) the firmware extractor (the hacked
modem_run). I can verify this if you want.

   935 Nov 27  2004 speedtch-1.bin.4.00
775545 Nov 27  2004 speedtch-2.bin.4.00

MD5:
0503efe8d7efc0fe10e7593cecdb8fb8  speedtch-1.bin.4.00
79300e856fbef976c99fe339be8ba238  speedtch-2.bin.4.00

defiant:/lib/firmware$ cat /proc/bus/usb/devices |grep -B 1 TH
P:  Vendor=06b9 ProdID=4061 Rev= 4.00
S:  Manufacturer=THOMSON


15:54:29 USB Universal Host Controller Interface driver v2.3
15:54:31 uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
15:54:31 usb usb1: default language 0x0409
15:54:31 usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
15:54:31 usb usb1: Product: UHCI Host Controller
15:54:31 usb usb1: Manufacturer: Linux 2.6.14 uhci_hcd
15:54:31 usb usb1: SerialNumber: 0000:00:07.2
15:54:31 usb usb1: hotplug
15:54:31 usb usb1: adding 1-0:1.0 (config #1, interface 0)
15:54:31 usb 1-0:1.0: hotplug
15:54:31 hub 1-0:1.0: usb_probe_interface
15:54:31 hub 1-0:1.0: usb_probe_interface - got id
15:54:31 hub 1-0:1.0: USB hub found
15:54:31 hub 1-0:1.0: no power switching (usb 1.0)
15:54:32 usb 1-1: new full speed USB device using uhci_hcd and address 2
15:54:32 usb 1-1: ep0 maxpacket = 8
15:54:32 usb 1-1: default language 0x0409
15:54:32 usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=3
15:54:32 usb 1-1: Product: Speed Touch 330
15:54:32 usb 1-1: Manufacturer: THOMSON
15:54:32 usb 1-1: SerialNumber: 000E501A7727
15:54:32 usb 1-1: hotplug
15:54:32 usb 1-1: adding 1-1:1.0 (config #1, interface 0)
15:54:32 usb 1-1:1.0: hotplug
15:54:32 usb 1-1: adding 1-1:1.1 (config #1, interface 1)
15:54:32 usb 1-1:1.1: hotplug
15:54:32 usb 1-1: adding 1-1:1.2 (config #1, interface 2)
15:54:32 usb 1-1:1.2: hotplug
15:54:32 Initializing USB Mass Storage driver...
15:54:33 usbcore: registered new driver usb-storage
15:54:33 USB Mass Storage support registered.
15:54:33 usbatm.c: usbatm_usb_init: driver version 1.9
15:54:33 speedtch.c: speedtch_usb_init: driver version 1.9
15:54:33 speedtch 1-1:1.0: usb_probe_interface
15:54:33 speedtch 1-1:1.0: usb_probe_interface - got id
15:54:33 speedtch 1-1:1.0: usbatm_usb_probe: trying driver speedtch with
         vendor=0x6b9, product=0x4061, ifnum 0
15:54:33 usb 1-1: modprobe timed out on ep0in len=0/1
15:54:33 usb 1-1: reset full speed USB device using uhci_hcd and address 2
15:54:33 usb 1-1: ep0 maxpacket = 8
15:54:33 usbcore: registered new driver speedtch
15:54:33 speedtch 1-1:1.0: found stage 1 firmware speedtch-1.bin.4.00
15:54:33 speedtch 1-1:1.0: found stage 2 firmware speedtch-2.bin.4.00
15:54:34 ATM dev 0: speedtch_atm_start entered
15:54:34 ATM dev 0: speedtch_start_synchro entered
15:54:34 ATM dev 0: speedtch_start_synchro: modem prodded. 2 bytes returned: 00
00
15:54:34 /usr/src/linux-2.6/drivers/usb/atm/usbatm.c: usbatm_get_instance
15:54:34 ATM dev 0: speedtch_check_status entered
15:54:34 ATM dev 0: speedtch_check_status: line state 10
15:54:34 ATM dev 0: ADSL line is synchronising
15:54:34 ATM dev 0: usbatm_atm_open: vpi 0, vci 35
15:54:34 ATM dev 0: usbatm_atm_open: allocated vcc data 0xc7e03be0
15:54:34 ATM dev 0: speedtch_check_status entered
15:54:34 ATM dev 0: speedtch_check_status: line state 10
15:54:34 ATM dev 0: speedtch_check_status entered
15:54:34 ATM dev 0: speedtch_check_status: line state 10
15:54:34 ATM dev 0: speedtch_check_status entered
15:54:34 ATM dev 0: speedtch_check_status: line state 20
15:54:34 ATM dev 0: ADSL line is up (320 kb/s down | 160 kb/s up)
15:54:34 ATM dev 0: speedtch_check_status entered
15:54:34 ATM dev 0: speedtch_check_status: line state 20
15:54:35 ATM dev 0: speedtch_check_status entered
15:54:35 ATM dev 0: speedtch_check_status: line state 20
15:54:40 ATM dev 0: speedtch_check_status entered
15:54:40 ATM dev 0: speedtch_check_status: line state 20

(and so on)

17:03:10 ATM dev 0: speedtch_check_status entered
17:03:10 ATM dev 0: speedtch_check_status: line state 20
17:03:15 ATM dev 0: speedtch_check_status entered
17:03:17 usb 1-1: events/0 timed out on ep0in len=0/4
17:03:17 ATM dev 0: speedtch_read_status: MSG D failed
17:03:17 ATM dev 0: error -110 fetching device status
17:03:20 ATM dev 0: speedtch_check_status entered
17:03:20 ATM dev 0: speedtch_check_status: line state 20
-- 
Krzysztof Halasa
