Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVE1Evb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVE1Evb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 00:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVE1Eva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 00:51:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3718 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261757AbVE1Ev0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 00:51:26 -0400
Date: Sat, 28 May 2005 00:51:24 -0400
From: Dave Jones <davej@redhat.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Fix up pwc driver compilation.
Message-ID: <20050528045124.GB18404@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The neutering of the pwc driver was incomplete. It still references
some now-dead files..

Signed-off-by: Dave Jones <davej@redhat.com>

--- kernel/drivers/usb/media/pwc/pwc-ctrl.c~	2005-05-28 00:50:04.000000000 -0400
+++ kernel/drivers/usb/media/pwc/pwc-ctrl.c	2005-05-28 00:50:08.000000000 -0400
@@ -48,8 +48,6 @@
 #include "pwc-uncompress.h"
 #include "pwc-kiara.h"
 #include "pwc-timon.h"
-#include "pwc-dec1.h"
-#include "pwc-dec23.h"
 
 /* Request types: video */
 #define SET_LUM_CTL			0x01
--- kernel/drivers/usb/media/pwc/pwc-uncompress.c~	2005-05-28 00:50:14.000000000 -0400
+++ kernel/drivers/usb/media/pwc/pwc-uncompress.c	2005-05-28 00:50:19.000000000 -0400
@@ -29,8 +29,6 @@
 
 #include "pwc.h"
 #include "pwc-uncompress.h"
-#include "pwc-dec1.h"
-#include "pwc-dec23.h"
 
 int pwc_decompress(struct pwc_device *pdev)
 {
