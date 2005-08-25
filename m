Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVHYIJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVHYIJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVHYIJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:09:29 -0400
Received: from admingilde.org ([213.95.32.146]:11142 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S964868AbVHYIJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:09:28 -0400
Date: Thu, 25 Aug 2005 10:09:24 +0200
From: Martin Waitz <tali@admingilde.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DocBook: fix kernel-api documentation generation
Message-ID: <20050825080924.GS9530@admingilde.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: fix kernel-api documentation generation

This patch changes a macro definition so that kernel-doc can understand it.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 include/sound/pcm.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-docbook/include/sound/pcm.h
===================================================================
--- linux-docbook.orig/include/sound/pcm.h	2005-07-29 12:46:13.000000000 +0200
+++ linux-docbook/include/sound/pcm.h	2005-08-12 11:10:20.000000000 +0200
@@ -911,11 +911,10 @@ int snd_pcm_format_big_endian(snd_pcm_fo
  * Returns 1 if the given PCM format is CPU-endian, 0 if
  * opposite, or a negative error code if endian not specified.
  */
-/* int snd_pcm_format_cpu_endian(snd_pcm_format_t format); */
 #ifdef SNDRV_LITTLE_ENDIAN
-#define snd_pcm_format_cpu_endian	snd_pcm_format_little_endian
+#define snd_pcm_format_cpu_endian(format) snd_pcm_format_little_endian(format)
 #else
-#define snd_pcm_format_cpu_endian	snd_pcm_format_big_endian
+#define snd_pcm_format_cpu_endian(format) snd_pcm_format_big_endian(format)
 #endif
 int snd_pcm_format_width(snd_pcm_format_t format);			/* in bits */
 int snd_pcm_format_physical_width(snd_pcm_format_t format);		/* in bits */
