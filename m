Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWFRPsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWFRPsh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWFRPsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:48:24 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751196AbWFRPsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:48:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=VKEKnH47WY6AIL8QwIwG1yG4msNkazriQMMl0O4M0YrIUHu94g9p28+Gtkx0T89IuNOScJp4NMrDsz5x5h0fZsmbOIAc2BH0UnPkWEN9tXheKfnUPdGZ7kZjoLJvDl8x451WG3qcsAWs0GVEm7IYQJSqGZK8+tOiZFH+KQ7FnCk=
Message-ID: <449571A9.4000805@gmail.com>
Date: Sun, 18 Jun 2006 23:30:49 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: [PATCH 6/9] VT binding: Make mdacon support binding 
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not mark mdacon_startup __init.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/mdacon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 7f939d0..c89f90e 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -308,7 +308,7 @@ static void __init mda_initialize(void)
 	outb_p(0x00, mda_gfx_port);
 }
 
-static const char __init *mdacon_startup(void)
+static const char *mdacon_startup(void)
 {
 	mda_num_columns = 80;
 	mda_num_lines   = 25;

