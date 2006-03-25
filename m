Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWCYE1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWCYE1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWCYE1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:27:17 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:26556
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750822AbWCYE0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:26:43 -0500
Date: Fri, 24 Mar 2006 20:26:23 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/20] Kconfig: VIDEO_DECODER must select FW_LOADER
Message-ID: <20060325042623.GD21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="kconfig-video_decoder-must-select-fw_loader.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
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

--- linux-2.6.16.orig/drivers/media/video/Kconfig
+++ linux-2.6.16/drivers/media/video/Kconfig
@@ -349,6 +349,7 @@ config VIDEO_AUDIO_DECODER
 config VIDEO_DECODER
 	tristate "Add support for additional video chipsets"
 	depends on VIDEO_DEV && I2C && EXPERIMENTAL
+	select FW_LOADER
 	---help---
 	  Say Y here to compile drivers for SAA7115, SAA7127 and CX25840
 	  video decoders.

--
