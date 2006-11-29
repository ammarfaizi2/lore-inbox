Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758356AbWK2WE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356AbWK2WE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758287AbWK2WD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:03:57 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50644 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758294AbWK2WDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:03:24 -0500
Message-Id: <20061129220509.212217000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:24 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [patch 13/23] V4L: Do not enable VIDEO_V4L2 unconditionally
Content-Disposition: inline; filename=v4l-do-not-enable-video_v4l2-unconditionally.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Maciej W. Rozycki <macro@linux-mips.org>

V4L: Do not enable VIDEO_V4L2 unconditionally

The VIDEO_V4L2 config setting is enabled unconditionally, even for
configurations with no support for this subsystem whatsoever. The
following patch adds the necessary dependency.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/media/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.4.orig/drivers/media/Kconfig
+++ linux-2.6.18.4/drivers/media/Kconfig
@@ -54,6 +54,7 @@ config VIDEO_V4L1_COMPAT
 
 config VIDEO_V4L2
 	bool
+	depends on VIDEO_DEV
 	default y
 
 source "drivers/media/video/Kconfig"

--
