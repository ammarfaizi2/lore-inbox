Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSFEJl3>; Wed, 5 Jun 2002 05:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSFEJl2>; Wed, 5 Jun 2002 05:41:28 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:41095 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314085AbSFEJl1>; Wed, 5 Jun 2002 05:41:27 -0400
Subject: Capi config Patch for 2.4.20-dj2
From: Carsten Rietzschel <cr@daRav.de>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-D/v0wRkJ7QocgT1QxqhT"
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Jun 2002 11:40:44 +0200
Message-Id: <1023270045.1552.6.camel@rav-pc-linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D/v0wRkJ7QocgT1QxqhT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

this fixes the problem when configuring the ISDN-Section f.e. with make menuconfig.
So Capi can be enabled and can be compiled.
Without this patch 2.5.20-dj2 (and a few -dj-Patches before) won't compile Capi-Drivers.

(Note: I don't know why DJ dropped these lines, but in the 2.4.20 they are)


This patch is against 2.5.20-dj2 


Carsten Rietzschel




--=-D/v0wRkJ7QocgT1QxqhT
Content-Disposition: attachment; filename=cr-capi-config-patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=cr-capi-config-patch; charset=ISO-8859-15

--- drivers/isdn/Config.in	Tue Jun  4 23:31:51 2002
+++ drivers/isdn/Config.in.org2	Mon Jun  3 03:44:50 2002
@@ -19,8 +19,11 @@
=20
       comment 'CAPI subsystem'
=20
-      source drivers/isdn/capi/Config.in
-      source drivers/isdn/hardware/Config.in
+      tristate 'CAPI2.0 support' CONFIG_ISDN_CAPI
+      if [ "$CONFIG_ISDN_CAPI" !=3D "n" ]; then
+         source drivers/isdn/capi/Config.in
+         source drivers/isdn/hardware/Config.in
+      fi
    fi
 fi
 endmenu

--=-D/v0wRkJ7QocgT1QxqhT--

