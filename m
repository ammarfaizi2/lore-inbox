Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUFUUWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUFUUWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUFUUWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:22:40 -0400
Received: from baikonur.stro.at ([213.239.196.228]:3045 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S266450AbUFUUWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:22:38 -0400
Date: Mon, 21 Jun 2004 22:22:37 +0200
From: maximilian attems <janitor@sternwelten.at>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch-kj] printk fix drivers/char/istallion.c
Message-ID: <20040621202237.GK1545@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


please apply that small janitorial fix.


From: <WHarms@bfs.de>(Walter Harms)
this is a quick fix for the istallion driver.
it has one %d to much.

regards,
walter
ps: calling returncodes something like 'i' should be forbidden 

 Signed-off-by: Maximilian Attems <janitor@sternwelten.at>


---

 linux-2.6.7-max/drivers/char/istallion.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/istallion.c~printk-fix-istallion drivers/char/istallion.c
--- linux-2.6.7/drivers/char/istallion.c~printk-fix-istallion	2004-06-18 10:33:41.000000000 +0200
+++ linux-2.6.7-max/drivers/char/istallion.c	2004-06-18 10:33:41.000000000 +0200
@@ -851,7 +851,7 @@ static void __exit istallion_module_exit
 	i = tty_unregister_driver(stli_serial);
 	if (i) {
 		printk("STALLION: failed to un-register tty driver, "
-			"errno=%d,%d\n", -i);
+			"errno=%d\n", -i);
 		restore_flags(flags);
 		return;
 	}


