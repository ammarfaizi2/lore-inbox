Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEIqE>; Fri, 5 Jan 2001 03:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAEIpx>; Fri, 5 Jan 2001 03:45:53 -0500
Received: from cirrostratus.netaccess.co.nz ([202.37.101.18]:30482 "EHLO
	cirrostratus.netaccess.co.nz") by vger.kernel.org with ESMTP
	id <S129183AbRAEIpo>; Fri, 5 Jan 2001 03:45:44 -0500
Message-Id: <200101050845.VAA23907@cirrostratus.netaccess.co.nz>
Date: Fri, 05 Jan 2001 21:40:24 NZDT
From: Alastair Foster <alastair@netaccess.co.nz>
To: linux-kernel@vger.kernel.org
Subject: Adding devices to dc2xx.c
Reply-To: alasta@bigfoot.com
X-Mailer: Spruce 0.7.1 for X11 w/smtpio 0.7.9
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, and thank you to those who responded to my query about adding my
Agfa ePhoto to the USB mass storage device database. I had no success
with this (the machine locked hard on connecting the device), so I have
decided to try it with the dc2xx driver.

I have added it to /usr/src/linux/drivers/usb/dc2xx.c as follows:
..
    { idVendor: 0x040a, idProduct: 0x0112 },		// Kodak DC-290
    { idVendor: 0xf003, idProduct: 0x6002 },		// HP PhotoSmart C500
    { idVendor: 0x06bd, idProduct: 0x0403 },	// Agfa ePhoto CL18
..

However, after I recompile and reboot with the new boot image, I receive
the following:
..
Jan  5 19:37:33 localhost kernel: usb.c: registered new driver dc2xx 
..
Jan  5 19:37:33 localhost kernel: hub.c: USB new device connect on bus1/2,
assigned device number 2 
Jan  5 19:37:33 localhost kernel: usb.c: USB device 2 (vend/prod
0x6bd/0x403) is not claimed by any active driver. 
..

Why is dc2xx not being associated with the camera? I note that the vendor
and product names of the camera omit the leading '0', but I have tried
adding
them to the driver file as both '0x06bd' and '0x6bd' and neither works. I'm
using 2.4.0-prerelease, in case that helps.

So, does this sound like a bug with the above driver, or is there something
that I've missed?


-- 
Alastair Foster
Note new email address => alasta@bigfoot.com
http://users.netaccess.co.nz/ala/
021 250 6482

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
