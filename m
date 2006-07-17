Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWGQQgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWGQQgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWGQQdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:25788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750993AbWGQQd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:28 -0400
Date: Mon, 17 Jul 2006 09:28:36 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jaroslav Kysela <perex@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 33/45] ALSA: RME HDSP - fixed proc interface (missing {})
Message-ID: <20060717162836.GH4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-rme-hdsp-fixed-proc-interface.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Remy Bruno <remy.bruno@trinnov.com>

[PATCH] ALSA: RME HDSP - fixed proc interface (missing {})

From: Remy Bruno <remy.bruno@trinnov.com>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/rme9652/hdsp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.6.orig/sound/pci/rme9652/hdsp.c
+++ linux-2.6.17.6/sound/pci/rme9652/hdsp.c
@@ -3169,9 +3169,10 @@ snd_hdsp_proc_read(struct snd_info_entry
 	char *clock_source;
 	int x;
 
-	if (hdsp_check_for_iobox (hdsp))
+	if (hdsp_check_for_iobox (hdsp)) {
 		snd_iprintf(buffer, "No I/O box connected.\nPlease connect one and upload firmware.\n");
 		return;
+        }
 
 	if (hdsp_check_for_firmware(hdsp, 0)) {
 		if (hdsp->state & HDSP_FirmwareCached) {

--
