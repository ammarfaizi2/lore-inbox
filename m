Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278714AbRJ1WQd>; Sun, 28 Oct 2001 17:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278708AbRJ1WO7>; Sun, 28 Oct 2001 17:14:59 -0500
Received: from [63.231.122.81] ([63.231.122.81]:25146 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S278701AbRJ1WNQ>;
	Sun, 28 Oct 2001 17:13:16 -0500
Date: Sun, 28 Oct 2001 01:56:15 -0600
From: Andreas Dilger <adilger@turbolabs.com>
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] minor docs cleanups
Message-ID: <20011028015615.B4229@lynx.no>
Mail-Followup-To: torvalds@transmeta.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,
a couple of minor doc fixes.  I've tested the two cards in question with
multicast.

Cheers, Andreas
===========================================================================
diff -ru linux.orig/Documentation/devices.txt linux/Documentation/devices.txt
--- linux.orig/Documentation/devices.txt	Thu Oct 25 01:40:02 2001
+++ linux/Documentation/devices.txt	Thu Oct 25 03:15:06 2001
@@ -971,7 +971,7 @@
 		  0 = /dev/rd/c0d0	First disk, whole disk
 		  8 = /dev/rd/c0d1	Second disk, whole disk
 		    ...
-		248 = /dev/rd/c0d15	32nd disk, whole disk
+		248 = /dev/rd/c0d31	32nd disk, whole disk
 
 		For partitions add:
 		  0 = /dev/rd/c?d?	Whole disk
diff -ru linux.orig/Documentation/networking/multicast.txt linux/Documentation/networking/multicast.txt
--- linux.orig/Documentation/networking/multicast.txt	Tue Jul 31 14:59:56 2001
+++ linux/Documentation/networking/multicast.txt	Tue Jul 31 15:15:14 2001
@@ -31,6 +31,7 @@
 de600		NO		NO		NO		N/A
 de620		PROMISC		PROMISC		YES		Software
 depca		YES		PROMISC		YES		Hardware
+dmfe		YES		YES		YES		Software(*)
 e2100		YES		YES		YES		Hardware
 eepro		YES		PROMISC		YES		Hardware
 eexpress	NO		NO		NO		N/A
@@ -52,9 +53,12 @@
 tulip		YES		YES		YES		Hardware
 wavelan		YES		PROMISC		YES		Hardware
 wd		YES		YES		YES		Hardware
+xirc2ps_cs	YES		YES		YES		Hardware
 znet		YES		YES		YES		Software
 
 
 PROMISC = This multicast mode is in fact promiscuous mode. Avoid using
 cards who go PROMISC on any multicast in a multicast kernel.
+
 (#) = Hardware multicast support is not used yet.
+(*) = Hardware support for Davicom 9132 chipset only.
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

