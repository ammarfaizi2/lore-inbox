Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAERMJ>; Fri, 5 Jan 2001 12:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131058AbRAERLu>; Fri, 5 Jan 2001 12:11:50 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:43023 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129860AbRAERLm>; Fri, 5 Jan 2001 12:11:42 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEB5@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'alasta@bigfoot.com'" <alasta@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: RE: Adding devices to dc2xx.c
Date: Fri, 5 Jan 2001 09:11:32 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello, and thank you to those who responded to my query about 
> adding my
> Agfa ePhoto to the USB mass storage device database. I had no success
> with this (the machine locked hard on connecting the device), 
> so I have decided to try it with the dc2xx driver.
> 
> I have added it to /usr/src/linux/drivers/usb/dc2xx.c as follows:
> ..
>     { idVendor: 0x040a, idProduct: 0x0112 },		// Kodak DC-290
>     { idVendor: 0xf003, idProduct: 0x6002 },		// HP 
> PhotoSmart C500
>     { idVendor: 0x06bd, idProduct: 0x0403 },	// Agfa ePhoto CL18
> ..
> 
> However, after I recompile and reboot with the new boot 
> image, I receive the following:
> ..
> Jan  5 19:37:33 localhost kernel: usb.c: registered new driver dc2xx 
> ..
> Jan  5 19:37:33 localhost kernel: hub.c: USB new device 
> connect on bus1/2, assigned device number 2 
> Jan  5 19:37:33 localhost kernel: usb.c: USB device 2 (vend/prod
> 0x6bd/0x403) is not claimed by any active driver. 
> ..
> 
> Why is dc2xx not being associated with the camera? I note 
> that the vendor
> and product names of the camera omit the leading '0', but I have tried
> adding them to the driver file as both '0x06bd' and '0x6bd' and 
> neither works. I'm
> using 2.4.0-prerelease, in case that helps.
> 
> So, does this sound like a bug with the above driver, or is 
> there something that I've missed?

Either you don't have dc2xx compiled into the kernel, or
if it's a module, you don't have it loaded yet.  You should
load it manually or add hotplug support
and the proper support files for it.
See http://www.linux-usb.org/policy.html.

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
