Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWCYELl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWCYELl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWCYELk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:11:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:7839 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750776AbWCYELj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:11:39 -0500
Date: Fri, 24 Mar 2006 20:11:18 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, mkrufky@linuxtv.org,
       mchehab@infradead.org
Subject: [PATCH 05/08] Kconfig: VIDEO_DECODER must select FW_LOADER
Message-ID: <20060325041118.GF16955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325040852.GA16955@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>

The cx25840 module requires external firmware in order to function,
so it must select FW_LOADER, but saa7115 and saa7129 do not require it.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/video/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.15.6.orig/drivers/media/video/Kconfig
+++ linux-2.6.15.6/drivers/media/video/Kconfig
@@ -340,6 +340,7 @@ config VIDEO_AUDIO_DECODER
 config VIDEO_DECODER
 	tristate "Add support for additional video chipsets"
 	depends on VIDEO_DEV && I2C && EXPERIMENTAL
+	select FW_LOADER
 	---help---
 	  Say Y here to compile drivers for SAA7115, SAA7127 and CX25840
 	  video  decoders.
