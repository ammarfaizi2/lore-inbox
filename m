Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268515AbUJDWex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268515AbUJDWex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268520AbUJDWcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:32:08 -0400
Received: from peabody.ximian.com ([130.57.169.10]:55000 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268713AbUJDWZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:25:48 -0400
Subject: [patch] inotify: ioctl retval
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096865816.3827.1.camel@vertex>
References: <1096865816.3827.1.camel@vertex>
Content-Type: multipart/mixed; boundary="=-qI6G9JgySM4+fQRFYWA+"
Date: Mon, 04 Oct 2004 18:24:12 -0400
Message-Id: <1096928652.4335.1.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qI6G9JgySM4+fQRFYWA+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

John,

It is a shock--so you might want to sit down--but POSIX says that an
ioctl must return ENOTTY when a valid fd is given a cmd that is not
valid for that fd.

Even the man page confirms this.

Astonished,

	Robert Love


--=-qI6G9JgySM4+fQRFYWA+
Content-Disposition: attachment; filename=inotify-0.12-rml-ioctyl-retval-1.patch
Content-Type: text/x-patch; name=inotify-0.12-rml-ioctyl-retval-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

A shock, but POSIX defines an invalid ioctl() cmd as returning -ENOTTY.

 drivers/char/inotify.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-10-04 14:56:17.000000000 -0400
+++ linux/drivers/char/inotify.c	2004-10-04 18:20:50.052997768 -0400
@@ -925,7 +925,7 @@
 			return -EFAULT;
 		return 0;
 	default:
-		return -EINVAL;
+		return -ENOTTY;
 	}
 }
 

--=-qI6G9JgySM4+fQRFYWA+--

