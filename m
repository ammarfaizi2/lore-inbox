Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263659AbVBCSYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263659AbVBCSYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbVBCSVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:21:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:2735 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263634AbVBCR5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:57:21 -0500
Date: Thu, 3 Feb 2005 09:57:10 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torben.mathiasen@hp.com
Cc: linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Devices.txt, update with LANANA
Message-ID: <20050203175710.GA24656@kroah.com>
References: <200502021845.j12Ij99X030188@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502021845.j12Ij99X030188@hera.kernel.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 04:48:39PM +0000, Linux Kernel Mailing List wrote:
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
> 	
> 	I wanted to rename the new file to devices-2.6+.txt and then make a link
> 	from the old devices.txt to this new file, but diffing it became too ugly.

<snip>

> @@ -2546,7 +2542,12 @@
>  		  0 = /dev/usb/lp0	First USB printer
>  		    ...
>  		 15 = /dev/usb/lp15	16th USB printer
> -		 32 = /dev/usb/mdc800	MDC800 USB camera
> +		 16 = /dev/usb/mouse0	First USB mouse
> +		    ...
> +		 31 = /dev/usb/mouse15	16th USB mouse
> +		 32 = /dev/usb/ez0	First USB firmware loader
> +		    ...
> +		 47 = /dev/usb/ez15	16th USB firmware loader
>  		 48 = /dev/usb/scanner0	First USB scanner
>  		    ...
>  		 63 = /dev/usb/scanner15 16th USB scanner
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

Hm, this is just wrong.  As I recall, LANANA is in charge of the major
numbers, but for the USB major, the USB developers have been assigning
the USB minors.  This patch just made the file different from what is
currently present in the kernel.

Should I just submit a patch to LANANA to update the USB minors for
their copy so this doesn't happen again?

I'll also fix this up in mainline in the next round of USB patches...

thanks,

greg k-h
