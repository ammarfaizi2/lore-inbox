Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVBCIzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVBCIzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVBCIzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:55:36 -0500
Received: from mail.suse.de ([195.135.220.2]:36781 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262442AbVBCIwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:52:25 -0500
Date: Thu, 3 Feb 2005 09:52:24 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Devices.txt, update with LANANA
Message-ID: <20050203085224.GA18210@suse.de>
References: <200502021845.j12Ij99X030188@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200502021845.j12Ij99X030188@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Feb 03, Linux Kernel Mailing List wrote:

> ChangeSet 1.1992.2.74, 2005/02/02 08:48:39-08:00, torben.mathiasen@hp.com
> 
> 	[PATCH] Devices.txt, update with LANANA
> 	
> 	Attached is diff for bringing devices.txt uptodate with lanana.
> 	
> 	Please note: The devices.txt file in your tree will now be for 2.6+ kernels
> 	only.  2.6 specific allocations will now be given out more freely, and some
> 	of the stuff marked for obsolete for 2.6 has been removed.  I put a note in
> 	the file to let people know its for 2.6+ kernels only.
...
> @@ -2554,23 +2555,11 @@
>  		 65 = /dev/usb/usblcd	USBLCD Interface (info@usblcd.de)
>  		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)
>  
> -		 96 = /dev/usb/hiddev0	1st USB HID device
> -		    ...
> -		111 = /dev/usb/hiddev15	16th USB HID device
> -		112 = /dev/usb/auer0	1st auerswald ISDN device
> -		    ...
> -		127 = /dev/usb/auer15	16th auerswald ISDN device
> -		128 = /dev/usb/brlvgr0	First Braille Voyager device
> -		    ...
> -		131 = /dev/usb/brlvgr3	Fourth Braille Voyager device
> -		132 = /dev/usb/idmouse	ID Mouse (fingerprint scanner) device
> -		144 = /dev/usb/lcd	USB LCD device
> -		160 = /dev/usb/legousbtower0	1st USB Legotower device
> -		    ...
> -		175 = /dev/usb/legousbtower15	16th USB Legotower device
> -		240 = /dev/usb/dabusb0	First daubusb device
> -		    ...
> -		243 = /dev/usb/dabusb3	Fourth dabusb device

I still see legousbtower registered in drivers/usb/misc/legousbtower.c.
Are you sure about these changes? Also, do the names in this document
match the names registered with sysfs (new mga_* stuff etc)?
I found a few sysfs entries that differ from devices.txt:
# misc devices
# 183 = /dev/hwrng        Generic random number generator
KERNEL="hw_random",     NAME="hwrng", SYMLINK="%k"
# 219 = /dev/modems/mwave MWave modem firmware upload
KERNEL="mwave",         NAME="modems/%k"
# 169 = /dev/specialix_rioctl Specialix RIO serial control
KERNEL="rioctl",        NAME="specialix_rioctl", SYMLINK="%k"
# 167 = /dev/specialix_sxctl Specialix serial control
KERNEL="sxctl",         NAME="specialix_sxctl", SYMLINK="%k"


