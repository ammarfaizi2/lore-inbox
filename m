Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbRA0IBh>; Sat, 27 Jan 2001 03:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRA0IB1>; Sat, 27 Jan 2001 03:01:27 -0500
Received: from Huntington-Beach.blue-labs.org ([208.179.0.198]:51495 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131579AbRA0IBT>; Sat, 27 Jan 2001 03:01:19 -0500
Message-ID: <3A72804A.E6052E1B@linux.com>
Date: Sat, 27 Jan 2001 08:01:14 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does Linus or anyone object to raising the ksmg buffer from 16K to 32K?
4/5 systems I have now overflow the buffer during boot before init is
even launched.

--- linux/kernel/printk.c~    Fri Jan 26 18:50:28 2001
+++ linux/kernel/printk.c     Fri Jan 26 23:59:31 2001
@@ -22,7 +22,7 @@

 #include <asm/uaccess.h>

-#define LOG_BUF_LEN    (16384)
+#define LOG_BUF_LEN    (32768)
 #define LOG_BUF_MASK   (LOG_BUF_LEN-1)

 static char buf[1024];

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
