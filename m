Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVAXTk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVAXTk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVAXTkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:40:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17938 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261600AbVAXTg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:36:29 -0500
Date: Mon, 24 Jan 2005 20:36:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [2.6 patch] kernel-api.sgml references removed file net_init.c
Message-ID: <20050124193624.GS3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch by Jesper Juhl is still required in 2.6.11-rc2-mm1.


make mandocs fails with these errors in 2.6.10-bk2 : 

juhl@dragon:~/download/kernel/linux-2.6.10-bk2$ make mandocs
  DOCPROC Documentation/DocBook/kernel-api.sgml
docproc: /home/juhl/download/kernel/linux-2.6.10-bk2/drivers/net/net_init.c: No such file or directory
/bin/sh: line 1:  4845 Segmentation fault      
SRCTREE=/home/juhl/download/kernel/linux-2.6.10-bk2/ scripts/basic/docproc doc Documentation/DocBook/kernel-api.tmpl >Documentation/DocBook/kernel-api.sgml
make[1]: *** [Documentation/DocBook/kernel-api.sgml] Error 139
make: *** [mandocs] Error 2

removing the reference to net_init.c makes it continue a bit further but 
it still ends up failing with these errors : 

make[1]: *** [Documentation/DocBook/kernel-api.sgml] Error 1
make: *** [mandocs] Error 2

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-bk2-orig/Documentation/DocBook/kernel-api.tmpl	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.10-bk2/Documentation/DocBook/kernel-api.tmpl	2004-12-31 01:33:53.000000000 +0100
@@ -143,7 +143,6 @@
   <chapter id="netdev">
      <title>Network device support</title>
      <sect1><title>Driver Support</title>
-!Edrivers/net/net_init.c
 !Enet/core/dev.c
      </sect1>
      <sect1><title>8390 Based Network Cards</title>


