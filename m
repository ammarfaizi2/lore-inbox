Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSE2URL>; Wed, 29 May 2002 16:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSE2URK>; Wed, 29 May 2002 16:17:10 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:55313 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315458AbSE2URJ>; Wed, 29 May 2002 16:17:09 -0400
Date: Wed, 29 May 2002 21:17:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.19
Message-ID: <20020529211702.E30585@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following change appeared in 2.5.19:

xx- a/drivers/video/cyber2000fb.c       Wed May 29 11:43:02 2002
xx+ b/drivers/video/cyber2000fb.c       Wed May 29 11:43:02 2002
@@ -1729,9 +1729,8 @@
 }

 static struct pci_device_id cyberpro_pci_table[] __devinitdata = {
-// Not yet
-//     { PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
-//             PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
+       { PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
+               PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
        { PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2000,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_2000 },
        { PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2010,

This is completely wrong - the driver has been tested NOT to work on
the Integraphics 1682.  As such, please do uncomment these lines.

In addition, I'm disappointed that no one forwarded the patch for
maintainer approval PRIOR to submitting it to Linus.

Linus, I request that you apply the following patch.  Thanks.

--- orig/drivers/video/cyber2000fb.c	Mon May  6 16:54:10 2002
+++ linux/drivers/video/cyber2000fb.c	Mon May 13 10:48:13 2002
@@ -1729,8 +1729,9 @@
 }
 
 static struct pci_device_id cyberpro_pci_table[] __devinitdata = {
-	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
+// Not yet
+//	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
+//		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
 	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2000,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_2000 },
 	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2010,


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

