Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSFJSJ5>; Mon, 10 Jun 2002 14:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSFJSJ4>; Mon, 10 Jun 2002 14:09:56 -0400
Received: from web.lycoris.com ([64.124.185.71]:43718 "EHLO web.lycoris.com")
	by vger.kernel.org with ESMTP id <S315611AbSFJSJz>;
	Mon, 10 Jun 2002 14:09:55 -0400
Message-ID: <3D04EB4F.4030107@cheek.com>
Date: Mon, 10 Jun 2002 11:09:19 -0700
From: Joseph Cheek <joseph@cheek.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; Desktop/LX Amethyst) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: procedure for creating new ioctl?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i'd like to create a new ioctl for use in my kernels [actually i already 
have 8-)] but want to make sure that i follow any established procedure 
for creating it before requesting it be included in the kernel. 
 specifically, is there a way to ensure the ioctl number i use isn't in 
use by anyone else?  is there a central registry?

so far i've just picked an arbitrary number:

sanfrancisco:/usr/src/linux-2.4.17/include/linux# diff -Naur kd.h{.orig,}
--- kd.h.orig   Mon Jun 10 11:08:22 2002
+++ kd.h        Thu Jun  6 16:00:33 2002
@@ -177,4 +177,6 @@
    don't reuse for the time being */
 /* note: 0x4B60-0x4B6D, 0x4B70-0x4B72 used above */

+#define KDGETKEYDOWNSTATE      0x4B80  /* read kernel keydown bit */
+
 #endif /* _LINUX_KD_H */

any tips, pointers appreciated.

joe

-- 
Joseph Cheek, CTO and Founder, Lycoris
joseph@lycoris.com, www.lycoris.com
Lycoris Desktop/LX: Familiar.  Powerful.  Open.
+1 425 413-9521 voice, +1 425 671-0504 fax


