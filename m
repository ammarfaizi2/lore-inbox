Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbRFCNXz>; Sun, 3 Jun 2001 09:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262989AbRFCNPC>; Sun, 3 Jun 2001 09:15:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38921 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262922AbRFCMea>;
	Sun, 3 Jun 2001 08:34:30 -0400
Date: Sun, 3 Jun 2001 13:33:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oleg Drokin <green@linuxhacker.ru>, Alan Cox <laughing@shared-source.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
Message-ID: <20010603133333.A25478@flint.arm.linux.org.uk>
In-Reply-To: <200106030746.f537kSZ12820@linuxhacker.ru> <E156VvF-0004D1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E156VvF-0004D1-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jun 03, 2001 at 12:19:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2001 at 12:19:52PM +0100, Alan Cox wrote:
> > AC> 2.4.5-ac7
> > AC> o       Make USB require PCI                            (me)
> > Huh?!
> > How about people from StrongArm sa11x0 port, who have USB host controller (in
> > sa1111 companion chip) but do not have PCI?
> 
> The strongarm doesnt have a USB master but a slave.

Alan, a StrongARM 11x0 with its companion SA11x1 chip is a USB master.
Last time I looked, it was supported:

diff -urN 2.4.5-rmk2/linux/drivers/usb/usb-ohci-sa1111.h linux/drivers/usb/usb-ohci-sa1111.h
--- 2.4.5-rmk2/linux/drivers/usb/usb-ohci-sa1111.h      Wed Dec 31 19:00:00 1969
+++ linux/drivers/usb/usb-ohci-sa1111.h Tue May 29 16:49:47 2001
@@ -0,0 +1,692 @@
+/*
+ * usb-ohci-sa1111.h
+ *
+ * definitions and special code for Intel SA-1111 USB OHCI host controller
+ *
+ * 10/24/00 Brad Parker <brad@heeltoe.com>
+ * added memory allocation code
+ *
+ * 09/26/00 Brad Parker <brad@heeltoe.com>
+ * init code for the SA-1111 ohci controller
+ * special dma map/unmap code to compensate for SA-1111 h/w bug
+ *
+ */

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

