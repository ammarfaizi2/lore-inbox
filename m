Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275994AbRJYTCT>; Thu, 25 Oct 2001 15:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275989AbRJYTCJ>; Thu, 25 Oct 2001 15:02:09 -0400
Received: from mailout2.informatik.tu-muenchen.de ([131.159.254.8]:56797 "EHLO
	mailout2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S275990AbRJYTCB>; Thu, 25 Oct 2001 15:02:01 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] generic eui-64 addressing
Reply-To: Daniel Stodden <stodden@in.tum.de>
From: Daniel Stodden <stodden@in.tum.de>
Date: 25 Oct 2001 21:02:31 +0200
Message-ID: <87r8rr35mg.fsf@bitch.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi.


i'm developing prototype modules[1] for a data link network using
EUI-64[2] addressing.

what i'm missing are macros for hw type and address length from the
kernel headers.

could someone please rewrite if_arp.h around the patch below? taken
from iana values

plus: to make my world perfect, maybe a macro somewhat like

#define EUI64_ALEN 8

not sure where this might go into...


thanx,
dns

--- if_arp.h.orig       Thu Oct 25 19:15:19 2001
+++ if_arp.h    Thu Oct 25 20:46:24 2001
@@ -39,6 +39,7 @@
 #define ARPHRD_ATM     19              /* ATM                          */
 #define ARPHRD_METRICOM        23              /* Metricom STRIP (new IANA id)*       /
 #define        ARPHRD_IEEE1394 24              /* IEEE 1394 IPv4 - RFC 2734   *       /
+#define ARPHRD_EUI64    27              /* EUI-64                       */
 
 /* Dummy types for non ARP hardware */
 #define ARPHRD_SLIP    256

-- 
___________________________________________________________________________
 mailto:stodden@in.tum.de
