Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSLPI2y>; Mon, 16 Dec 2002 03:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSLPI2y>; Mon, 16 Dec 2002 03:28:54 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:52024
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265689AbSLPI2x>; Mon, 16 Dec 2002 03:28:53 -0500
Date: Mon, 16 Dec 2002 03:25:31 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Adam Belay <ambx1@neo.rr.com>
Subject: [patch][2.5] ISAPNP helper macros
Message-ID: <Pine.LNX.4.50.0212160323310.12535-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Don't think there is anything wrong with keeping these in, and they
simplify in the conversion process.

Index: linux-2.5.51/include/linux/pnp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/include/linux/pnp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pnp.h
--- linux-2.5.51/include/linux/pnp.h	10 Dec 2002 12:47:35 -0000	1.1.1.1
+++ linux-2.5.51/include/linux/pnp.h	11 Dec 2002 23:12:06 -0000
@@ -23,6 +23,16 @@
 #define DEVICE_COUNT_RESOURCE	12
 #define MAX_DEVICES		8

+#define ISAPNP_ANY_ID		0xffff
+#define ISAPNP_VENDOR(a,b,c)	(((((a)-'A'+1)&0x3f)<<2)|\
+				((((b)-'A'+1)&0x18)>>3)|((((b)-'A'+1)&7)<<13)|\
+				((((c)-'A'+1)&0x1f)<<8))
+#define ISAPNP_DEVICE(x)	((((x)&0xf000)>>8)|\
+				 (((x)&0x0f00)>>8)|\
+				 (((x)&0x00f0)<<8)|\
+				 (((x)&0x000f)<<8))
+#define ISAPNP_FUNCTION(x)	ISAPNP_DEVICE(x)
+
 struct pnp_resource;
 struct pnp_protocol;
 struct pnp_id;

-- 
function.linuxpower.ca
