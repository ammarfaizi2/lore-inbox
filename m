Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVAEWwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVAEWwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 17:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVAEWwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 17:52:32 -0500
Received: from lakermmtao12.cox.net ([68.230.240.27]:50369 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262634AbVAEWwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 17:52:15 -0500
Mime-Version: 1.0 (Apple Message framework v619)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <71216E5F-5F6C-11D9-B39F-000393ACC76E@mac.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-3--43200846
Cc: Russell King <rmk+serial@arm.linux.org.uk>
Subject: [PATCH] [2.6] Clean up useless 8250 siig functions and header
From: Kyle Moffett <mrmacman_g4@mac.com>
Date: Wed, 5 Jan 2005 17:52:14 -0500
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-3--43200846
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

This removes two simple siig functions that should just be integrated 
into the
calling code.


--Apple-Mail-3--43200846
Content-Type: multipart/appledouble;
	boundary=Apple-Mail-4--43200846
Content-Disposition: attachment


--Apple-Mail-4--43200846
Content-Transfer-Encoding: base64
Content-Type: application/applefile;
	name="siig8250-header-cleanup.patch"
Content-Disposition: attachment;
	filename=siig8250-header-cleanup.patch

AAUWBwACAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAAJAAAAPgAAAAoAAAADAAAASAAAAB0AAAACAAAA
ZQAABToAAAAAAAAAAAAAc2lpZzgyNTAtaGVhZGVyLWNsZWFudXAucGF0Y2gAAAEAAAAFCAAABAgA
AAAyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAEBAAAABsvQXBwbGljYXRpb25zL1RleHRFZGl0LmFwcAACaGlvYgAA
AAUFU8FwAAAAAWhpb2IAAAAEBVTjsAAAAAFoaW9iAAAAAwVS3oAAAAABaGlvYgAAAAIFN0UQAAAA
AWV0cmcAAAABBVJ7IAAAAAJjbnRsAAAH3QVUsQAAAAACY250bAAAB9oFVEkgAAAAAmNudGwAAAfZ
AG+nsAAAAAJjbnRsAAAH1wVTwMAAAAACY250bAAAA+sFVEkAAAAAAmNudGwAAAPoBVPI0AAAAAJj
bnRsAAAAyQVTwdAAAAACY250bAAAAKEFUt7gAAAAAmNudGwAAACgBVLewAAAAAJjbnRsAAAAnwVT
qKCQAA/IY250bAAAAJ4FU8CgAAAAAmNudGwAAACdBVPBsAAAAAJjbnRsAAAAmgBvp5AAAAACY250
bAAAAJcFN0TwAAAAAmNudGwAAABqBTut4AAAAAJjbnRsAAAAaQVUewAAAAACY250bAAAAGgFU8oA
AAAAAmNudGwAAABnBVR54AAAAAJjbnRsAAAAZgVUeuAAAAACY250bAAAAGUFOYbwAAAAAmNudGwA
AAAzBVEVgAAAAAJjbnRsAAAAFgUyc1AAAAACY250bAAAABEFO64AAAAAAmNudGwAAAAQBTNnEAAA
AAJjbnRsAAAADwVUsOAAAAACY250bAAAAA4FM2cwAAAAAmNudGwAAAANBVI7EAAAAAJjbnRsAAAA
DAU5h2AAAAACY250bAAAAAoFUcZgAAAAAmNudGwAAAAJBVHGQAAAAAJjbnRsAAAACAU5htAAAAAC
Y250bAAAAAYFVBfgAAAAAmNudGwAAAAFBVTh4AAAAAJjbnRsAAAABAVSfFAAAAACY250bAAAAAMF
UfFwAAAAAmNudGwAAAACBVSv4AAAAAJjbnRsAAAAAQVSPEAAAAACYWNjZQAAACwFVOMQAAAAAWFj
Y2UAAAAqBVHwQAAAAAFhY2NlAAAAKQU7rPAAAAABYWNjZQAAABgFVFFQAAAAAWFjY2UAAAAXBVHG
IAAAAAFhY2NlAAAAFgVSJvAAAAABYWNjZQAAABUFVFAgAAAAAWFjY2UAAAACBTNmEAAAAAFhY2Nl
AAAAAQUzW9AAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVRwzAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAIAC097AAABAAAABQgAAAQIAAAAMgA+MIgBhQAAABwAMgAAdXNybwAA
AAoAAP//AAAAAAA/+Mg=

--Apple-Mail-4--43200846
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-mac-type=0;
	x-unix-mode=0644;
	x-mac-creator=0;
	name="siig8250-header-cleanup.patch"
Content-Disposition: attachment;
	filename=siig8250-header-cleanup.patch

Index: drivers/parport/parport_serial.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/drivers/parport/parport_serial.c,v
retrieving revision 1.13
diff -u -r1.13 parport_serial.c
--- drivers/parport/parport_serial.c	24 Jun 2004 15:55:22 -0000	1.13
+++ drivers/parport/parport_serial.c	5 Jan 2005 04:23:08 -0000
@@ -26,7 +26,6 @@
 #include <linux/serial.h>
 #include <linux/serialP.h>
 #include <linux/list.h>
-#include <linux/8250_pci.h>
 
 #include <asm/serial.h>
 
@@ -159,12 +158,14 @@
 
 static int __devinit siig10x_init_fn(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
 {
-	return pci_siig10x_fn(dev, enable);
+	if (enable)	return pci_siig10x_init(dev);
+	else		return 0;
 }
 
 static int __devinit siig20x_init_fn(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
 {
-	return pci_siig20x_fn(dev, enable);
+	if (enable)	return pci_siig20x_init(dev);
+	else		return 0;
 }
 
 static struct pci_board_no_ids pci_boards[] __devinitdata = {
Index: drivers/serial/8250_pci.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/drivers/serial/8250_pci.c,v
retrieving revision 1.39
diff -u -r1.39 8250_pci.c
--- drivers/serial/8250_pci.c	22 Nov 2004 16:43:12 -0000	1.39
+++ drivers/serial/8250_pci.c	5 Jan 2005 04:26:58 -0000
@@ -23,7 +23,6 @@
 #include <linux/delay.h>
 #include <linux/tty.h>
 #include <linux/serial_core.h>
-#include <linux/8250_pci.h>
 #include <linux/bitops.h>
 
 #include <asm/byteorder.h>
@@ -440,25 +439,6 @@
 	return 0;
 }
 
-int pci_siig10x_fn(struct pci_dev *dev, int enable)
-{
-	int ret = 0;
-	if (enable)
-		ret = pci_siig10x_init(dev);
-	return ret;
-}
-
-int pci_siig20x_fn(struct pci_dev *dev, int enable)
-{
-	int ret = 0;
-	if (enable)
-		ret = pci_siig20x_init(dev);
-	return ret;
-}
-
-EXPORT_SYMBOL(pci_siig10x_fn);
-EXPORT_SYMBOL(pci_siig20x_fn);
-
 /*
  * Timedia has an explosion of boards, and to avoid the PCI table from
  * growing *huge*, we use this function to collapse some 70 entries
Index: include/linux/8250_pci.h
===================================================================
RCS file: include/linux/8250_pci.h
diff -N include/linux/8250_pci.h
--- include/linux/8250_pci.h	21 Apr 2003 17:39:45 -0000	1.2
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,2 +0,0 @@
-int pci_siig10x_fn(struct pci_dev *dev, int enable);
-int pci_siig20x_fn(struct pci_dev *dev, int enable);

--Apple-Mail-4--43200846--

--Apple-Mail-3--43200846
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


--Apple-Mail-3--43200846--

