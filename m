Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314499AbSEUNKB>; Tue, 21 May 2002 09:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSEUNKA>; Tue, 21 May 2002 09:10:00 -0400
Received: from imladris.infradead.org ([194.205.184.45]:23565 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314499AbSEUNJ7>; Tue, 21 May 2002 09:09:59 -0400
Date: Tue, 21 May 2002 14:09:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] buffermem_pages removal (2/5)
Message-ID: <20020521140951.B15796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove buffermem_pages showing from sgi serial code (debug only).


--- 1.4/drivers/sgi/char/sgiserial.c	Tue Apr 30 00:18:45 2002
+++ edited/drivers/sgi/char/sgiserial.c	Tue May 21 14:27:10 2002
@@ -422,10 +422,6 @@
 		} else if (ch == 1) {
 			show_state();
 			return;
-		} else if (ch == 2) {
-			printk("%ld buffermem pages\n",
-					nr_buffermem_pages());
-			return;
 		}
 	}
 	/* Look for kgdb 'stop' character, consult the gdb documentation
