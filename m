Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbVBCUEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVBCUEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbVBCUC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:02:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46240 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263385AbVBCT4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:56:49 -0500
Message-ID: <420281F1.4060808@pobox.com>
Date: Thu, 03 Feb 2005 14:56:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torben.mathiasen@hp.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Devices.txt, update with LANANA
References: <200502021845.j12Ij99X030188@hera.kernel.org> <20050203175710.GA24656@kroah.com>
In-Reply-To: <20050203175710.GA24656@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Feb 02, 2005 at 04:48:39PM +0000, Linux Kernel Mailing List wrote:
> 
>>ChangeSet 1.1992.2.74, 2005/02/02 08:48:39-08:00, torben.mathiasen@hp.com
>>
>>	[PATCH] Devices.txt, update with LANANA
>>	
>>	Attached is diff for bringing devices.txt uptodate with lanana.
>>	
>>	Please note: The devices.txt file in your tree will now be for 2.6+ kernels
>>	only.  2.6 specific allocations will now be given out more freely, and some
>>	of the stuff marked for obsolete for 2.6 has been removed.  I put a note in
>>	the file to let people know its for 2.6+ kernels only.
>>	
>>	I wanted to rename the new file to devices-2.6+.txt and then make a link
>>	from the old devices.txt to this new file, but diffing it became too ugly.
> 
> 
> <snip>
> 
>>@@ -2546,7 +2542,12 @@
>> 		  0 = /dev/usb/lp0	First USB printer
>> 		    ...
>> 		 15 = /dev/usb/lp15	16th USB printer
>>-		 32 = /dev/usb/mdc800	MDC800 USB camera
>>+		 16 = /dev/usb/mouse0	First USB mouse
>>+		    ...
>>+		 31 = /dev/usb/mouse15	16th USB mouse
>>+		 32 = /dev/usb/ez0	First USB firmware loader
>>+		    ...
>>+		 47 = /dev/usb/ez15	16th USB firmware loader
>> 		 48 = /dev/usb/scanner0	First USB scanner
>> 		    ...
>> 		 63 = /dev/usb/scanner15 16th USB scanner
>>@@ -2554,23 +2555,11 @@
>> 		 65 = /dev/usb/usblcd	USBLCD Interface (info@usblcd.de)
>> 		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)
>> 
>>-		 96 = /dev/usb/hiddev0	1st USB HID device
>>-		    ...
>>-		111 = /dev/usb/hiddev15	16th USB HID device
>>-		112 = /dev/usb/auer0	1st auerswald ISDN device
>>-		    ...
>>-		127 = /dev/usb/auer15	16th auerswald ISDN device
>>-		128 = /dev/usb/brlvgr0	First Braille Voyager device
>>-		    ...
>>-		131 = /dev/usb/brlvgr3	Fourth Braille Voyager device
>>-		132 = /dev/usb/idmouse	ID Mouse (fingerprint scanner) device
>>-		144 = /dev/usb/lcd	USB LCD device
>>-		160 = /dev/usb/legousbtower0	1st USB Legotower device
>>-		    ...
>>-		175 = /dev/usb/legousbtower15	16th USB Legotower device
>>-		240 = /dev/usb/dabusb0	First daubusb device
>>-		    ...
>>-		243 = /dev/usb/dabusb3	Fourth dabusb device
> 
> 
> Hm, this is just wrong.  As I recall, LANANA is in charge of the major
> numbers, but for the USB major, the USB developers have been assigning
> the USB minors.  This patch just made the file different from what is
> currently present in the kernel.
> 
> Should I just submit a patch to LANANA to update the USB minors for
> their copy so this doesn't happen again?

In general the policy has been:  submit to LANANA any changes to 
devices.txt, which they maintain.

So, they are the maintainer of major numbers, but also the maintainer of 
devices.txt.

	Jeff



