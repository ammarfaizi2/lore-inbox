Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSGULiC>; Sun, 21 Jul 2002 07:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSGULiC>; Sun, 21 Jul 2002 07:38:02 -0400
Received: from verein.lst.de ([212.34.181.86]:46093 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S313687AbSGULh5>;
	Sun, 21 Jul 2002 07:37:57 -0400
Date: Sun, 21 Jul 2002 13:41:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix drivers/net/Config.in in 2.4.19-rc3
Message-ID: <20020721134100.A5212@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The big mips merge in 2.4.19-rc3 breaks parsing of drivers/net/Config.in
with config tools that adhere the documented syntax strictly.

CONFIG_NE2000 is a tristate in other places so the mips-specific section
can't redefine it as bool.  Please include this patch in the final 2.4.19.


--- 1.38/drivers/net/Config.in	Fri Jun 28 17:36:11 2002
+++ edited/drivers/net/Config.in	Sun Jul 21 14:35:08 2002
@@ -223,7 +223,7 @@
       tristate '  Baget AMD LANCE support' CONFIG_BAGETLANCE
    fi
    if [ "$CONFIG_NEC_OSPREY" = "y" ]; then
-      bool '  Memory-mapped onboard NE2000-compatible ethernet' CONFIG_NE2000
+      tristate '  Memory-mapped onboard NE2000-compatible ethernet' CONFIG_NE2000
    fi
 fi
 
