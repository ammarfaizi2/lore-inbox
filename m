Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263318AbRFACgr>; Thu, 31 May 2001 22:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263320AbRFACgi>; Thu, 31 May 2001 22:36:38 -0400
Received: from patan.Sun.COM ([192.18.98.43]:30930 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S263318AbRFACgZ>;
	Thu, 31 May 2001 22:36:25 -0400
Message-ID: <3B17000D.D6E54DA0@sun.com>
Date: Thu, 31 May 2001 19:38:05 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] almost forgot this one
Content-Type: multipart/mixed;
 boundary="------------4C19F67B85BA3C51FE18F0B4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4C19F67B85BA3C51FE18F0B4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Add a rwproc entry to the ide structure, for recalling what happened last
time!

Please let me knwo if there are any problems with this patch (some of the
patches I sent earlier depend on this).

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------4C19F67B85BA3C51FE18F0B4
Content-Type: text/plain; charset=us-ascii;
 name="ide-rwproc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-rwproc.diff"

diff -ruN dist-2.4.5/include/linux/ide.h ../cobalt-2.4.5/include/linux/ide.h
--- dist-2.4.5/include/linux/ide.h	Thu May 31 18:22:46 2001
+++ ../cobalt-2.4.5/include/linux/ide.h	Thu May 31 14:33:16 2001
@@ -284,6 +284,7 @@
 	unsigned long service_time;	/* service time of last request */
 	unsigned long timeout;		/* max time to wait for irq */
 	special_t	special;	/* special action flags */
+	void	 *rwproc_cache;		/* last rwproc update */
 	byte     keep_settings;		/* restore settings after drive reset */
 	byte     using_dma;		/* disk is using dma for read/write */
 	byte     waiting_for_dma;	/* dma currently in progress */

--------------4C19F67B85BA3C51FE18F0B4--

