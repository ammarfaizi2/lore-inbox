Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVAZXPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVAZXPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVAZXNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:13:48 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:17424 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262444AbVAZR1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:27:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=fpZ2XtXBZBJQdihstYx78y0qz3yHDQ8MwLQaxemyC+KyDZQP2y4C2+Z0YL/GUKhVa4KQoP5egwZFiAdU2dGpVR7+l0OKGBeli3Py/GK86stn8QyaWYax4uzgwxQyjDl4TA2946CWQ0fu7Ll8tMFQWzCfWbO+uJpJ7wJ3VnRwJSE=
Message-ID: <41F7D312.9040509@gmail.com>
Date: Wed, 26 Jan 2005 18:27:46 +0100
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, roms@lpg.ticalc.org, jb@technologeek.org
Subject: [PATCH 3/3] TIGLUSB Cleanups
Content-Type: multipart/mixed;
 boundary="------------060506040700090004070508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060506040700090004070508
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This removes the TIGLUSB-documentation, silverlink.txt.

--------------060506040700090004070508
Content-Type: text/x-patch;
 name="remove_silverlink_documentation.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="remove_silverlink_documentation.patch"

Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---

 silverlink.txt |   78 ---------------------------------------------------------
 1 files changed, 78 deletions(-)

--- clean/Documentation/usb/silverlink.txt
+++ dirty/Documentation/usb/silverlink.txt
@@ -1,78 +0,0 @@
--------------------------------------------------------------------------
-Readme for Linux device driver for the Texas Instruments SilverLink cable
-and direct USB cable provided by some TI's handhelds.
--------------------------------------------------------------------------
-
-Author: Romain Liévin & Julien Blache
-Homepage: http://lpg.ticalc.org/prj_usb
-
-INTRODUCTION:
-
-This is a driver for the TI-GRAPH LINK USB (aka SilverLink) cable, a cable 
-designed by TI for connecting their TI8x/9x calculators to a computer 
-(PC or Mac usually). It has been extended to support the USB port offered by
-some latest TI handhelds (TI84+ and TI89 Titanium).
-
-If you need more information, please visit the 'SilverLink drivers' homepage 
-at the above URL.
-
-WHAT YOU NEED:
-
-A TI calculator of course and a program capable to communicate with your 
-calculator.
-TiLP will work for sure (since I am his developer !). yal92 may be able to use
-it by changing tidev for tiglusb (may require some hacking...).
-
-HOW TO USE IT:
-
-You must have first compiled USB support, support for your specific USB host
-controller (UHCI or OHCI).
-
-Next, (as root) from your appropriate modules directory (lib/modules/2.5.XX):
-
-       insmod usb/usbcore.o
-       insmod usb/usb-uhci.o  <OR>  insmod usb/ohci-hcd.o
-       insmod tiglusb.o
-
-If it is not already there (it usually is), create the device:
-
-       mknod /dev/tiglusb0 c 115 16
-
-You will have to set permissions on this device to allow you to read/write
-from it:
-
-       chmod 666 /dev/tiglusb0
-       
-Now you are ready to run a linking program such as TiLP. Be sure to configure 
-it properly (RTFM).
-       
-MODULE PARAMETERS:
-
-  You can set these with:  insmod tiglusb NAME=VALUE
-  There is currently no way to set these on a per-cable basis.
-
-  NAME: timeout
-  TYPE: integer
-  DEFAULT: 15
-  DESC: Timeout value in tenth of seconds. If no data is available once this 
-       time has expired then the driver will return with a timeout error.
-
-QUIRKS:
-
-The following problem seems to be specific to the link cable since it appears 
-on all platforms (Linux, Windows, Mac OS-X). 
-
-In some very particular cases, the driver returns with success but
-without any data. The application should retry a read operation at least once.
-
-HOW TO CONTACT US:
-
-You can email me at roms@lpg.ticalc.org. Please prefix the subject line
-with "TIGLUSB: " so that I am certain to notice your message.
-You can also mail JB at jb@jblache.org: he has written the first release of 
-this driver but he better knows the Mac OS-X driver.
-
-CREDITS:
-
-The code is based on dabusb.c, printer.c and scanner.c !
-The driver has been developed independently of Texas Instruments Inc.

--------------060506040700090004070508--
