Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267593AbSLMBgF>; Thu, 12 Dec 2002 20:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267589AbSLMBeS>; Thu, 12 Dec 2002 20:34:18 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:23758
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267584AbSLMBcv>; Thu, 12 Dec 2002 20:32:51 -0500
Date: Thu, 12 Dec 2002 20:43:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH][2.5] Resurrect some ISAPNP macros
Message-ID: <Pine.LNX.4.50.0212121158400.23467-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,
	I think these macros are worth having around, they come in handy
whilst converting drivers.

Cheers,
	Zwane

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
