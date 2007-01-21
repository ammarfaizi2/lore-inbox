Return-Path: <linux-kernel-owner+w=401wt.eu-S1751319AbXAUKKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbXAUKKT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 05:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbXAUKKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 05:10:18 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:49592 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbXAUKKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 05:10:17 -0500
X-Originating-Ip: 74.109.98.130
Date: Sun, 21 Jan 2007 05:03:15 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
Subject: [PATCH] Introduce simple TRUE and FALSE boolean macros.
Message-ID: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.723, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, TW_MQ 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Introduce the TRUE and FALSE boolean macros so that everyone can
stop re-inventing them, and remove the one occurrence in the source
tree that clashes with that change.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  once this patch is applied, others can remove all of the superfluous
macro definitions from the source tree at their convenience.

  this was compile tested on x86 with "make allyesconfig".


 drivers/net/wireless/strip.c |    2 --
 include/linux/types.h        |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/strip.c b/drivers/net/wireless/strip.c
index ce3a8ba..5e64ec1 100644
--- a/drivers/net/wireless/strip.c
+++ b/drivers/net/wireless/strip.c
@@ -177,8 +177,6 @@ typedef struct {
 	MetricomNode node[NODE_TABLE_SIZE];
 } MetricomNodeTable;

-enum { FALSE = 0, TRUE = 1 };
-
 /*
  * Holds the radio's firmware version.
  */
diff --git a/include/linux/types.h b/include/linux/types.h
index 0351bf2..d988636 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -34,6 +34,8 @@ typedef __kernel_mqd_t		mqd_t;

 #ifdef __KERNEL__
 typedef _Bool			bool;
+#define TRUE			1
+#define FALSE			0

 typedef __kernel_uid32_t	uid_t;
 typedef __kernel_gid32_t	gid_t;
