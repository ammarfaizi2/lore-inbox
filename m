Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290635AbSARITO>; Fri, 18 Jan 2002 03:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290636AbSARISz>; Fri, 18 Jan 2002 03:18:55 -0500
Received: from [203.117.131.12] ([203.117.131.12]:6067 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S290635AbSARISs>; Fri, 18 Jan 2002 03:18:48 -0500
Message-ID: <3C47DA61.3060405@metaparadigm.com>
Date: Fri, 18 Jan 2002 16:18:41 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020112
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/video/modedb.c - 1400x1050 fbdev mode timings
In-Reply-To: <Pine.BSF.4.44.0201172330570.89288-100000@shell.unixbox.com>
Content-Type: multipart/mixed;
 boundary="------------080801040406080408040802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080801040406080408040802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Ani,

Here's another one people might find useful - these are the timings detected
using the radeon BIOS registers for my 1400x1050 LCD. Someone might find these
useful if their XGA panel geometry can't be detected as there are currently
no 1400x1050 modes defined in modedb.c

cheers,
~mc

Ani Joshi wrote:

> Hi Michael,
> 
> Thanks for the patch, I will merge it in tomorrow and release an updated
> version of the driver soon after.
> 
> 
> ani
> 
> 
> On Thu, 17 Jan 2002, Michael Clark wrote:
[snip]
>>BTW - Also, here is my patch to radeonfb to detect panel geometry using
>>radeon BIOS registers on Radeon Mobility M6 chipset.
>>
>>   http://gort.metaparadigm.com/radeonfb/radeon-bios-dfpinfo-2.patch


--------------080801040406080408040802
Content-Type: text/plain;
 name="1400x1050-fbmode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1400x1050-fbmode.patch"

--- linux-2.4.18-pre2-radeonfix-orig/drivers/video/modedb.c	Mon Jan 14 11:53:26 2002
+++ linux-2.4.18-pre2-radeonfix/drivers/video/modedb.c	Tue Jan 15 00:51:22 2002
@@ -127,6 +127,10 @@
 	NULL, 61, 1280, 1024, 9090, 200, 48, 26, 1, 184, 3,
 	0, FB_VMODE_NONINTERLACED
     }, {
+	/* 1400x1050 @ 60Hz, 63.9 kHz hsync */
+	NULL, 68, 1400, 1050, 9259, 136, 40, 13, 1, 112, 3,
+	0, FB_VMODE_NONINTERLACED
+    }, {
 	/* 1024x768 @ 85 Hz, 70.24 kHz hsync */
 	NULL, 85, 1024, 768, 10111, 192, 32, 34, 14, 160, 6,
 	0, FB_VMODE_NONINTERLACED

--------------080801040406080408040802--

