Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWGQQoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWGQQoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWGQQnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:43:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:57018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750958AbWGQQcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:24 -0400
Date: Mon, 17 Jul 2006 09:26:50 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/45] v4l/dvb: Kconfig: fix description and dependencies for saa7115 module
Message-ID: <20060717162650.GN4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="kconfig-fix-description-and-dependencies-for-saa7115-module.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Michael Krufky <mkrufky@linuxtv.org>

This Kconfig description is incorrect, due to a previous merge a while back.
CONFIG_SAA711X builds module saa7115, which is the newer v4l2 module, and is
not obsoleted.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/video/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17.3.orig/drivers/media/video/Kconfig
+++ linux-2.6.17.3/drivers/media/video/Kconfig
@@ -380,10 +380,10 @@ config VIDEO_WM8739
 source "drivers/media/video/cx25840/Kconfig"
 
 config VIDEO_SAA711X
-	tristate "Philips SAA7113/4/5 video decoders (OBSOLETED)"
-	depends on VIDEO_V4L1 && I2C && EXPERIMENTAL
+	tristate "Philips SAA7113/4/5 video decoders"
+	depends on VIDEO_DEV && I2C && EXPERIMENTAL
 	---help---
-	  Old support for the Philips SAA7113/4 video decoders.
+	  Support for the Philips SAA7113/4/5 video decoders.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called saa7115.

--
