Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSHFXAS>; Tue, 6 Aug 2002 19:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSHFXAR>; Tue, 6 Aug 2002 19:00:17 -0400
Received: from p0001.as-l043.contactel.cz ([194.108.242.1]:13813 "EHLO
	SnowWhite.SuSE.cz") by vger.kernel.org with ESMTP
	id <S316544AbSHFXAR> convert rfc822-to-8bit; Tue, 6 Aug 2002 19:00:17 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Intel EtherExpress 16 can use 0x240 too
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Tue, 06 Aug 2002 23:40:26 +0200
Message-ID: <m3wur3hdit.fsf@Janik.cz>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please apply this patch. It helped my customer to reuse those old cards (we
have about 500 pcs of it in various client systems).

diff -urN linux.orig/drivers/net/eexpress.c linux/drivers/net/eexpress.c
--- linux.orig/drivers/net/eexpress.c	Tue Aug  6 23:23:27 2002
+++ linux/drivers/net/eexpress.c	Tue Aug  6 23:24:19 2002
@@ -341,7 +341,7 @@
 int __init express_probe(struct net_device *dev)
 {
 	unsigned short *port;
-	static unsigned short ports[] = { 0x300,0x310,0x270,0x320,0x340,0 };
+	static unsigned short ports[] = { 0x240,0x300,0x310,0x270,0x320,0x340,0 };
 	unsigned short ioaddr = dev->base_addr;
 
 	SET_MODULE_OWNER(dev);
-- 
Pavel Janík

640 K ought be enough.
                  -- Bill Gates, 1984
