Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278079AbRJKD36>; Wed, 10 Oct 2001 23:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278081AbRJKD3t>; Wed, 10 Oct 2001 23:29:49 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:25772
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S278079AbRJKD3m>; Wed, 10 Oct 2001 23:29:42 -0400
Date: Wed, 10 Oct 2001 20:30:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-ac11
Message-ID: <20011010203004.E11147@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  In updating the PPC defconfigs, I noticed that
drivers/usb/Config.in will ask questions on machines where CONFIG_PCI=n
but CONFIG_EXPERIMENTAL=y.  The following puts all of the USB items
under the if [ "$CONFIG_USB" = "y" -o "$CONFIG_USB" = "m" ] check and
fixes some spacing bits.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--- linux-2.4.10-ac11.orig/drivers/usb/Config.in	Wed Oct 10 19:10:43 2001
+++ linux-2.4.10-ac11/drivers/usb/Config.in	Wed Oct 10 20:25:15 2001
@@ -17,7 +17,6 @@
    fi
    bool '  Long timeout for slow-responding devices (some MGE Ellipse UPSes)' CONFIG_USB_LONG_TIMEOUT
    bool '  Large report fetching for "broken" devices (some APC UPSes)' CONFIG_USB_LARGE_CONFIG
-fi
 
 comment 'USB Controllers'
 if [ "$CONFIG_USB_UHCI_ALT" != "y" ]; then
@@ -31,9 +30,9 @@
 dep_tristate '  OHCI (Compaq, iMacs, OPTi, SiS, ALi, ...) support' CONFIG_USB_OHCI $CONFIG_USB
 
 comment 'USB Device Class drivers'
-dep_tristate '  USB Audio support' CONFIG_USB_AUDIO $CONFIG_USB $CONFIG_SOUND
-dep_tristate '  USB Bluetooth support (EXPERIMENTAL)' CONFIG_USB_BLUETOOTH $CONFIG_USB $CONFIG_EXPERIMENTAL
-dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
+   dep_tristate '  USB Audio support' CONFIG_USB_AUDIO $CONFIG_USB $CONFIG_SOUND
+   dep_tristate '  USB Bluetooth support (EXPERIMENTAL)' CONFIG_USB_BLUETOOTH $CONFIG_USB $CONFIG_EXPERIMENTAL
+   dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
    dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG $CONFIG_USB_STORAGE
    dep_mbool '    Datafab MDCFE-B Compact Flash Reader' CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
    dep_mbool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
@@ -44,8 +43,8 @@
       dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e $CONFIG_USB_STORAGE
       dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09 $CONIG_USB_STORAGE
    fi
-dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
-dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB
+   dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
+   dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB
 
 comment 'USB Human Interface Devices (HID)'
 if [ "$CONFIG_INPUT" = "n" ]; then
@@ -61,11 +60,11 @@
 fi
 
 comment 'USB Imaging devices'
-dep_tristate '  USB Kodak DC-2xx Camera support' CONFIG_USB_DC2XX $CONFIG_USB
-dep_tristate '  USB Mustek MDC800 Digital Camera support (EXPERIMENTAL)' CONFIG_USB_MDC800 $CONFIG_USB $CONFIG_EXPERIMENTAL
-dep_tristate '  USB Scanner support' CONFIG_USB_SCANNER $CONFIG_USB
-dep_tristate '  Microtek X6USB scanner support' CONFIG_USB_MICROTEK $CONFIG_USB $CONFIG_SCSI
-dep_tristate '  HP53xx USB scanner support (EXPERIMENTAL)' CONFIG_USB_HPUSBSCSI $CONFIG_USB $CONFIG_SCSI $CONFIG_EXPERIMENTAL
+   dep_tristate '  USB Kodak DC-2xx Camera support' CONFIG_USB_DC2XX $CONFIG_USB
+   dep_tristate '  USB Mustek MDC800 Digital Camera support (EXPERIMENTAL)' CONFIG_USB_MDC800 $CONFIG_USB $CONFIG_EXPERIMENTAL
+   dep_tristate '  USB Scanner support' CONFIG_USB_SCANNER $CONFIG_USB
+   dep_tristate '  Microtek X6USB scanner support' CONFIG_USB_MICROTEK $CONFIG_USB $CONFIG_SCSI
+   dep_tristate '  HP53xx USB scanner support (EXPERIMENTAL)' CONFIG_USB_HPUSBSCSI $CONFIG_USB $CONFIG_SCSI $CONFIG_EXPERIMENTAL
 
 comment 'USB Multimedia devices'
 if [ "$CONFIG_VIDEO_DEV" = "n" ]; then
@@ -92,10 +91,12 @@
 fi
 
 comment 'USB port drivers'
-dep_tristate '  USS720 parport driver' CONFIG_USB_USS720 $CONFIG_USB $CONFIG_PARPORT
+   dep_tristate '  USS720 parport driver' CONFIG_USB_USS720 $CONFIG_USB $CONFIG_PARPORT
 source drivers/usb/serial/Config.in
 
 comment 'Miscellaneous USB drivers'
-dep_tristate '  USB Diamond Rio500 support (EXPERIMENTAL)' CONFIG_USB_RIO500 $CONFIG_USB $CONFIG_EXPERIMENTAL
-dep_tristate '  USB MassWorks ID-75 (EXPERIMENTAL)' CONFIG_USB_ID75 $CONFIG_USB $CONFIG_EXPERIMENTAL
+   dep_tristate '  USB Diamond Rio500 support (EXPERIMENTAL)' CONFIG_USB_RIO500 $CONFIG_USB $CONFIG_EXPERIMENTAL
+   dep_tristate '  USB MassWorks ID-75 (EXPERIMENTAL)' CONFIG_USB_ID75 $CONFIG_USB $CONFIG_EXPERIMENTAL
+
+fi
 endmenu
