Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbTHWE2t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 00:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTHWE2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 00:28:49 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:59828 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262569AbTHWE2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 00:28:47 -0400
Date: Sat, 23 Aug 2003 00:24:26 -0400
From: Chris Heath <chris@heathens.co.nz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][Trivial] Fix ftape warning
Message-Id: <20030823002058.E5C4.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06.02
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a trivial patch that fixes this warning in 2.6.0-test4:

drivers/char/ftape/lowlevel/fdc-io.c: In function `ftape_interrupt':
drivers/char/ftape/lowlevel/fdc-io.c:1299: warning: unused variable `_tracing'

Chris


--- linux-2.6.0-test4/drivers/char/ftape/lowlevel/fdc-io.c	2003-07-27 16:34:58.000000000 -0400
+++ linux-2.6.0-test4-cdh1/drivers/char/ftape/lowlevel/fdc-io.c	2003-08-22 23:21:36.000000000 -0400
@@ -1305,7 +1305,7 @@
 	} else {
 		TRACE(ft_t_bug, "Unexpected ftape interrupt");
 	}
-	return IRQ_RETVAL(handled);
+	TRACE_EXIT IRQ_RETVAL(handled);
 }
 
 int fdc_grab_irq_and_dma(void)

