Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWF1AwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWF1AwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWF1AwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:52:15 -0400
Received: from xenotime.net ([66.160.160.81]:5836 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932595AbWF1AwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:52:15 -0400
Date: Tue, 27 Jun 2006 17:52:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: perex@suse.cz, akpm <akpm@osdl.org>
Subject: [PATCH] ac97_codec: make bitfield unsigned
Message-Id: <20060627175205.fad59ffb.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Make a 1-bit bitfield unsigned (no space for sign bit).
Removes 24 sparse warnings from this one file:
include/linux/ac97_codec.h:262:13: error: dubious one-bit signed bitfield

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/ac97_codec.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-g11.orig/include/linux/ac97_codec.h
+++ linux-2617-g11/include/linux/ac97_codec.h
@@ -259,7 +259,7 @@ struct ac97_codec {
 	int type;
 	u32 model;
 
-	int modem:1;
+	unsigned int modem:1;
 
 	struct ac97_ops *codec_ops;
 


---
