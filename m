Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWCXGO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWCXGO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423167AbWCXGMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:40410 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161015AbWCXGLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:50 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/12] aoe [3/8]: increase allowed outstanding packets
In-Reply-To: <11431806533538-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:53 -0800
Message-Id: <11431806532147-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the number of AoE packets per device that can be outstanding
at one time, increasing performance.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/block/aoe/aoecmd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

eaf0a3cbe5d0713eca3278b3b18f08dba4fb914b
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 150eb78..34b8c8c 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -647,7 +647,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	ulong flags, sysminor, aoemajor;
 	u16 bufcnt;
 	struct sk_buff *sl;
-	enum { MAXFRAMES = 8 };
+	enum { MAXFRAMES = 16 };
 
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ch = (struct aoe_cfghdr *) (h+1);
-- 
1.2.4


