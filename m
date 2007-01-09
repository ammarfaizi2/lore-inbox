Return-Path: <linux-kernel-owner+w=401wt.eu-S1750888AbXAIB07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbXAIB07 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbXAIB07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:26:59 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:47258 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbXAIB06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:26:58 -0500
X-Originating-Ip: 74.109.71.198
Date: Mon, 8 Jan 2007 20:20:28 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Remove useless FIND_FIRST_BIT() macro from cardbus.c.
Message-ID: <Pine.LNX.4.64.0701082015270.3951@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Delete the definition of the unused FIND_FIRST_BIT() macro.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  this macro seems safely deletable, given that there is no other
reference to that macro anywhere in the entire source tree and,
besides, one should use find_first_bit() anyway.

  it's not clear who the official maintainer is for this subsystem
these days.

diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index 2d7effe..a1bd763 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -40,8 +40,6 @@

 /*====================================================================*/

-#define FIND_FIRST_BIT(n)	((n) - ((n) & ((n)-1)))
-
 /* Offsets in the Expansion ROM Image Header */
 #define ROM_SIGNATURE		0x0000	/* 2 bytes */
 #define ROM_DATA_PTR		0x0018	/* 2 bytes */
