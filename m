Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291338AbSBMDwJ>; Tue, 12 Feb 2002 22:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291335AbSBMDwA>; Tue, 12 Feb 2002 22:52:00 -0500
Received: from mail010.mail.bellsouth.net ([205.152.58.30]:2129 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S291332AbSBMDvm>; Tue, 12 Feb 2002 22:51:42 -0500
Message-ID: <3C69E2C7.3E749061@bellsouth.net>
Date: Tue, 12 Feb 2002 22:51:35 -0500
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@clueserver.org, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.4 sound module problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this was the same message I received. but here
is the patch I used to get around my sound problem in
2.5.4.
Linus, please apply to 2.5.5 pre1
Later,
Albert
--- linux/drivers/sound/dmabuf.c.orig   Tue Feb 12 10:12:59 2002
+++ linux/drivers/sound/dmabuf.c        Tue Feb 12 10:15:06 2002
@@ -113,7 +113,7 @@
                }
        }
        dmap->raw_buf = start_addr;
-       dmap->raw_buf_phys = virt_to_bus(start_addr);
+       dmap->raw_buf_phys = isa_virt_to_bus(start_addr);
 
        for (page = virt_to_page(start_addr); page <= virt_to_page(end_addr); page++)
                mem_map_reserve(page);

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
