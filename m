Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbRETSjw>; Sun, 20 May 2001 14:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbRETSjn>; Sun, 20 May 2001 14:39:43 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:43834
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S261968AbRETSj3>; Sun, 20 May 2001 14:39:29 -0400
Date: Sun, 20 May 2001 20:39:20 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: stud11@cc4.kuleuven.ac.be
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make drivers/block/ps2esdi.c compile (2.4.4)
Message-ID: <20010520203920.A910@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following trivial patch against 2.4.4(-ac11) makes ps2esdi compile.

--- linux-244-ac10-clean/drivers/block/ps2esdi.c	Sat May 19 21:06:29 2001
+++ linux-244-ac10/drivers/block/ps2esdi.c	Sun May 20 14:47:04 2001
@@ -953,10 +953,10 @@
 		break;
 	}
 	if(ending != -1) {
-		spin_lock_irqsave(io_request_lock, flags);
+		spin_lock_irqsave(&io_request_lock, flags);
 		end_request(ending);
 		do_ps2esdi_request(BLK_DEFAULT_QUEUE(MAJOR_NR));
-		spin_unlock_irqrestore(io_request_lock, flags);
+		spin_unlock_irqrestore(&io_request_lock, flags);
 	}
 }				/* handle interrupts */
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

The difference between theory and practice is that, in theory, there is 
no difference between theory and practice. -- Anonymous
