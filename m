Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312991AbSEUWrz>; Tue, 21 May 2002 18:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316761AbSEUWry>; Tue, 21 May 2002 18:47:54 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:16821 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312991AbSEUWry>; Tue, 21 May 2002 18:47:54 -0400
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-pre8 - HP ZX1 AGP support wrong for config
Date: Wed, 22 May 2002 00:46:29 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
MIME-Version: 1.0
Message-Id: <200205220031.34553.mcp@linux-systeme.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_HLGHKYWFGSJ9W5DLI1H1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_HLGHKYWFGSJ9W5DLI1H1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

attached is a patch for 2.4.19-pre8 which fixes Config.in
entry for "HP ZX1 AGP Support".
This is also shown in arches !=3D ia64, but this is wrong.

Attached patch fixes it and applies clean ontop 2.4.19-pre8.

This is also CC'ed to Marcello. Please apply it!

If this was reported before, i don't get it.


--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661  2B0B 408B 2D54 9477 50EC
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.


--------------Boundary-00=_HLGHKYWFGSJ9W5DLI1H1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="HP.ZX1.AGP.support-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="HP.ZX1.AGP.support-fix.patch"

--- linux/drivers/char/Config.in.orig	Tue May  7 21:00:09 2002
+++ linux/drivers/char/Config.in	Tue May 22 00:21:23 2002
@@ -260,7 +260,9 @@
    bool '  Generic SiS support' CONFIG_AGP_SIS
    bool '  ALI chipset support' CONFIG_AGP_ALI
    bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
-   dep_bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1 $CONFIG_IA64
+   if [ "$CONFIG_IA64" = "y" ]; then
+     bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1
+   fi
 fi
 
 bool 'Direct Rendering Manager (XFree86 DRI support)' CONFIG_DRM

--------------Boundary-00=_HLGHKYWFGSJ9W5DLI1H1--


