Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270000AbTHAKqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274882AbTHAKqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:46:06 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:56081 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270717AbTHAKoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:44:24 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22-pre10] Reorder "Network Device Support" under "Networking Options"
Date: Fri, 1 Aug 2003 12:40:06 +0200
User-Agent: KMail/1.5.2
Organization: Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200307312246.48901.m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GOkK/yr4hicDvDe"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_GOkK/yr4hicDvDe
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

I've been getting complaints about the menu structure from the linux kernel 
config subsystem for a _long time_. Now let's reorder $subject. We are getting 
close that the menu will look more cleaner :)

More cleanups for different menu's are following.

It's the same menu structure like in 2.5/2.6.

Please apply for 2.4.22-pre10. Thank you :)

ciao, Marc

--Boundary-00=_GOkK/yr4hicDvDe
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.4-netdevices-reorder.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4-netdevices-reorder.patch"

--- a/arch/i386/config.in	Thu Sep 26 12:19:14 2002
+++ b/arch/i386/config.in	Thu Sep 26 12:25:37 2002
@@ -355,6 +355,20 @@
    source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Network device support'
+
+   bool 'Network device support' CONFIG_NETDEVICES
+   if [ "$CONFIG_NETDEVICES" = "y" ]; then
+      source drivers/net/Config.in
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+         source drivers/atm/Config.in
+      fi
+   fi
+   endmenu
+fi
+
 source drivers/telephony/Config.in
 
 mainmenu_option next_comment
@@ -386,19 +386,6 @@
 
 source drivers/message/i2o/Config.in
 
-if [ "$CONFIG_NET" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Network device support'
-
-   bool 'Network device support' CONFIG_NETDEVICES
-   if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      source drivers/net/Config.in
-      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-         source drivers/atm/Config.in
-      fi
-   fi
-   endmenu
-fi
 
 source net/ax25/Config.in
 
--- a/arch/ppc/config.in	2003-07-31 01:45:38.000000000 +0200
+++ b/arch/ppc/config.in	2003-07-31 22:31:23.000000000 +0200
@@ -293,6 +293,20 @@ if [ "$CONFIG_NET" = "y" ]; then
   source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+  mainmenu_option next_comment
+  comment 'Network device support'
+
+  bool 'Network device support' CONFIG_NETDEVICES
+  if [ "$CONFIG_NETDEVICES" = "y" ]; then
+    source drivers/net/Config.in
+    if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+      source drivers/atm/Config.in
+    fi
+  fi
+  endmenu
+fi
+
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
@@ -316,20 +330,6 @@ endmenu
 
 source drivers/ieee1394/Config.in
 
-if [ "$CONFIG_NET" = "y" ]; then
-  mainmenu_option next_comment
-  comment 'Network device support'
-
-  bool 'Network device support' CONFIG_NETDEVICES
-  if [ "$CONFIG_NETDEVICES" = "y" ]; then
-    source drivers/net/Config.in
-    if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-      source drivers/atm/Config.in
-    fi
-  fi
-  endmenu
-fi
-
 source net/ax25/Config.in
 
 source net/irda/Config.in
--- a/arch/ppc64/config.in	2003-07-31 01:45:38.000000000 +0200
+++ b/arch/ppc64/config.in	2003-07-31 22:32:08.000000000 +0200
@@ -111,6 +111,20 @@ if [ "$CONFIG_NET" = "y" ]; then
    source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Network device support'
+
+   bool 'Network device support' CONFIG_NETDEVICES
+   if [ "$CONFIG_NETDEVICES" = "y" ]; then
+      source drivers/net/Config.in
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+         source drivers/atm/Config.in
+      fi
+   fi
+   endmenu
+fi
+
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
@@ -134,20 +148,6 @@ endmenu
 
 source drivers/ieee1394/Config.in
 
-if [ "$CONFIG_NET" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Network device support'
-
-   bool 'Network device support' CONFIG_NETDEVICES
-   if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      source drivers/net/Config.in
-      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-         source drivers/atm/Config.in
-      fi
-   fi
-   endmenu
-fi
-
 source net/ax25/Config.in
 
 mainmenu_option next_comment
--- a/arch/alpha/config.in	2003-07-31 01:45:30.000000000 +0200
+++ b/arch/alpha/config.in	2003-07-31 22:33:18.000000000 +0200
@@ -331,6 +331,20 @@ if [ "$CONFIG_NET" = "y" ]; then
   source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+  mainmenu_option next_comment
+  comment 'Network device support'
+
+  bool 'Network device support' CONFIG_NETDEVICES
+  if [ "$CONFIG_NETDEVICES" = "y" ]; then
+    source drivers/net/Config.in
+    if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+      source drivers/atm/Config.in
+    fi
+  fi
+  endmenu
+fi
+
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
@@ -360,20 +374,6 @@ if [ "$CONFIG_PCI" = "y" ]; then
   source drivers/ieee1394/Config.in
 fi
 
-if [ "$CONFIG_NET" = "y" ]; then
-  mainmenu_option next_comment
-  comment 'Network device support'
-
-  bool 'Network device support' CONFIG_NETDEVICES
-  if [ "$CONFIG_NETDEVICES" = "y" ]; then
-    source drivers/net/Config.in
-    if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-      source drivers/atm/Config.in
-    fi
-  fi
-  endmenu
-fi
-
 source net/ax25/Config.in
 
 mainmenu_option next_comment
--- a/arch/cris/config.in	2003-07-31 01:45:34.000000000 +0200
+++ b/arch/cris/config.in	2003-07-31 22:34:47.000000000 +0200
@@ -174,6 +174,20 @@ if [ "$CONFIG_NET" = "y" ]; then
   source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+  mainmenu_option next_comment
+  comment 'Network device support'
+
+  bool 'Network device support' CONFIG_NETDEVICES
+  if [ "$CONFIG_NETDEVICES" = "y" ]; then
+    source drivers/net/Config.in
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+         source drivers/atm/Config.in
+      fi
+  fi
+  endmenu
+fi
+
 source drivers/telephony/Config.in
 
 mainmenu_option next_comment
@@ -203,20 +217,6 @@ source drivers/ieee1394/Config.in
 
 source drivers/message/i2o/Config.in
 
-if [ "$CONFIG_NET" = "y" ]; then
-  mainmenu_option next_comment
-  comment 'Network device support'
-
-  bool 'Network device support' CONFIG_NETDEVICES
-  if [ "$CONFIG_NETDEVICES" = "y" ]; then
-    source drivers/net/Config.in
-      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-         source drivers/atm/Config.in
-      fi
-  fi
-  endmenu
-fi
-
 source net/ax25/Config.in
 
 source net/irda/Config.in
--- a/arch/m68k/config.in	2003-07-31 01:45:36.000000000 +0200
+++ b/arch/m68k/config.in	2003-07-31 22:36:14.000000000 +0200
@@ -173,6 +173,93 @@ if [ "$CONFIG_NET" = "y" ]; then
    source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+
+   mainmenu_option next_comment
+   comment 'Network device support'
+
+   bool 'Network device support' CONFIG_NETDEVICES
+   if [ "$CONFIG_NETDEVICES" = "y" ]; then
+      #
+      # Network device configuration
+      #
+      tristate '  Dummy net driver support' CONFIG_DUMMY
+      tristate '  SLIP (serial line) support' CONFIG_SLIP
+      if [ "$CONFIG_SLIP" != "n" ]; then
+	 bool '    CSLIP compressed headers' CONFIG_SLIP_COMPRESSED
+	 bool '    Keepalive and linefill' CONFIG_SLIP_SMART
+	 bool '    Six bit SLIP encapsulation' CONFIG_SLIP_MODE_SLIP6
+      fi
+      tristate 'PPP (point-to-point protocol) support' CONFIG_PPP
+      if [ ! "$CONFIG_PPP" = "n" ]; then
+         dep_bool '  PPP multilink support (EXPERIMENTAL)' CONFIG_PPP_MULTILINK $CONFIG_EXPERIMENTAL
+         dep_bool '  PPP filtering' CONFIG_PPP_FILTER $CONFIG_FILTER
+         dep_tristate '  PPP support for async serial ports' CONFIG_PPP_ASYNC $CONFIG_PPP
+         dep_tristate '  PPP support for sync tty ports' CONFIG_PPP_SYNC_TTY $CONFIG_PPP
+         dep_tristate '  PPP Deflate compression' CONFIG_PPP_DEFLATE $CONFIG_PPP
+         dep_tristate '  PPP BSD-Compress compression' CONFIG_PPP_BSDCOMP $CONFIG_PPP
+         if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+             dep_tristate '  PPP over Ethernet (EXPERIMENTAL)' CONFIG_PPPOE $CONFIG_PPP
+         fi
+      fi
+      tristate '  EQL (serial line load balancing) support' CONFIG_EQUALIZER
+      if [ "$CONFIG_ZORRO" = "y" ]; then
+	 tristate '  Ariadne support' CONFIG_ARIADNE
+	 tristate '  Ariadne II support' CONFIG_ARIADNE2
+	 tristate '  A2065 support' CONFIG_A2065
+	 tristate '  Hydra support' CONFIG_HYDRA
+      fi
+      if [ "$CONFIG_AMIGA_PCMCIA" = "y" ]; then
+	 tristate '  PCMCIA NE2000 support' CONFIG_APNE
+      fi
+      if [ "$CONFIG_APOLLO" = "y" ]; then
+	 tristate '  Apollo 3c505 support' CONFIG_APOLLO_ELPLUS
+      fi
+      if [ "$CONFIG_MAC" = "y" ]; then
+	 bool '  Macintosh NS 8390 based ethernet cards' CONFIG_MAC8390
+	 tristate '  Macintosh SONIC based ethernet (onboard, NuBus, LC, CS)' CONFIG_MACSONIC
+	 tristate '  Macintosh SMC 9194 based ethernet cards' CONFIG_SMC9194
+	 tristate '  Macintosh CS89x0 based ethernet cards' CONFIG_MAC89x0
+	 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+		bool '  Macintosh (AV) onboard MACE ethernet (EXPERIMENTAL)' CONFIG_MACMACE
+	 fi
+      fi
+      if [ "$CONFIG_VME" = "y" -a "$CONFIG_MVME147" = "y" ]; then
+	 tristate '  MVME147 (Lance) Ethernet support' CONFIG_MVME147_NET
+      fi
+      if [ "$CONFIG_VME" = "y" -a "$CONFIG_MVME16x" = "y" ]; then
+	 tristate '  MVME16x Ethernet support' CONFIG_MVME16x_NET
+      fi
+      if [ "$CONFIG_VME" = "y" -a "$CONFIG_BVME6000" = "y" ]; then
+	 tristate '  BVME6000 Ethernet support' CONFIG_BVME6000_NET
+      fi
+      if [ "$CONFIG_ATARI" = "y" ]; then
+	 tristate '  Atari Lance support' CONFIG_ATARILANCE
+	 if [ "$CONFIG_ATARI_ACSI" != "n" ]; then
+	    tristate '  BioNet-100 support' CONFIG_ATARI_BIONET
+	    tristate '  PAMsNet support' CONFIG_ATARI_PAMSNET
+	 fi
+      fi
+      if [ "$CONFIG_SUN3" = "y" -o "$CONFIG_SUN3X" = "y" ]; then
+	tristate '  Sun3/Sun3x on-board LANCE support' CONFIG_SUN3LANCE
+      fi
+      if [ "$CONFIG_SUN3" = "y" ]; then
+	tristate '  Sun3 on-board Intel 82586 support' CONFIG_SUN3_82586
+      fi
+      if [ "$CONFIG_HP300" = "y" ]; then
+	 bool '  HP on-board LANCE support' CONFIG_HPLANCE
+      fi
+      if [ "$CONFIG_Q40" = "y" ]; then
+         if [  "$CONFIG_PARPORT" != "n" ]; then
+	    dep_tristate '  PLIP (parallel port) support' CONFIG_PLIP $CONFIG_PARPORT
+	 fi
+         dep_tristate 'NE2000/NE1000 support' CONFIG_NE2000 m
+      fi
+   fi
+   endmenu
+
+fi
+
 if [ "$CONFIG_MAC" = "y" ]; then
    source drivers/input/Config.in
 fi
@@ -288,93 +375,6 @@ if [ "$CONFIG_SCSI" != "n" ]; then
 fi
 endmenu
 
-if [ "$CONFIG_NET" = "y" ]; then
-
-   mainmenu_option next_comment
-   comment 'Network device support'
-
-   bool 'Network device support' CONFIG_NETDEVICES
-   if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      #
-      # Network device configuration
-      #
-      tristate '  Dummy net driver support' CONFIG_DUMMY
-      tristate '  SLIP (serial line) support' CONFIG_SLIP
-      if [ "$CONFIG_SLIP" != "n" ]; then
-	 bool '    CSLIP compressed headers' CONFIG_SLIP_COMPRESSED
-	 bool '    Keepalive and linefill' CONFIG_SLIP_SMART
-	 bool '    Six bit SLIP encapsulation' CONFIG_SLIP_MODE_SLIP6
-      fi
-      tristate 'PPP (point-to-point protocol) support' CONFIG_PPP
-      if [ ! "$CONFIG_PPP" = "n" ]; then
-         dep_bool '  PPP multilink support (EXPERIMENTAL)' CONFIG_PPP_MULTILINK $CONFIG_EXPERIMENTAL
-         dep_bool '  PPP filtering' CONFIG_PPP_FILTER $CONFIG_FILTER
-         dep_tristate '  PPP support for async serial ports' CONFIG_PPP_ASYNC $CONFIG_PPP
-         dep_tristate '  PPP support for sync tty ports' CONFIG_PPP_SYNC_TTY $CONFIG_PPP
-         dep_tristate '  PPP Deflate compression' CONFIG_PPP_DEFLATE $CONFIG_PPP
-         dep_tristate '  PPP BSD-Compress compression' CONFIG_PPP_BSDCOMP $CONFIG_PPP
-         if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-             dep_tristate '  PPP over Ethernet (EXPERIMENTAL)' CONFIG_PPPOE $CONFIG_PPP
-         fi
-      fi
-      tristate '  EQL (serial line load balancing) support' CONFIG_EQUALIZER
-      if [ "$CONFIG_ZORRO" = "y" ]; then
-	 tristate '  Ariadne support' CONFIG_ARIADNE
-	 tristate '  Ariadne II support' CONFIG_ARIADNE2
-	 tristate '  A2065 support' CONFIG_A2065
-	 tristate '  Hydra support' CONFIG_HYDRA
-      fi
-      if [ "$CONFIG_AMIGA_PCMCIA" = "y" ]; then
-	 tristate '  PCMCIA NE2000 support' CONFIG_APNE
-      fi
-      if [ "$CONFIG_APOLLO" = "y" ]; then
-	 tristate '  Apollo 3c505 support' CONFIG_APOLLO_ELPLUS
-      fi
-      if [ "$CONFIG_MAC" = "y" ]; then
-	 bool '  Macintosh NS 8390 based ethernet cards' CONFIG_MAC8390
-	 tristate '  Macintosh SONIC based ethernet (onboard, NuBus, LC, CS)' CONFIG_MACSONIC
-	 tristate '  Macintosh SMC 9194 based ethernet cards' CONFIG_SMC9194
-	 tristate '  Macintosh CS89x0 based ethernet cards' CONFIG_MAC89x0
-	 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-		bool '  Macintosh (AV) onboard MACE ethernet (EXPERIMENTAL)' CONFIG_MACMACE
-	 fi
-      fi
-      if [ "$CONFIG_VME" = "y" -a "$CONFIG_MVME147" = "y" ]; then
-	 tristate '  MVME147 (Lance) Ethernet support' CONFIG_MVME147_NET
-      fi
-      if [ "$CONFIG_VME" = "y" -a "$CONFIG_MVME16x" = "y" ]; then
-	 tristate '  MVME16x Ethernet support' CONFIG_MVME16x_NET
-      fi
-      if [ "$CONFIG_VME" = "y" -a "$CONFIG_BVME6000" = "y" ]; then
-	 tristate '  BVME6000 Ethernet support' CONFIG_BVME6000_NET
-      fi
-      if [ "$CONFIG_ATARI" = "y" ]; then
-	 tristate '  Atari Lance support' CONFIG_ATARILANCE
-	 if [ "$CONFIG_ATARI_ACSI" != "n" ]; then
-	    tristate '  BioNet-100 support' CONFIG_ATARI_BIONET
-	    tristate '  PAMsNet support' CONFIG_ATARI_PAMSNET
-	 fi
-      fi
-      if [ "$CONFIG_SUN3" = "y" -o "$CONFIG_SUN3X" = "y" ]; then
-	tristate '  Sun3/Sun3x on-board LANCE support' CONFIG_SUN3LANCE
-      fi
-      if [ "$CONFIG_SUN3" = "y" ]; then
-	tristate '  Sun3 on-board Intel 82586 support' CONFIG_SUN3_82586
-      fi
-      if [ "$CONFIG_HP300" = "y" ]; then
-	 bool '  HP on-board LANCE support' CONFIG_HPLANCE
-      fi
-      if [ "$CONFIG_Q40" = "y" ]; then
-         if [  "$CONFIG_PARPORT" != "n" ]; then
-	    dep_tristate '  PLIP (parallel port) support' CONFIG_PLIP $CONFIG_PARPORT
-	 fi
-         dep_tristate 'NE2000/NE1000 support' CONFIG_NE2000 m
-      fi
-   fi
-   endmenu
-
-fi
-
 mainmenu_option next_comment
 comment 'Character devices'
  
--- a/arch/mips/config-shared.in	2003-07-31 01:45:37.000000000 +0200
+++ b/arch/mips/config-shared.in	2003-07-31 22:37:10.000000000 +0200
@@ -650,6 +650,20 @@ if [ "$CONFIG_NET" = "y" ]; then
    source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Network device support'
+
+   bool 'Network device support' CONFIG_NETDEVICES
+   if [ "$CONFIG_NETDEVICES" = "y" ]; then
+      source drivers/net/Config.in
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+	 source drivers/atm/Config.in
+      fi
+   fi
+   endmenu
+fi
+
 source drivers/telephony/Config.in
 
 mainmenu_option next_comment
@@ -679,20 +693,6 @@ if [ "$CONFIG_PCI" = "y" ]; then
    source drivers/message/i2o/Config.in
 fi
 
-if [ "$CONFIG_NET" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Network device support'
-
-   bool 'Network device support' CONFIG_NETDEVICES
-   if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      source drivers/net/Config.in
-      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-	 source drivers/atm/Config.in
-      fi
-   fi
-   endmenu
-fi
-
 source net/ax25/Config.in
 
 source net/irda/Config.in
--- a/arch/parisc/config.in	2003-07-31 01:45:37.000000000 +0200
+++ b/arch/parisc/config.in	2003-07-31 22:38:27.000000000 +0200
@@ -103,6 +103,21 @@ if [ "$CONFIG_NET" = "y" ]; then
    source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Network device support'
+
+   bool 'Network device support' CONFIG_NETDEVICES
+
+   if [ "$CONFIG_NETDEVICES" = "y" ]; then
+      source drivers/net/Config.in
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+         source drivers/atm/Config.in
+      fi
+   fi
+   endmenu
+fi
+
 if [ "$CONFIG_SUPERIO" = "y" ]; then
     mainmenu_option next_comment
     comment 'ATA/IDE/MFM/RLL support'
@@ -128,21 +143,6 @@ if [ "$CONFIG_SCSI" != "n" ]; then
 fi
 endmenu
 
-if [ "$CONFIG_NET" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Network device support'
-
-   bool 'Network device support' CONFIG_NETDEVICES
-
-   if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      source drivers/net/Config.in
-      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-         source drivers/atm/Config.in
-      fi
-   fi
-   endmenu
-fi
-
 #
 # input before char - char/joystick depends on it. As does USB.
 #
--- a/arch/s390/config.in	2003-07-31 01:45:39.000000000 +0200
+++ b/arch/s390/config.in	2003-07-31 22:40:32.000000000 +0200
@@ -61,12 +61,12 @@ bool 'Pseudo page fault support' CONFIG_
 bool 'VM shared kernel support' CONFIG_SHARED_KERNEL
 endmenu
 
-source drivers/s390/Config.in
-
 if [ "$CONFIG_NET" = "y" ]; then
   source net/Config.in
 fi
 
+source drivers/s390/Config.in
+
 source fs/Config.in
 
 mainmenu_option next_comment
--- a/arch/s390x/config.in	2003-07-31 01:45:39.000000000 +0200
+++ b/arch/s390x/config.in	2003-07-31 22:40:52.000000000 +0200
@@ -64,13 +64,12 @@ bool 'Pseudo page fault support' CONFIG_
 bool 'VM shared kernel support' CONFIG_SHARED_KERNEL
 endmenu
 
-
-source drivers/s390/Config.in
-
 if [ "$CONFIG_NET" = "y" ]; then
   source net/Config.in
 fi
 
+source drivers/s390/Config.in
+
 source fs/Config.in
 
 mainmenu_option next_comment
--- a/arch/sh64/config.in	2003-07-31 01:45:39.000000000 +0200
+++ b/arch/sh64/config.in	2003-07-31 22:41:34.000000000 +0200
@@ -165,6 +165,20 @@ if [ "$CONFIG_NET" = "y" ]; then
    source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Network device support'
+
+   bool 'Network device support' CONFIG_NETDEVICES
+   if [ "$CONFIG_NETDEVICES" = "y" ]; then
+      source drivers/net/Config.in
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+         source drivers/atm/Config.in
+      fi
+   fi
+   endmenu
+fi
+
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
@@ -191,20 +205,6 @@ endmenu
 
 # source drivers/ieee1394/Config.in
 
-if [ "$CONFIG_NET" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Network device support'
-
-   bool 'Network device support' CONFIG_NETDEVICES
-   if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      source drivers/net/Config.in
-      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-         source drivers/atm/Config.in
-      fi
-   fi
-   endmenu
-fi
-
 #
 # input before char - char/joystick depends on it. As does USB.
 #
--- a/arch/sparc/config.in	2003-07-31 01:45:39.000000000 +0200
+++ b/arch/sparc/config.in	2003-07-31 22:42:03.000000000 +0200
@@ -111,6 +111,61 @@ if [ "$CONFIG_NET" = "y" ]; then
    source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Network device support'
+
+   bool 'Network device support' CONFIG_NETDEVICES
+   if [ "$CONFIG_NETDEVICES" = "y" ]; then
+      tristate '  Dummy net driver support' CONFIG_DUMMY
+      tristate '  Bonding driver support' CONFIG_BONDING
+      tristate '  Universal TUN/TAP device driver support' CONFIG_TUN
+      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+        if [ "$CONFIG_NETLINK" = "y" ]; then
+          tristate '  Ethertap network tap (OBSOLETE)' CONFIG_ETHERTAP
+        fi
+      fi
+      tristate '  PPP (point-to-point protocol) support' CONFIG_PPP
+      if [ ! "$CONFIG_PPP" = "n" ]; then
+        dep_tristate '  PPP support for async serial ports' CONFIG_PPP_ASYNC $CONFIG_PPP
+        dep_tristate '  PPP support for sync tty ports' CONFIG_PPP_SYNC_TTY $CONFIG_PPP
+        dep_tristate '  PPP Deflate compression' CONFIG_PPP_DEFLATE $CONFIG_PPP
+        dep_tristate '  PPP BSD-Compress compression' CONFIG_PPP_BSDCOMP m
+	if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+	  dep_tristate '  PPP over Ethernet (EXPERIMENTAL)' CONFIG_PPPOE $CONFIG_PPP
+	  if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+	    dep_tristate '  PPP over ATM (EXPERIMENTAL)' CONFIG_PPPOATM $CONFIG_PPP $CONFIG_ATM
+	  fi
+	fi
+      fi
+      tristate '  SLIP (serial line) support' CONFIG_SLIP
+      if [ "$CONFIG_SLIP" != "n" ]; then
+	 bool '    CSLIP compressed headers' CONFIG_SLIP_COMPRESSED
+	 bool '    Keepalive and linefill' CONFIG_SLIP_SMART
+	 bool '    Six bit SLIP encapsulation' CONFIG_SLIP_MODE_SLIP6
+      fi
+      tristate '  Sun LANCE support' CONFIG_SUNLANCE
+      tristate '  Sun Happy Meal 10/100baseT support' CONFIG_HAPPYMEAL
+      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+	 tristate '  Sun BigMAC 10/100baseT support (EXPERIMENTAL)' CONFIG_SUNBMAC
+      fi
+      tristate '  Sun QuadEthernet support' CONFIG_SUNQE
+      tristate '  MyriCOM Gigabit Ethernet support' CONFIG_MYRI_SBUS
+      if [ "$CONFIG_PCI" = "y" ]; then
+         tristate '3c590/3c900 series (592/595/597) "Vortex/Boomerang" support' CONFIG_VORTEX
+      fi
+
+#      bool '  FDDI driver support' CONFIG_FDDI
+#      if [ "$CONFIG_FDDI" = "y" ]; then
+#      fi
+
+      if [ "$CONFIG_ATM" != "n" ]; then
+	 source drivers/atm/Config.in
+      fi
+   fi
+   endmenu
+fi
+
 # Don't frighten a common SBus user
 if [ "$CONFIG_PCI" = "y" ]; then
 
@@ -187,61 +242,6 @@ endmenu
 
 source drivers/fc4/Config.in
 
-if [ "$CONFIG_NET" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Network device support'
-
-   bool 'Network device support' CONFIG_NETDEVICES
-   if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      tristate '  Dummy net driver support' CONFIG_DUMMY
-      tristate '  Bonding driver support' CONFIG_BONDING
-      tristate '  Universal TUN/TAP device driver support' CONFIG_TUN
-      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-        if [ "$CONFIG_NETLINK" = "y" ]; then
-          tristate '  Ethertap network tap (OBSOLETE)' CONFIG_ETHERTAP
-        fi
-      fi
-      tristate '  PPP (point-to-point protocol) support' CONFIG_PPP
-      if [ ! "$CONFIG_PPP" = "n" ]; then
-        dep_tristate '  PPP support for async serial ports' CONFIG_PPP_ASYNC $CONFIG_PPP
-        dep_tristate '  PPP support for sync tty ports' CONFIG_PPP_SYNC_TTY $CONFIG_PPP
-        dep_tristate '  PPP Deflate compression' CONFIG_PPP_DEFLATE $CONFIG_PPP
-        dep_tristate '  PPP BSD-Compress compression' CONFIG_PPP_BSDCOMP m
-	if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	  dep_tristate '  PPP over Ethernet (EXPERIMENTAL)' CONFIG_PPPOE $CONFIG_PPP
-	  if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-	    dep_tristate '  PPP over ATM (EXPERIMENTAL)' CONFIG_PPPOATM $CONFIG_PPP $CONFIG_ATM
-	  fi
-	fi
-      fi
-      tristate '  SLIP (serial line) support' CONFIG_SLIP
-      if [ "$CONFIG_SLIP" != "n" ]; then
-	 bool '    CSLIP compressed headers' CONFIG_SLIP_COMPRESSED
-	 bool '    Keepalive and linefill' CONFIG_SLIP_SMART
-	 bool '    Six bit SLIP encapsulation' CONFIG_SLIP_MODE_SLIP6
-      fi
-      tristate '  Sun LANCE support' CONFIG_SUNLANCE
-      tristate '  Sun Happy Meal 10/100baseT support' CONFIG_HAPPYMEAL
-      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	 tristate '  Sun BigMAC 10/100baseT support (EXPERIMENTAL)' CONFIG_SUNBMAC
-      fi
-      tristate '  Sun QuadEthernet support' CONFIG_SUNQE
-      tristate '  MyriCOM Gigabit Ethernet support' CONFIG_MYRI_SBUS
-      if [ "$CONFIG_PCI" = "y" ]; then
-         tristate '3c590/3c900 series (592/595/597) "Vortex/Boomerang" support' CONFIG_VORTEX
-      fi
-
-#      bool '  FDDI driver support' CONFIG_FDDI
-#      if [ "$CONFIG_FDDI" = "y" ]; then
-#      fi
-
-      if [ "$CONFIG_ATM" != "n" ]; then
-	 source drivers/atm/Config.in
-      fi
-   fi
-   endmenu
-fi
-
 # This one must be before the filesystem configs. -DaveM
 mainmenu_option next_comment
 comment 'Unix98 PTY support'
--- a/arch/sparc64/config.in	2003-07-31 01:45:39.000000000 +0200
+++ b/arch/sparc64/config.in	2003-07-31 22:42:26.000000000 +0200
@@ -119,6 +119,20 @@ if [ "$CONFIG_NET" = "y" ]; then
    source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Network device support'
+
+   bool 'Network device support' CONFIG_NETDEVICES
+   if [ "$CONFIG_NETDEVICES" = "y" ]; then
+      source drivers/net/Config.in
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+	source drivers/atm/Config.in
+      fi
+   fi
+   endmenu
+fi
+
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
@@ -227,20 +241,6 @@ fi
 
 source drivers/ieee1394/Config.in
 
-if [ "$CONFIG_NET" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Network device support'
-
-   bool 'Network device support' CONFIG_NETDEVICES
-   if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      source drivers/net/Config.in
-      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-	source drivers/atm/Config.in
-      fi
-   fi
-   endmenu
-fi
-
 # This one must be before the filesystem configs. -DaveM
 mainmenu_option next_comment
 comment 'Unix 98 PTY support'
--- a/arch/x86_64/config.in	2003-07-31 01:45:40.000000000 +0200
+++ b/arch/x86_64/config.in	2003-07-31 22:42:52.000000000 +0200
@@ -128,6 +128,21 @@ if [ "$CONFIG_NET" = "y" ]; then
    source net/Config.in
 fi
 
+if [ "$CONFIG_NET" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Network device support'
+
+   bool 'Network device support' CONFIG_NETDEVICES
+   if [ "$CONFIG_NETDEVICES" = "y" ]; then
+      source drivers/net/Config.in
+# seems to be largely not 64bit safe	   
+#      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+#         source drivers/atm/Config.in
+#      fi
+   fi
+   endmenu
+fi
+
 source drivers/telephony/Config.in
 
 mainmenu_option next_comment
@@ -160,21 +175,6 @@ source drivers/ieee1394/Config.in
 #Currently not 64bit safe
 #source drivers/message/i2o/Config.in
 
-if [ "$CONFIG_NET" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Network device support'
-
-   bool 'Network device support' CONFIG_NETDEVICES
-   if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      source drivers/net/Config.in
-# seems to be largely not 64bit safe	   
-#      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
-#         source drivers/atm/Config.in
-#      fi
-   fi
-   endmenu
-fi
-
 source net/ax25/Config.in
 
 source net/irda/Config.in

--Boundary-00=_GOkK/yr4hicDvDe--


