Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291838AbSBTNSN>; Wed, 20 Feb 2002 08:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291839AbSBTNSD>; Wed, 20 Feb 2002 08:18:03 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:6662 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S291838AbSBTNRx>; Wed, 20 Feb 2002 08:17:53 -0500
Date: Wed, 20 Feb 2002 14:17:35 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: axboe@suse.de
Subject: [PATCH 2.5.5] rd compile fix
Message-ID: <20020220131735.GF8539@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (already posted here I believe) is _still_ required to compile
ramdisk support.

Jens, please push it harder to Linus...

Stelian.

===== drivers/block/rd.c 1.27 vs edited =====
--- 1.27/drivers/block/rd.c	Tue Feb  5 16:23:14 2002
+++ edited/drivers/block/rd.c	Wed Feb 13 14:35:55 2002
@@ -268,7 +268,7 @@
 		goto fail;
 
 	set_bit(BIO_UPTODATE, &sbh->bi_flags);
-	sbh->bi_end_io(sbh, len >> 9);
+	sbh->bi_end_io(sbh);
 	return 0;
  fail:
 	bio_io_error(sbh);
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
