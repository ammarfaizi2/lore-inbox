Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316372AbSFJVnw>; Mon, 10 Jun 2002 17:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSFJVnv>; Mon, 10 Jun 2002 17:43:51 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:64017 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316372AbSFJVnt>;
	Mon, 10 Jun 2002 17:43:49 -0400
Date: Mon, 10 Jun 2002 21:33:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: perex@suse.cz, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kill warning in ac97_codec
Message-ID: <20020610213345.A29262@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Kill warning from xxx_bit funtions in ac97_codec.
Compiled, but no possibility to test.

Against 2.5.21.

	Sam

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ac97.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.453   -> 1.454  
#	include/sound/ac97_codec.h	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/10	sam@mars.ravnborg.org	1.454
# ac97: kill warning: passing arg 2 of `xxx_bit' from incompatible pointer type
# --------------------------------------------
#
diff -Nru a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
--- a/include/sound/ac97_codec.h	Mon Jun 10 21:31:23 2002
+++ b/include/sound/ac97_codec.h	Mon Jun 10 21:31:23 2002
@@ -160,7 +160,7 @@
 	unsigned int rates_mic_adc;
 	unsigned int spdif_status;
 	unsigned short regs[0x80]; /* register cache */
-	unsigned char reg_accessed[0x80 / 8]; /* bit flags */
+	unsigned long reg_accessed[0x80 / BITS_PER_LONG]; /* bit flags */
 	union {			/* vendor specific code */
 		struct {
 			unsigned short unchained[3];	// 0 = C34, 1 = C79, 2 = C69

--pf9I7BMVVzbSWLtt--
