Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSGOJlR>; Mon, 15 Jul 2002 05:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317405AbSGOJlQ>; Mon, 15 Jul 2002 05:41:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:54245 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317404AbSGOJlQ>;
	Mon, 15 Jul 2002 05:41:16 -0400
Message-ID: <3D329983.706EB4C6@gmx.net>
Date: Mon, 15 Jul 2002 11:44:35 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: patch(2.4.19rc1): radio zoltrix typo
Content-Type: multipart/mixed;
 boundary="------------6B82A139C3C7650FD66B05E5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6B82A139C3C7650FD66B05E5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
this fixes the stereo indicator for the zoltrix radio card.
Marcelo, apply to 2.4.19 please.

Regards, Gunther


--- linux-2.4.19-rc1/drivers/media/radio/radio-zoltrix-orig     Mon Jul
15 11:34:06 2002
+++ linux-2.4.19-rc1/drivers/media/radio/radio-zoltrix.c        Mon Jul
15 11:36:51 2002
@@ -23,6 +23,7 @@
  *             (can detect if station is in stereo)
  *           - Added unmute function
  *           - Reworked ioctl functions
+ * 2002-07-15 - Fix Stereo typo
  */

 #include <linux/module.h>      /* Modules                        */
@@ -280,7 +281,7 @@
                        struct video_audio v;
                        memset(&v, 0, sizeof(v));
                        v.flags |= VIDEO_AUDIO_MUTABLE |
VIDEO_AUDIO_VOLUME;
-                       v.mode != zol_is_stereo(zol)
+                       v.mode |= zol_is_stereo(zol)
                                ? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO;

                        v.volume = zol->curvol * 4096;
                        v.step = 4096;




--------------6B82A139C3C7650FD66B05E5
Content-Type: text/plain; charset=us-ascii;
 name="gmdiff-lx2419rc1-radio-zoltrix-stereo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gmdiff-lx2419rc1-radio-zoltrix-stereo"

--- linux-2.4.19-rc1/drivers/media/radio/radio-zoltrix-orig	Mon Jul 15 11:34:06 2002
+++ linux-2.4.19-rc1/drivers/media/radio/radio-zoltrix.c	Mon Jul 15 11:36:51 2002
@@ -23,6 +23,7 @@
  *		(can detect if station is in stereo)
  *	      - Added unmute function
  *	      - Reworked ioctl functions
+ * 2002-07-15 - Fix Stereo typo
  */
 
 #include <linux/module.h>	/* Modules                        */
@@ -280,7 +281,7 @@
 			struct video_audio v;
 			memset(&v, 0, sizeof(v));
 			v.flags |= VIDEO_AUDIO_MUTABLE | VIDEO_AUDIO_VOLUME;
-			v.mode != zol_is_stereo(zol)
+			v.mode |= zol_is_stereo(zol)
 				? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO;
 			v.volume = zol->curvol * 4096;
 			v.step = 4096;

--------------6B82A139C3C7650FD66B05E5--

