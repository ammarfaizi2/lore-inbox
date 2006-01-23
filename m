Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWAWQNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWAWQNp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWAWQMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:12:25 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:36743 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932239AbWAWQMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:12:23 -0500
Date: Mon, 23 Jan 2006 13:34:00 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, martin@valinux.com, gareth@valinux.com
Subject: [PATCH] drm: Fix sparse warning in radeon driver.
Message-Id: <20060123133400.584b117a.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 2.2.0beta4 (GTK+ 2.8.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Fixes the following sparse warning:

 drivers/char/drm/radeon_cp.c:1643:31: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/char/drm/radeon_cp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/drm/radeon_cp.c b/drivers/char/drm/radeon_cp.c
index 915665c..9bb8ae0 100644
--- a/drivers/char/drm/radeon_cp.c
+++ b/drivers/char/drm/radeon_cp.c
@@ -1640,7 +1640,7 @@ static int radeon_do_cleanup_cp(drm_devi
 		if (dev_priv->gart_info.gart_table_location == DRM_ATI_GART_FB)
 		{
 			drm_core_ioremapfree(&dev_priv->gart_info.mapping, dev);
-			dev_priv->gart_info.addr = 0;
+			dev_priv->gart_info.addr = NULL;
 		}
 	}
 	/* only clear to the start of flags */


-- 
Luiz Fernando N. Capitulino
