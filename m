Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSCCOIZ>; Sun, 3 Mar 2002 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286263AbSCCOIP>; Sun, 3 Mar 2002 09:08:15 -0500
Received: from ppp-213-1.28-151.libero.it ([151.28.1.213]:5124 "HELO
	gateway.milesteg.arr") by vger.kernel.org with SMTP
	id <S286161AbSCCOIH>; Sun, 3 Mar 2002 09:08:07 -0500
Date: Sun, 3 Mar 2002 15:07:58 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Small fix for AGP Config.in
Message-ID: <20020303140758.GA1930@renditai.milesteg.arr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Support for agp in chipsets i820 and i830mp was added to 2.4.18, but
drivers/char/Config.in was not updated. This patch fixes that. It was
made against 2.4.18.

This patch is also available from:
http://digilander.iol.it/webvenza/kernel_patches.html

There is no maintainer for AGP in MAINTAINERS file, so I send it directly to
you, Marcelo.

Bye.
-- 
-----------------------------------------------------
Daniele Venzano
Senior member of the Linux User Group Genova (LUGGe)
E-Mail: venza@iol.it
Web: http://digilander.iol.it/webvenza/
LUGGe: http://lugge.ziobudda.net


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_fix_agp_config_in

diff -urN -X /home/venza/kernel/dontdiff linux-2.4.18-gat/drivers/char/Config.in linux-2.4.18/drivers/char/Config.in
--- linux-2.4.18-gat/drivers/char/Config.in	Sat Mar  2 19:52:50 2002
+++ linux-2.4.18/drivers/char/Config.in	Sat Mar  2 20:08:25 2002
@@ -210,7 +210,7 @@
 
 dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I830M/I840/I850 support' CONFIG_AGP_INTEL
+   bool '  Intel 440LX/BX/GX and I815/I820/I830M/I830MP/I840/I845/I850/I860 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815/I830M (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD

--bp/iNruPH9dso1Pn--
