Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314241AbSFEJqE>; Wed, 5 Jun 2002 05:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSFEJqD>; Wed, 5 Jun 2002 05:46:03 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:40590 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314241AbSFEJqC>; Wed, 5 Jun 2002 05:46:02 -0400
Subject: SiS 7012 config Patch for 2.4.20-dj2
From: Carsten Rietzschel <cr@daRav.de>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-HwZXd6ClVahHU0Ort8Ho"
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Jun 2002 11:45:19 +0200
Message-Id: <1023270320.1541.12.camel@rav-pc-linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HwZXd6ClVahHU0Ort8Ho
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi again,


this patch changes a few lines in config.in/config.help.
So it should be easier to find support for SiS7012 onboard sound,
which is mainly build on SiS735/745 mainboards.

BIG NOTE:
This patch NEEDS the patch for i8x0 sound chipset driver, which isn't included in the 
vanilla kernel,
but it is included in the 2.5.20-dj2 patch set.


This patch is against 2.5.20-dj2 


Carsten Rietzschel




--=-HwZXd6ClVahHU0Ort8Ho
Content-Disposition: attachment; filename=cr-sis7012-config-patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=cr-sis7012-config-patch; charset=ISO-8859-15

--- sound/pci/Config.in.org	Mon Jun  3 03:44:47 2002
+++ sound/pci/Config.in	Wed Jun  5 11:04:14 2002
@@ -25,7 +25,7 @@
 dep_tristate 'ESS Allegro/Maestro3' CONFIG_SND_MAESTRO3 $CONFIG_SND
 dep_tristate 'ForteMedia FM801' CONFIG_SND_FM801 $CONFIG_SND
 dep_tristate 'ICEnsemble ICE1712 (Envy24)' CONFIG_SND_ICE1712 $CONFIG_SND
-dep_tristate 'Intel i810/i820/i830/i840/MX440 integrated audio' CONFIG_SND=
_INTEL8X0 $CONFIG_SND
+dep_tristate 'Intel i810/i820/i830/i840/MX440 and SiS 7012 (SiS 735/735) i=
ntegrated audio' CONFIG_SND_INTEL8X0 $CONFIG_SND
 dep_tristate 'S3 SonicVibes' CONFIG_SND_SONICVIBES $CONFIG_SND
 dep_tristate 'VIA 82C686A/B South Bridge' CONFIG_SND_VIA686 $CONFIG_SND
 dep_tristate 'VIA 8233 South Bridge' CONFIG_SND_VIA8233 $CONFIG_SND
--- sound/pci/Config.help.org	Mon Jun  3 03:44:44 2002
+++ sound/pci/Config.help	Wed Jun  5 11:03:28 2002
@@ -67,7 +67,7 @@
   Say 'Y' or 'M' to include support for ICE1712 (Envy24) based soundcards.
=20
 CONFIG_SND_INTEL8X0
-  Say 'Y' or 'M' to include support for Intel8x0 based soundcards.
+  Say 'Y' or 'M' to include support for Intel8x0 and SiS7012 (build often =
SiS735/745 boards) based soundcards.
=20
 CONFIG_SND_SONICVIBES
   Say 'Y' or 'M' to include support for S3 SonicVibes based soundcards.

--=-HwZXd6ClVahHU0Ort8Ho--

