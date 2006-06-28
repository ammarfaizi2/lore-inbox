Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWF1Awk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWF1Awk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWF1Awj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:52:39 -0400
Received: from xenotime.net ([66.160.160.81]:8652 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932605AbWF1AwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:52:18 -0400
Date: Tue, 27 Jun 2006 17:53:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: perex@suse.cz, akpm <akpm@osdl.org>
Subject: [PATCH] oss/via: make bitfield unsigned
Message-Id: <20060627175324.54ea397c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Make a 1-bit field unsigned like all of the others near it.
sound/oss/via82cxxx_audio.c:311:21: error: dubious one-bit signed bitfield

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 sound/oss/via82cxxx_audio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-g11.orig/sound/oss/via82cxxx_audio.c
+++ linux-2617-g11/sound/oss/via82cxxx_audio.c
@@ -308,7 +308,7 @@ struct via_info {
 	unsigned sixchannel: 1;	/* 8233/35 with 6 channel support */
 	unsigned volume: 1;
 
-	int locked_rate : 1;
+	unsigned locked_rate : 1;
 	
 	int mixer_vol;		/* 8233/35 volume  - not yet implemented */
 


---
