Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVAZQRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVAZQRv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVAZQRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:17:46 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:13249 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262341AbVAZQRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:17:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=bQHUVr6v7IeqQdzdQM4A1kALYP5AwlLrC6PdyDCutDAQq7vyrRRHZg+210nQ/MLzVjdcMKf45tQYRn2YtaAIl6G9WG7YiVMKSWGFwX0+2D7Wr8Ik0XANMeVAJ97fvqdoE4zCbYS+oa6yr3eU6DTO/f/a4NqK/yGp7CnN+oFcZx4=
Message-ID: <41F7C0F1.2000301@gmail.com>
Date: Wed, 26 Jan 2005 17:10:25 +0100
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, roms@lpg.ticalc.org, jb@technologeek.org
Subject: [PATCH 3/3] TIGLUSB Cleanups
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the TIGLUSB-documentation, silverlink.txt.


Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---

 silverlink.txt |   78 
---------------------------------------------------------
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
-(PC or Mac usually). It has been extended to support the USB port 
offered by
-some latest TI handhelds (TI84+ and TI89 Titanium).
-
-If you need more information, please visit the 'SilverLink drivers' 
homepage
-at the above URL.
-
-WHAT YOU NEED:
-
-A TI calculator of course and a program capable to communicate with your
-calculator.
-TiLP will work for sure (since I am his developer !). yal92 may be able 
to use
-it by changing tidev for tiglusb (may require some hacking...).
-
-HOW TO USE IT:
-
-You must have first compiled USB support, support for your specific USB 
host
-controller (UHCI or OHCI).
-
-Next, (as root) from your appropriate modules directory 
(lib/modules/2.5.XX):
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
-Now you are ready to run a linking program such as TiLP. Be sure to 
configure
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
-  DESC: Timeout value in tenth of seconds. If no data is available once 
this
-       time has expired then the driver will return with a timeout error.
-
-QUIRKS:
-
-The following problem seems to be specific to the link cable since it 
appears
-on all platforms (Linux, Windows, Mac OS-X).
-
-In some very particular cases, the driver returns with success but
-without any data. The application should retry a read operation at 
least once.
-
-HOW TO CONTACT US:
-
-You can email me at roms@lpg.ticalc.org. Please prefix the subject line
-with "TIGLUSB: " so that I am certain to notice your message.
-You can also mail JB at jb@jblache.org: he has written the first 
release of
-this driver but he better knows the Mac OS-X driver.
-
-CREDITS:
-
-The code is based on dabusb.c, printer.c and scanner.c !
-The driver has been developed independently of Texas Instruments Inc.

