Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWIDLy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWIDLy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWIDLy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:54:28 -0400
Received: from styx.suse.cz ([82.119.242.94]:6364 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964831AbWIDLy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:54:27 -0400
Date: Mon, 4 Sep 2006 13:54:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeremy Roberson <jroberson@gtcocalcomp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] drivers/usb/input/hid-core.c: fix duplicate USB_DEVICE_ID_GTCO_404
Message-ID: <20060904115423.GA31489@suse.cz>
References: <20060904114110.GK4416@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060904114110.GK4416@stusta.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 01:41:10PM +0200, Adrian Bunk wrote:
> On Fri, Sep 01, 2006 at 01:58:18AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc4-mm3:
> >...
> > +gregkh-usb-hid-core.c-adds-all-gtco-calcomp-digitizers-and-interwrite-school-products-to-blacklist.patch
> >...
> >  USB tree updates.
> >...
> 
> The GNU C compiler spotted the following bug:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/usb/input/hid-core.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c:1446:1: warning: "USB_DEVICE_ID_GTCO_404" redefined
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c:1445:1: warning: this is the location of the previous definition
> ...
> 
> <--  snip  -->
> 
> This patch fixes this cut'n'paste error.

Thanks, Adrian. Greg, please apply.

> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c.old	2006-09-03 21:00:25.000000000 +0200
> +++ linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c	2006-09-03 21:00:44.000000000 +0200
> @@ -1443,7 +1443,7 @@
>  #define USB_DEVICE_ID_GTCO_402		0x0402
>  #define USB_DEVICE_ID_GTCO_403		0x0403
>  #define USB_DEVICE_ID_GTCO_404		0x0404
> -#define USB_DEVICE_ID_GTCO_404		0x0405
> +#define USB_DEVICE_ID_GTCO_405		0x0405
>  #define USB_DEVICE_ID_GTCO_500		0x0500
>  #define USB_DEVICE_ID_GTCO_501		0x0501
>  #define USB_DEVICE_ID_GTCO_502		0x0502
> @@ -1663,7 +1663,7 @@
>  	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_402, HID_QUIRK_IGNORE },
>  	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_403, HID_QUIRK_IGNORE },
>  	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
> -	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
> +	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_405, HID_QUIRK_IGNORE },
>  	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_500, HID_QUIRK_IGNORE },
>  	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_501, HID_QUIRK_IGNORE },
>  	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_502, HID_QUIRK_IGNORE },
> 
> 
> 

-- 
Vojtech Pavlik
Director SuSE Labs

-- 
VGER BF report: H 0.0165713
