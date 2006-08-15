Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWHOAKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWHOAKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWHOAKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:10:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:20807 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965085AbWHOAKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:10:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DcfyisejhoOtXzhGNX+ouakJxC0qo3A7XWxIWQN7VNe+Zs5sLvF4PZWtDYbuBHpej3kC6Vx5faNRLkTY4U6ikEXiSsCtOHKbo/DT92Pw7iyyCVR1wm+x8GOqRJlO1Xm3MN2fWg2xXQkuLY9Q/6i6lZYqLXhc0BgOnxjA5tg+Skg=
Date: Tue, 15 Aug 2006 04:10:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       James Courtier-Dutton <james@superbug.demon.co.uk>
Subject: [PATCH] emu10k1x: simplify around pci_register_driver()
Message-ID: <20060815001045.GD5175@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Report errors to modprobe as side effect.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 sound/pci/emu10k1/emu10k1x.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1626,12 +1626,7 @@ static struct pci_driver driver = {
 // initialization of the module
 static int __init alsa_card_emu10k1x_init(void)
 {
-	int err;
-
-	if ((err = pci_register_driver(&driver)) > 0)
-		return err;
-
-	return 0;
+	return pci_register_driver(&driver);
 }
 
 // clean up the module

