Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287029AbSAGUzW>; Mon, 7 Jan 2002 15:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287037AbSAGUzM>; Mon, 7 Jan 2002 15:55:12 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:58246 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287029AbSAGUzI>; Mon, 7 Jan 2002 15:55:08 -0500
Message-ID: <3C3A0B1A.6441FC74@folkwang-hochschule.de>
Date: Mon, 07 Jan 2002 21:54:50 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: nettings@folkwang-hochschule.de
Subject: 2.4.17 usbnet usb.c: USB device not accepting new address
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello * !

when i try to connect my ipaq to the desktop via usbnet, i see the
following:

 kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
 kernel: hub.c: USB new device connect on bus1/2, assigned device
number 6
 kernel: usb.c: USB device not accepting new address=6 (error=-110)

i don't get an usbn network device when i do ifconfig -a.

i'm using 2.4.17 on a dual p3/600, mobo is asus p2b-ds.

the following usb-related modules are present:
usbnet                 10848   0  (unused)
mousedev                3904   0
hid                    12576   0  (unused)
input                   3488   0  [mousedev hid]
usb-uhci               21760   0  (unused)
usbcore                54688   1  [usbnet hid usb-uhci]

i have never been able to use usbnet since i have the ipaq. iirc, 
my first try was with 2.4.10-acsomething.

from a google search i found that some people recommended to boot
with noapic, but i'm not sure whether this is feasible on an smp
system. other than that, the problem seems to be known but yet
unresolved. 

here are some snippets from my .config:

kleineronkel:/usr/src/linux # cat .config|grep APIC
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

kleineronkel:/usr/src/linux # cat .config|grep USB
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_AUDIO=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_WACOM=m
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m
CONFIG_USB_USBNET=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y

thanks in advance for any insights,

regards,

jörn


-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/
