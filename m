Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVDLSMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVDLSMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVDLKcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:32:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:59079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262110AbVDLKbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:00 -0400
Message-Id: <200504121030.j3CAUqH9005167@shell0.pdx.osdl.net>
Subject: [patch 014/198] r128_state.c: break missing in switch statement
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, airlied@linux.ie,
       hjlipp@web.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Airlie <airlied@linux.ie>

drm: fix r128_state.c switch statements..  in drivers/char/drm/r128_state.c
(linux-2.6.12-rc2), some breaks are missing in the switch statement.  See
trivial fix below.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Dave Airlie <airlied@linux.ie>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/char/drm/r128_state.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN drivers/char/drm/r128_state.c~r128_statec-break-missing-in-switch-statement drivers/char/drm/r128_state.c
--- 25/drivers/char/drm/r128_state.c~r128_statec-break-missing-in-switch-statement	2005-04-12 03:21:06.802102824 -0700
+++ 25-akpm/drivers/char/drm/r128_state.c	2005-04-12 03:21:06.806102216 -0700
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
_
