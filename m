Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268384AbTCCFcL>; Mon, 3 Mar 2003 00:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268386AbTCCFcK>; Mon, 3 Mar 2003 00:32:10 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:1289 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S268384AbTCCFcJ>;
	Mon, 3 Mar 2003 00:32:09 -0500
Date: Mon, 3 Mar 2003 05:42:35 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: [PATCH] Another bitop on boolean in pnpbios
Message-ID: <20030303054235.GA58427@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18piih-000B8I-00*b.S4JuO6xcg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First obvious case from -Wbitop-boolean

Not tested ...

regards,
john


--- linux-linus/include/linux/pnpbios.h	2003-01-13 22:43:41.000000000 +0000
+++ linux/include/linux/pnpbios.h	2003-03-03 05:46:42.000000000 +0000
@@ -86,7 +86,7 @@
 #define PNPBIOS_DOCK			0x0020
 #define PNPBIOS_REMOVABLE		0x0040
 #define pnpbios_is_static(x) ((x)->flags & 0x0100) == 0x0000
-#define pnpbios_is_dynamic(x) (x)->flags & 0x0080
+#define pnpbios_is_dynamic(x) ((x)->flags & 0x0080)
 
 /* 0x8000 through 0xffff are OEM defined */
 
