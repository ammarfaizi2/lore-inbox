Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVDGCQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVDGCQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVDGCQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:16:18 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:30370 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262387AbVDGCQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:16:16 -0400
Date: Thu, 7 Apr 2005 03:16:17 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: [PATCH] r128_state.c: break missing in switch statement (fwd)
Message-ID: <Pine.LNX.4.58.0504070314380.31231@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew/Linus,
	Can you make sure this goes into 2.6.12? until you sort out the bk
thing I'll adopt this approach :-)

Dave.

drm: fix r128_state.c switch statements..
in drivers/char/drm/r128_state.c (linux-2.6.12-rc2), some breaks are
missing in the switch statement. See trivial fix below.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -urp linux-2.6.12-rc2/drivers/char/drm/r128_state.c linux-2.6.12-rc2-fix/drivers/char/drm/r128_state.c
--- linux-2.6.12-rc2/drivers/char/drm/r128_state.c	2005-04-06 13:18:05.000000000 +0200
+++ linux-2.6.12-rc2-fix/drivers/char/drm/r128_state.c	2005-04-06 13:23:50.000000000 +0200
@@ -1549,12 +1549,16 @@ static int r128_cce_depth( DRM_IOCTL_ARG
 	switch ( depth.func ) {
 	case R128_WRITE_SPAN:
 		ret = r128_cce_dispatch_write_span( dev, &depth );
+		break;
 	case R128_WRITE_PIXELS:
 		ret = r128_cce_dispatch_write_pixels( dev, &depth );
+		break;
 	case R128_READ_SPAN:
 		ret = r128_cce_dispatch_read_span( dev, &depth );
+		break;
 	case R128_READ_PIXELS:
 		ret = r128_cce_dispatch_read_pixels( dev, &depth );
+		break;
 	}

 	COMMIT_RING();
