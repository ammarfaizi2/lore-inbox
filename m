Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263114AbUJ1W1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbUJ1W1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbUJ1WTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:19:02 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3343 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263100AbUJ1WR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:17:59 -0400
Date: Fri, 29 Oct 2004 00:17:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DVB av7110_hw.c: remove unused functions
Message-ID: <20041028221727.GM3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes three unused functions from 
drivers/media/dvb/ttpci/av7110_hw.c


diffstat output:
 drivers/media/dvb/ttpci/av7110_hw.c |   15 ---------------
 1 files changed, 15 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/media/dvb/ttpci/av7110_hw.c.old	2004-10-28 23:04:59.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/media/dvb/ttpci/av7110_hw.c	2004-10-28 23:05:26.000000000 +0200
@@ -577,21 +577,11 @@
 
 #ifdef CONFIG_DVB_AV7110_OSD
 
- -static inline int ResetBlend(struct av7110 *av7110, u8 windownr)
- -{
- -	return av7110_fw_cmd(av7110, COMTYPE_OSD, SetNonBlend, 1, windownr);
- -}
- -
 static inline int SetColorBlend(struct av7110 *av7110, u8 windownr)
 {
 	return av7110_fw_cmd(av7110, COMTYPE_OSD, SetCBlend, 1, windownr);
 }
 
- -static inline int SetWindowBlend(struct av7110 *av7110, u8 windownr, u8 blending)
- -{
- -	return av7110_fw_cmd(av7110, COMTYPE_OSD, SetWBlend, 2, windownr, blending);
- -}
- -
 static inline int SetBlend_(struct av7110 *av7110, u8 windownr,
 		     enum av7110_osd_palette_type colordepth, u16 index, u8 blending)
 {
@@ -606,11 +596,6 @@
 			     windownr, colordepth, index, colorhi, colorlo);
 }
 
- -static inline int BringToTop(struct av7110 *av7110, u8 windownr)
- -{
- -	return av7110_fw_cmd(av7110, COMTYPE_OSD, WTop, 1, windownr);
- -}
- -
 static inline int SetFont(struct av7110 *av7110, u8 windownr, u8 fontsize,
 			  u16 colorfg, u16 colorbg)
 {

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgW/3mfzqmE8StAARAnceAJ9rnRwLZOg3tqGApjFlHYj72FyoTgCgg6xW
Yb196gzbnH23HC8AJJM03r8=
=CYK5
-----END PGP SIGNATURE-----
