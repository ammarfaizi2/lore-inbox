Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRJKWDJ>; Thu, 11 Oct 2001 18:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276984AbRJKWC7>; Thu, 11 Oct 2001 18:02:59 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:41390
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S276982AbRJKWCu>; Thu, 11 Oct 2001 18:02:50 -0400
Date: Thu, 11 Oct 2001 15:03:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-ac11
Message-ID: <20011011150310.A21564@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk> <20011010203004.E11147@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010203004.E11147@cpe-24-221-152-185.az.sprintbbd.net>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 08:30:04PM -0700, Tom Rini wrote:

> Hello.  In updating the PPC defconfigs, I noticed that
> drivers/usb/Config.in will ask questions on machines where CONFIG_PCI=n
> but CONFIG_EXPERIMENTAL=y.  The following puts all of the USB items
> under the if [ "$CONFIG_USB" = "y" -o "$CONFIG_USB" = "m" ] check and
> fixes some spacing bits.

After looking even more closely, I noticed there was a typo which is why
1 question was still asked afterall.  The following is even less
intrusive and probably more correct.

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
