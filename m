Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbULFVDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbULFVDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbULFVDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:03:13 -0500
Received: from math.ut.ee ([193.40.5.125]:59031 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261654AbULFVAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:00:25 -0500
Date: Mon, 6 Dec 2004 23:00:21 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "shadows global" warning
Message-ID: <Pine.SOC.4.61.0412062259100.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warning "declaration of `index' shadows a global declaration"
occuring on line 384

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/mm/swap.c	2004-08-14 10:55:19.000000000 +0000
+++ b/mm/swap.c	2004-12-02 20:56:43.000000000 +0000
@@ -381,9 +381,9 @@
  }

  unsigned pagevec_lookup_tag(struct pagevec *pvec, struct address_space *mapping,
-		pgoff_t *index, int tag, unsigned nr_pages)
+		pgoff_t *asc_index, int tag, unsigned nr_pages)
  {
-	pvec->nr = find_get_pages_tag(mapping, index, tag,
+	pvec->nr = find_get_pages_tag(mapping, asc_index, tag,
  					nr_pages, pvec->pages);
  	return pagevec_count(pvec);
  }
