Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1761295AbWLIABO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761295AbWLIABO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947544AbWLIABE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:01:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37574 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759779AbWLIAAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:00:19 -0500
Message-Id: <20061209000211.935151000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:16 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, airlied@linux.ie,
       daniel-silveira@gee.inatel.br
Subject: [patch 25/32] drm-sis linkage fix
Content-Disposition: inline; filename=drm-sis-linkage-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Andrew Morton <akpm@osdl.org>

Fix http://bugzilla.kernel.org/show_bug.cgi?id=7606

WARNING: "drm_sman_set_manager" [drivers/char/drm/sis.ko] undefined!

Cc: <daniel-silveira@gee.inatel.br>
Cc: Dave Airlie <airlied@linux.ie>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/char/drm/drm_sman.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.19.orig/drivers/char/drm/drm_sman.c
+++ linux-2.6.19/drivers/char/drm/drm_sman.c
@@ -162,6 +162,7 @@ drm_sman_set_manager(drm_sman_t * sman, 
 
 	return 0;
 }
+EXPORT_SYMBOL(drm_sman_set_manager);
 
 static drm_owner_item_t *drm_sman_get_owner_item(drm_sman_t * sman,
 						 unsigned long owner)

--
