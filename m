Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTAQQKN>; Fri, 17 Jan 2003 11:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTAQQJ3>; Fri, 17 Jan 2003 11:09:29 -0500
Received: from [193.126.32.23] ([193.126.32.23]:35236 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id <S267544AbTAQQI7>; Fri, 17 Jan 2003 11:08:59 -0500
Date: Fri, 17 Jan 2003 16:17:52 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG/PATCH] OSS/sb_mixer.c is broken on 2.5.59
Message-ID: <20030117161752.GC14939@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

I know OSS is not all that supported, but it has been mostly working for 
the past 2.5 revisions. However, 2.5.59 broke it. Here is the fix, it 
allows sound/oss/sb_mixer.c to comple again -- I havent booted it yet, 
but its trivial enough to spot it from a mile away :)

Regards,


		Nuno

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sb_mixer.c.diff"

--- linux-2.5.59/sound/oss/sb_mixer.c.orig	Fri Jan 17 15:40:41 2003
+++ linux-2.5.59/sound/oss/sb_mixer.c	Fri Jan 17 15:40:55 2003
@@ -45,7 +45,7 @@
 					SOUND_MASK_TREBLE|SOUND_MASK_SPEAKER )
 
 #define SB16_RECORDING_DEVICES		(SOUND_MASK_SYNTH | \
-					SOUND_MASK_LINE | \ SOUND_MASK_MIC | \
+					SOUND_MASK_LINE | SOUND_MASK_MIC | \
 					SOUND_MASK_CD)
 
 #define SB16_OUTFILTER_DEVICES		(SOUND_MASK_LINE | SOUND_MASK_MIC | \
@@ -55,7 +55,7 @@
 					SOUND_MASK_SPEAKER | \
 					SOUND_MASK_LINE | SOUND_MASK_MIC | \
 					SOUND_MASK_CD | SOUND_MASK_IGAIN | \
-					SOUND_MASK_OGAIN | \ SOUND_MASK_VOLUME | \
+					SOUND_MASK_OGAIN | SOUND_MASK_VOLUME | \
 					SOUND_MASK_BASS | SOUND_MASK_TREBLE | \
 					SOUND_MASK_IMIX)
 

--mYCpIKhGyMATD0i+--
