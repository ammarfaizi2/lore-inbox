Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbUDFPsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263877AbUDFPsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:48:24 -0400
Received: from galileo.bork.org ([66.11.174.156]:46228 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S263876AbUDFPsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:48:17 -0400
Date: Tue, 6 Apr 2004 11:48:15 -0400
From: Martin Hicks <mort@bork.org>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] saa7134 - Add two inputs for Asus TV FM
Message-ID: <20040406154815.GC17476@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

I just bought an ASUS TV FM capture card, based on the saa7134
chip.  It only had one input specified, coax.  This patch adds the
Composite and S-Video inputs.  It seems to work correctly for me.

The patch is against 2.6.5.

thanks
mh

-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="saa7134-asus-tv-fm-inputs.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/06 10:19:41-04:00 mort@descartes.i.bork.org 
#   Add support for the composite and svideo ports on
#   the ASUS TV FM card (7133).
# 
# drivers/media/video/saa7134/saa7134-cards.c
#   2004/04/06 10:19:37-04:00 mort@descartes.i.bork.org +8 -0
#   Add support for the composite and svideo ports on
#   the ASUS TV FM card (7133).
# 
diff -Nru a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
--- a/drivers/media/video/saa7134/saa7134-cards.c	Tue Apr  6 10:20:35 2004
+++ b/drivers/media/video/saa7134/saa7134-cards.c	Tue Apr  6 10:20:35 2004
@@ -739,6 +739,14 @@
                         .vmux = 1,
                         .amux = TV,
                         .tv   = 1,
+		},{
+                        .name = name_comp1,
+                        .vmux = 4,
+                        .amux = LINE2,
+                },{
+                        .name = name_svideo,
+                        .vmux = 6,
+                        .amux = LINE2,
                 }},
                 .radio = {
                         .name = name_radio,

--UlVJffcvxoiEqYs2--
