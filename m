Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQKHGbT>; Wed, 8 Nov 2000 01:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKHGbJ>; Wed, 8 Nov 2000 01:31:09 -0500
Received: from adsl-61-8-131.mia.bellsouth.net ([208.61.8.131]:19208 "EHLO
	spawn.hockeyfiend.com") by vger.kernel.org with ESMTP
	id <S129043AbQKHGa6>; Wed, 8 Nov 2000 01:30:58 -0500
Date: Wed, 8 Nov 2000 01:30:51 -0500 (EST)
From: "Christopher C. Chimelis" <chris@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Small patches to Configure.help for Alpha
Message-ID: <Pine.LNX.4.21.0011080029360.9851-100000@spawn.hockeyfiend.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rich Payne (API) and I have made a patch for Documentation/Configure.help
to add some more systems to the list of Alphas.  Since the original list
was compiled, some of the newer system types were added, but not
all.  Also, the list wasn't as inclusive as it should've been (we've been
getting emails saying "which type of system is xxx?").  It also changes
some information regarding SRM, etc, to modernise it a bit.  Multias are
no longer the majority of Alphas out there ;-)

At any rate, this patch is against 2.4.0-test11-pre1.  I'll send a
similar patch for Alan against the 2.2.18pre series.

Thanks!
C

--- linux/Documentation/Configure.help.orig	Wed Nov  8 00:28:19 2000
+++ linux/Documentation/Configure.help	Wed Nov  8 00:28:26 2000
@@ -2098,34 +2098,39 @@
   check out the Linux/Alpha FAQ, accessible on the WWW from
   http://www.alphalinux.org . In summary:
 
-  Alcor/Alpha-XLT     AS 600
+  Alcor/Alpha-XLT     AS 600, XL-300, XL-366
   Alpha-XL            XL-233, XL-266
   AlphaBook1          Alpha laptop
   Avanti              AS 200, AS 205, AS 250, AS 255, AS 300, AS 400
   Cabriolet           AlphaPC64, AlphaPCI64
-  DP264               DP264
+  DP264               DP264, DS10(L)/20(E)/ES40, UP2000(+),
+                        XP900/1000, CS20
   EB164               EB164 21164 evaluation board
   EB64+               EB64+ 21064 evaluation board
   EB66                EB66 21066 evaluation board
   EB66+               EB66+ 21066 evaluation board
+  Eiger               SMARTEngine SBC models
   Jensen              DECpc 150, DEC 2000 model 300, 
-                      DEC 2000 model 500
+                        DEC 2000 model 500
   LX164               AlphaPC164-LX
   Miata               Personal Workstation 433a, 433au, 500a,
-                      500au, 600a, or 600au
+                        500au, 600a, or 600au
   Mikasa              AS 1000
+  Nautilus            UP1000/1100
   Noname              AXPpci33, UDB (Multia)
   Noritake            AS 1000A, AS 600A, AS 800
   PC164               AlphaPC164
+  Platform2000        Platform2000
   Rawhide             AS 1200, AS 4000, AS 4100
-  Ruffian             RPX164-2, AlphaPC164-UX, AlphaPC164-BX
+  Ruffian             AlphaPC164-UX, AlphaPC164-BX
   SX164               AlphaPC164-SX
   Sable               AS 2000, AS 2100
   Takara              Takara
   Titan               Privateer
   Wildfire            AlphaServer GS 40/80/160/320
 
-  If you don't know what to do, choose "generic".
+  Choosing "generic" is the preferred selection, but if you
+  know your system type, you can choose one of the above.
 
 EV5 CPU daughtercard
 CONFIG_ALPHA_PRIMO
@@ -2138,21 +2143,22 @@
 Using SRM as bootloader
 CONFIG_ALPHA_SRM
   There are two different types of booting firmware on Alphas: SRM,
-  which is command line driven, and ARC, which uses menus and arrow
-  keys. Details about the Linux/Alpha booting process are contained in
-  the Linux/Alpha FAQ, accessible on the WWW from
+  which is command line driven, and ARC/AlphaBIOS, which uses menus
+  and arrow keys. Details about the Linux/Alpha booting process
+  are contained in the Linux/Alpha FAQ, accessible on the WWW from
   http://www.alphalinux.org .
 
-  The usual way to load Linux on an Alpha machine is to use MILO
-  (a bootloader that lets you pass command line parameters to the
-  kernel just like lilo does for the x86 architecture) which can be
-  loaded either from ARC or can be installed directly as a permanent
-  firmware replacement from floppy (which requires changing a certain
-  jumper on the motherboard). If you want to do either of these, say N
-  here. If MILO doesn't work on your system (true for Jensen
-  motherboards), you can bypass it altogether and boot Linux directly
-  from an SRM console; say Y here in order to do that. Note that you
-  won't be able to boot from an IDE disk using SRM. 
+  The usual way to load Linux on an Alpha machine is to use the
+  SRM console, the same firmware used for loading Tru64 Unix and
+  OpenVMS. The other option being ARC/AlphaBios and MILO (a
+  bootloader that lets you pass command line parameters to the
+  kernel just like lilo does for the x86 architecture) For more
+  information on MILO please refer to the MILO Howto on the WWW
+  from http://www.alphalinux.org
+
+  If you want to boot via MILO, say N here. If MILO doesn't work on 
+  your system (for example the Jensen, DP264, and Nautilus systems), 
+  you must boot from SRM console; say Y here in order to do that.
 
   If unsure, say N.
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
