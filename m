Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbTAQT6z>; Fri, 17 Jan 2003 14:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTAQT6z>; Fri, 17 Jan 2003 14:58:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60132 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267650AbTAQT6y>;
	Fri, 17 Jan 2003 14:58:54 -0500
Date: Fri, 17 Jan 2003 12:07:42 -0800
From: Dave Olien <dmo@osdl.org>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.or, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH] Fix compiler warning from asound.h
Message-ID: <20030117120742.A16125@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a trivial patch that cleans up several compiler warnings from
the source file sound/core/pcm_native.c. The fix is in the header file
asound.h.


diff -ur linux-2.5.59_original/include/sound/asound.h linux-2.5.59_trivial_patch/include/sound/asound.h
--- linux-2.5.59_original/include/sound/asound.h	Thu Jan 16 18:22:22 2003
+++ linux-2.5.59_trivial_patch/include/sound/asound.h	Fri Jan 17 11:27:20 2003
@@ -259,9 +259,15 @@
 	SNDRV_PCM_STATE_DRAINING,	/* stream is draining */
 	SNDRV_PCM_STATE_PAUSED,		/* stream is paused */
 	SNDRV_PCM_STATE_SUSPENDED,	/* hardware is suspended */
-	SNDRV_PCM_STATE_LAST = SNDRV_PCM_STATE_SUSPENDED,
 };
 
+/*
+ * This define is used to range check the sndrv_pcm_state enumeration type.
+ * If new states are added to sndrv_pcm_state, then update this
+ * define to reflect the last member of the enumeration.
+ */
+#define	SNDRV_PCM_STATE_LAST  SNDRV_PCM_STATE_SUSPENDED
+
 enum {
 	SNDRV_PCM_MMAP_OFFSET_DATA = 0x00000000,
 	SNDRV_PCM_MMAP_OFFSET_STATUS = 0x80000000,
