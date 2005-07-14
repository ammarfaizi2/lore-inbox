Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVGNT0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVGNT0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVGNTWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:22:08 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:64954 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261695AbVGNTU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:20:28 -0400
Date: Thu, 14 Jul 2005 12:19:48 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] char/vt: fix compile failure (typo)
Message-ID: <20050714191948.GB28100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>

Description: The mod_timer() statement mistakenly has a comma at the end
of the line instead of a semicolon.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 vt.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN 2.6.13-rc3/drivers/char/vt.c 2.6.13-rc3-timer/drivers/char/vt.c
--- 2.6.13-rc3/drivers/char/vt.c	2005-07-14 12:02:08.000000000 -0700
+++ 2.6.13-rc3-timer/drivers/char/vt.c	2005-07-14 12:02:21.000000000 -0700
@@ -2796,7 +2796,7 @@ void do_blank_screen(int entering_gfx)
 		return;
 
 	if (vesa_off_interval) {
-		blank_state = blank_vesa_wait,
+		blank_state = blank_vesa_wait;
 		mod_timer(&console_timer, jiffies + vesa_off_interval);
 	}
 
