Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSEHPrN>; Wed, 8 May 2002 11:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314486AbSEHPrM>; Wed, 8 May 2002 11:47:12 -0400
Received: from www.ttb.siemens.com ([192.5.31.80]:65061 "HELO
	www.ttb.simens.com") by vger.kernel.org with SMTP
	id <S314491AbSEHPrJ>; Wed, 8 May 2002 11:47:09 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: "J. Albers" <j_albers@web.de>
To: linux-kernel@vger.kernel.org
Subject: Kernelpatch: multi line string problem in 2.5.14 with gcc3.x
Date: Wed, 8 May 2002 08:45:31 -0700
X-Mailer: KMail [version 1.4]
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200205080845.31655.j_albers@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patches fix problems with multi line stings in 2.5.14 /w gcc 3.x

Best regards,
 Jens Albers

==========  Begin #1 ==========
--- aic7xxx_linux.c_2.5.14      Wed May  8 08:00:27 2002
+++ aic7xxx_linux.c     Wed May  8 08:01:24 2002
@@ -398,26 +398,26 @@
 MODULE_LICENSE("Dual BSD/GPL");
 #endif
 MODULE_PARM(aic7xxx, "s");
-MODULE_PARM_DESC(aic7xxx, "period delimited, options string.
-       verbose                 Enable verbose/diagnostic logging
-       no_probe                Disable EISA/VLB controller probing
-       no_reset                Supress initial bus resets
-       extended                Enable extended geometry on all controllers
-       periodic_otag           Send an ordered tagged transaction 
periodically
-                               to prevent tag starvation.  This may be
-                               required by some older disk drives/RAID 
arrays.
-       reverse_scan            Sort PCI devices highest Bus/Slot to lowest
-       tag_info:<tag_str>      Set per-target tag depth
-       seltime:<int>           Selection 
Timeout(0/256ms,1/128ms,2/64ms,3/32ms)
-
-       Sample /etc/modules.conf line:
-               Enable verbose logging
-               Disable EISA/VLB probing
-               Set tag depth on Controller 2/Target 2 to 10 tags
-               Shorten the selection timeout to 128ms from its default of 256
-
-       options 
aic7xxx='\"verbose.no_probe.tag_info:{{}.{}.{..10}}.seltime:1\"'
-");
+MODULE_PARM_DESC(aic7xxx, "period delimited, options string."
+"      verbose                 Enable verbose/diagnostic logging"
+"      no_probe                Disable EISA/VLB controller probing"
+"      no_reset                Supress initial bus resets"
+"      extended                Enable extended geometry on all controllers"
+"      periodic_otag           Send an ordered tagged transaction 
periodically"
+"                              to prevent tag starvation.  This may be"
+"                              required by some older disk drives/RAID 
arrays."
+"      reverse_scan            Sort PCI devices highest Bus/Slot to lowest"
+"      tag_info:<tag_str>      Set per-target tag depth"
+"      seltime:<int>           Selection 
Timeout(0/256ms,1/128ms,2/64ms,3/32ms)"
+""
+"      Sample /etc/modules.conf line:"
+"              Enable verbose logging"
+"              Disable EISA/VLB probing"
+"              Set tag depth on Controller 2/Target 2 to 10 tags"
+"              Shorten the selection timeout to 128ms from its default of 
256"
+""
+"      options 
aic7xxx='\"verbose.no_probe.tag_info:{{}.{}.{..10}}.seltime:1\"'"
+);
 #endif

 static void ahc_linux_handle_scsi_status(struct ahc_softc *,
==========  End #1 ==========

==========  Begin #2 ==========
--- i2c-core.c_2.5.14   Wed May  8 08:31:40 2002
+++ i2c-core.c  Wed May  8 08:32:43 2002
@@ -381,10 +381,10 @@
                                                printk("i2c-core.o: while "
                                                       "unregistering driver "
                                                       "`%s', the client at "
-                                                      "address %02x of
-                                                      adapter `%s' could not
-                                                      be detached; driver
-                                                      not unloaded!",
+                                                      "address %02x of "
+                                                      "adapter `%s' could not 
"
+                                                      "be detached; driver "
+                                                      "not unloaded!",
                                                       driver->name,
                                                       client->addr,
                                                       adap->name);
==========  Begin #2 ==========
