Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVGROJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVGROJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVGROJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:09:42 -0400
Received: from Quebec-HSE-ppp231061.qc.sympatico.ca ([69.159.205.163]:6895
	"EHLO cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261748AbVGROJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:09:40 -0400
Subject: [PATCH] Add missing tvaudio try_to_freeze.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121659791.13487.74.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 18 Jul 2005 14:09:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The .c gives Gerd Knorr as the maintainer of this file, but no email
address. The MAINTAINERS file doesn't have his name or make it clear who
owns the file. I haven't therefore been able to cc the maintainer.

Tvaudio lacks a refrigerator call. This patch fixes that.

Regards,

Nigel

Signed-off by: Nigel Cunningham <ncunningham@suspend2.net>

 tvaudio.c |    1 +
 1 files changed, 1 insertion(+)
diff -ruNp 234-tvaudio.patch-old/drivers/media/video/tvaudio.c 234-tvaudio.patch-new/drivers/media/video/tvaudio.c
--- 234-tvaudio.patch-old/drivers/media/video/tvaudio.c	2005-07-18 06:36:49.000000000 +1000
+++ 234-tvaudio.patch-new/drivers/media/video/tvaudio.c	2005-07-18 08:20:58.000000000 +1000
@@ -285,6 +285,7 @@ static int chip_thread(void *data)
 			schedule();
 		}
 		remove_wait_queue(&chip->wq, &wait);
+		try_to_freeze();
 		if (chip->done || signal_pending(current))
 			break;
 		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

