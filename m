Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRJNBeL>; Sat, 13 Oct 2001 21:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273204AbRJNBeC>; Sat, 13 Oct 2001 21:34:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:12215
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S273176AbRJNBdx>; Sat, 13 Oct 2001 21:33:53 -0400
Date: Sat, 13 Oct 2001 18:34:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.12-ac1
Message-ID: <20011013183417.F15110@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011012141726.A27516@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011012141726.A27516@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 02:17:26PM +0100, Alan Cox wrote:

> 2.4.12-ac1

There's still a typo in drivers/usb/Config.in which will cause
CONFIG_USB_STORAGE_SDDR09 to always be asked.  The following fixes that.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--- linux-2.4.10-ac11.orig/drivers/usb/Config.in	Wed Oct 10 19:10:43 2001
+++ linux-2.4.10-ac11/drivers/usb/Config.in	Thu Oct 11 09:06:00 2001
@@ -42,7 +42,7 @@
    dep_mbool '    Microtech CompactFlash/SmartMedia reader' CONFIG_USB_STORAGE_DPCM  $CONFIG_USB_STORAGE
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e $CONFIG_USB_STORAGE
-      dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09 $CONIG_USB_STORAGE
+      dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09 $CONFIG_USB_STORAGE
    fi
 dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
 dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB
