Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269972AbRHEQWe>; Sun, 5 Aug 2001 12:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269974AbRHEQWZ>; Sun, 5 Aug 2001 12:22:25 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:8672
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S269972AbRHEQWF>; Sun, 5 Aug 2001 12:22:05 -0400
Date: Sun, 5 Aug 2001 18:22:08 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: pgmdsg@ibi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make riscom8.c build (248p4)
Message-ID: <20010805182208.S821@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch is needed for me to be able to compile
drivers/char/riscom8.c. I am not exactly sure where it is
that the init.data section has been asked to hold rw data
before but I trust gcc to know this better than me...

--- linux-248-pre4-clean/drivers/char/riscom8.c Sun Aug  5 14:34:54 2001
+++ linux-248p4-kbuild/drivers/char/riscom8.c   Sun Aug  5 18:14:29 2001
@@ -1866,10 +1866,10 @@
 __setup("riscom8=", riscom8_setup);
 #endif
 
-static const char banner[] __initdata =
+static char banner[] __initdata =
        KERN_INFO "rc: SDL RISCom/8 card driver v1.1, (c) D.Gorodchanin "
                  "1994-1996.\n";
-static const char no_boards_msg[] __initdata =
+static char no_boards_msg[] __initdata =
        KERN_INFO "rc: No RISCom/8 boards detected.\n";
 
 /* 
-- 
        Rasmus(rasmus@jaquet.dk)

Duct tape is like the force; it has a light side and a dark side, and
it holds the universe together.
  -- Anonymous
