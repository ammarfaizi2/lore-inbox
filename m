Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266623AbRGEFhA>; Thu, 5 Jul 2001 01:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266624AbRGEFgu>; Thu, 5 Jul 2001 01:36:50 -0400
Received: from [210.82.190.10] ([210.82.190.10]:12804 "HELO mx.linux.net.cn")
	by vger.kernel.org with SMTP id <S266623AbRGEFgi>;
	Thu, 5 Jul 2001 01:36:38 -0400
Date: Thu, 5 Jul 2001 13:36:33 +0800
From: Fang Han <dfbb@linux.net.cn>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix fbcon.c compiles error on 2.4.7pre2
Message-ID: <20010705133632.B1531@dfbbb.cn.mvd>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01060919365100.00648@kenobi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01060919365100.00648@kenobi>; from richbaum@acm.org on Sat, Jun 09, 2001 at 07:36:51PM -0500
Organization: None
X-Attribution: dfbb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that some part is missing, In AC patch , it have that function.

dfbb

--- linux/drivers/video/fbcon.c.orig	Thu Jul  5 13:09:55 2001
+++ linux/drivers/video/fbcon.c	Thu Jul  5 13:33:32 2001
@@ -1150,13 +1150,11 @@
 	    	}
 	    }
 	    scr_writew(c, d);
-	    console_conditional_schedule();
 	    s++;
 	    d++;
 	} while (s < le);
 	if (s > start)
 	    p->dispsw->putcs(conp, p, start, s - start, real_y(p, line), x);
-	console_conditional_schedule();
 	if (offset > 0)
 		line++;
 	else {


