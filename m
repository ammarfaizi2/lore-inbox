Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265962AbRGOIys>; Sun, 15 Jul 2001 04:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265972AbRGOIyi>; Sun, 15 Jul 2001 04:54:38 -0400
Received: from beasley.gator.com ([63.197.87.202]:57354 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S265962AbRGOIyV>; Sun, 15 Jul 2001 04:54:21 -0400
From: "George Bonser" <george@gator.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Linux default IP ttl
Date: Sun, 15 Jul 2001 01:58:51 -0700
Message-ID: <CHEKKPICCNOGICGMDODJIEEIDKAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch changes the default ip_default_ttl from 64 to 128 hops.
This matches the
default of many modern client OS of my server farms and the logic is that
anything that
capable of reaching me should also be reachable by me.

This has reduced considerably the number of ICMP messages where a packet has
expired
in transit from my server farms. Looks like there are a lot of clients out
there running
(apparently) modern Microsoft OS versions with networks having a lot of hops
(more than 64).

--- linux/include/linux/ip.h.orig	Sun Jul 15 08:41:07 2001
+++ linux/include/linux/ip.h	Sun Jul 15 08:41:40 2001
@@ -65,7 +65,7 @@

 #define IPVERSION	4
 #define MAXTTL		255
-#define IPDEFTTL	64
+#define IPDEFTTL	128

 /* struct timestamp, struct route and MAX_ROUTES are removed.


