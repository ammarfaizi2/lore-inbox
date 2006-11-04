Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWKDCvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWKDCvr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 21:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWKDCvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 21:51:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42757 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751678AbWKDCvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 21:51:46 -0500
Date: Sat, 4 Nov 2006 03:51:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, akpm@osdl.org,
       zippel@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] USB_RTL8150 must select MII
Message-ID: <20061104025145.GL13381@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200611021229.17324.david-b@pacbell.net> <20061103022726.GF13381@stusta.de> <200611021847.21817.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611021847.21817.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 06:47:15PM -0800, David Brownell wrote:
> On Thursday 02 November 2006 6:27 pm, Adrian Bunk wrote:
> 
> > It seems to lack the "select MII" at the USB_RTL8150 option that was in 
> > Randy's first patch?
> 
> I was just addressing the usbnet issues ... that driver doesn't
> use the usbnet framework.

OK, the patch for this driver is below.

> - Dave

cu
Adrian


<--  snip  -->


USB_RTL8150 must select MII to avoid link errors.

Stolen from a patch by Randy Dunlap.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2619-rc3-pv.orig/drivers/usb/net/Kconfig
+++ linux-2619-rc3-pv/drivers/usb/net/Kconfig
@@ -84,6 +84,7 @@ config USB_PEGASUS
 config USB_RTL8150
 	tristate "USB RTL8150 based ethernet device support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	select MII
 	help
 	  Say Y here if you have RTL8150 based usb-ethernet adapter.
 	  Send me <petkan@users.sourceforge.net> any comments you may have.

