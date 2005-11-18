Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVKRDdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVKRDdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVKRDdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:33:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57350 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751525AbVKRDda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:33:30 -0500
Date: Fri, 18 Nov 2005 04:33:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: proski@gnu.org, hermes@gibson.dropbear.id.au
Cc: orinoco-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [2.6 patch] drivers/net/wireless/orinoco.h: "extern inline" -> "static inline"
Message-ID: <20051118033329.GU11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/orinoco.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc1-mm1-full/drivers/net/wireless/orinoco.h.old	2005-11-18 02:38:43.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/net/wireless/orinoco.h	2005-11-18 02:38:47.000000000 +0100
@@ -155,7 +155,7 @@
  * SPARC, due to its weird semantics for save/restore flags. extern
  * inline should prevent the kernel from linking or module from
  * loading if they are not inlined. */
-extern inline int orinoco_lock(struct orinoco_private *priv,
+static inline int orinoco_lock(struct orinoco_private *priv,
 			       unsigned long *flags)
 {
 	spin_lock_irqsave(&priv->lock, *flags);
@@ -168,7 +168,7 @@
 	return 0;
 }
 
-extern inline void orinoco_unlock(struct orinoco_private *priv,
+static inline void orinoco_unlock(struct orinoco_private *priv,
 				  unsigned long *flags)
 {
 	spin_unlock_irqrestore(&priv->lock, *flags);

