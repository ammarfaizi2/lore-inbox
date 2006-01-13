Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161509AbWAMJlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161509AbWAMJlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161515AbWAMJlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:41:51 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:53008 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161509AbWAMJlu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:41:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=p4tM0cqZhUrC/1/gcb3urhFWCZAg9QEaVTlNHXhh8iZls/Mdo9Wb3xLHpOJVn1/yXDqhlVQtGhZnDxumpn8W0OkS5tULDHWSvEZbsowpxGi9G1lIYHrcvZk0/PYViEZLk99pBYVk1DNo5egzOefhnCAw8vj/i6A23B8QvfSV9xg=
Message-ID: <ff1cadb20601130141k1ef91fcdr@mail.gmail.com>
Date: Fri, 13 Jan 2006 10:41:47 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
To: mingo@elte.hu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fixed a compile bug in 2.6.15-rt4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a compile bug in 2.6.15-rt4, but I think it is
present in hrtimer implementation too.

Signed-off-by: Luca Falavigna <dktrkranz@gmail.com

--- patch-2.6.15-rt4.orig       2006-01-13 10:41:48.000000000 +0100
+++ patch-2.6.15-rt4    2006-01-13 10:42:17.000000000 +0100
@@ -35663,7 +35663,7 @@ Index: linux/kernel/hrtimer.c
 +# define hrtimer_hres_active          0
 +# define hres_enqueue_expired(t,b,n)  0
 +# define hrtimer_check_clocks()               do { } while (0)
-+# define kick_off_hrtimer             do { } while (0)
++# define kick_off_hrtimer(timer, base)        do { } while (0)
 +
 +#endif /* !CONFIG_HIGH_RES_TIMERS */
 +

Regards,

--
Luca
