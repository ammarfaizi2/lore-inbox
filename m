Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262998AbSJBIBF>; Wed, 2 Oct 2002 04:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262999AbSJBIBF>; Wed, 2 Oct 2002 04:01:05 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:28855 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262998AbSJBIBC>; Wed, 2 Oct 2002 04:01:02 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA 'make menuconfig exits' fix
Date: Wed, 2 Oct 2002 10:06:09 +0200
User-Agent: KMail/1.4.3
Cc: Michael Knigge <Michael.Knigge@set-software.de>,
       Nicolas Bouliane <linuxaide.net@rocler.com>,
       Andreas Boman <aboman@nerdfest.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_96HC8F87TRZH81F3WU4X"
Message-Id: <200210021006.09568.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_96HC8F87TRZH81F3WU4X
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

attached patch fixes "make menuconfig" crashes when entering Sound/ALSA.

Dunno if it is the correct way but it works. Consider this as a workaroun=
d.

--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
--------------Boundary-00=_96HC8F87TRZH81F3WU4X
Content-Type: text/x-diff;
  charset="us-ascii";
  name="72_fix-alsasoundsparc32-64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="72_fix-alsasoundsparc32-64.patch"

--- linux/sound/Config.in	2002-10-01 12:09:44.000000000 +0200
+++ linux/sound/Config.in	2002-10-01 12:21:05.000000000 +0200
@@ -31,10 +31,7 @@
 if [ "$CONFIG_SND" != "n" -a "$CONFIG_ARM" = "y" ]; then
   source sound/arm/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ]; then
-  source sound/sparc/Config.in
-fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ] || [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ] ; then
   source sound/sparc/Config.in
 fi
 

--------------Boundary-00=_96HC8F87TRZH81F3WU4X--

