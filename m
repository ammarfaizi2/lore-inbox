Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266423AbSKGJPn>; Thu, 7 Nov 2002 04:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266419AbSKGJOh>; Thu, 7 Nov 2002 04:14:37 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10642 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266417AbSKGJOB>; Thu, 7 Nov 2002 04:14:01 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 7 Nov 2002 11:19:36 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] 01_v4l2-api-fix
Message-ID: <20021107101936.GA1939@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch fixes a ioctl numbering flaw of the new v4l2 API,
found by davem.

Without this we get compile errors because tables based upon
ioctl number end up having duplicate entries.

Please apply,

  Gerd

--- linux-2.5.46/include/linux/videodev2.h	2002-11-07 09:20:16.000000000 +0100
+++ linux/include/linux/videodev2.h	2002-11-07 09:22:16.000000000 +0100
@@ -819,7 +819,7 @@
 #define VIDIOC_G_JPEGCOMP	_IOR  ('V', 61, struct v4l2_jpegcompression)
 #define VIDIOC_S_JPEGCOMP	_IOW  ('V', 62, struct v4l2_jpegcompression)
 #define VIDIOC_QUERYSTD      	_IOR  ('V', 63, v4l2_std_id)
-#define VIDIOC_TRY_FMT      	_IOWR ('V', 63, struct v4l2_format)
+#define VIDIOC_TRY_FMT      	_IOWR ('V', 64, struct v4l2_format)
 
 #define BASE_VIDIOC_PRIVATE	192		/* 192-255 are private */
 

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
