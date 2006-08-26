Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422971AbWHZRmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422971AbWHZRmr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWHZRml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:42:41 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:36737 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964802AbWHZRmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=O36svq8/wVJASyKPF/6FO/4/02ScA7ip6nL1mfCCfYKFWi7DuUFbLTnhmNPtfeOw1y+05bHWWyX4Vsjg0C7pgGMEkjI3iDJZXBS5ZPa4RX/Z7TTsEXOaa3CNPgSRMMQTVZOcZPPRFs+tCptNguH9R3mtKcB9xNu++Yj6/zR6rMY=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 02/13] Fix comment about remap_file_pages
Date: Sat, 26 Aug 2006 19:42:13 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174213.14790.50608.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This comment is a bit unclear and also stale. So fix it. Thanks to Hugh Dickins
for explaining me what it really referred to, and correcting my first fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 mm/fremap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/fremap.c b/mm/fremap.c
index 21b7d0c..cdeabad 100644
--- a/mm/fremap.c
+++ b/mm/fremap.c
@@ -215,9 +215,10 @@ #endif
 					    pgoff, flags & MAP_NONBLOCK);
 
 		/*
-		 * We can't clear VM_NONLINEAR because we'd have to do
-		 * it after ->populate completes, and that would prevent
-		 * downgrading the lock.  (Locks can't be upgraded).
+		 * We would like to clear VM_NONLINEAR, in the case when
+		 * sys_remap_file_pages covers the whole vma, so making
+		 * it linear again.  But cannot do so until after a
+		 * successful populate, and have no way to upgrade sem.
 		 */
 	}
 	if (likely(!has_write_lock))
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
