Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284842AbRLZU0Q>; Wed, 26 Dec 2001 15:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284876AbRLZU0H>; Wed, 26 Dec 2001 15:26:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:18184 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284842AbRLZU0D>; Wed, 26 Dec 2001 15:26:03 -0500
Date: Wed, 26 Dec 2001 17:11:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.17: Dell Laptop extra buttons patch (fwd)
Message-ID: <Pine.LNX.4.21.0112261711200.9973-200000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=9jxsPFA5p3P2qPhR
Content-ID: <Pine.LNX.4.21.0112261711201.9973@freak.distro.conectiva>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--9jxsPFA5p3P2qPhR
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0112261711202.9973@freak.distro.conectiva>
Content-Disposition: INLINE


Could someone with Dell laptops test this for me ?

Thanks 


---------- Forwarded message ----------
Date: Wed, 26 Dec 2001 20:14:11 +0000
From: Alan Ford <alan@whirlnet.co.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 2.4.17: Dell Laptop extra buttons patch

Hi Marcelo,

Would you consider adding this patch to the next kernel release? I've been
using it for a while, and since there is now the Dell laptop module for 
extra BIOS features available in the kernel it seems this patch could be 
appropriate and useful to include. It adds keycodes for the four shortcut 
buttons that are provided on Dell Inspiron laptops.

Regards,
Alan
-- 
Alan Ford * alan@whirlnet.co.uk 

--9jxsPFA5p3P2qPhR
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-ID: <Pine.LNX.4.21.0112261711203.9973@freak.distro.conectiva>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=dell-inspiron-buttons-patch

--- linux/drivers/char/pc_keyb.c.old	Wed Dec 26 19:06:21 2001
+++ linux/drivers/char/pc_keyb.c	Wed Dec 26 19:08:13 2001
@@ -228,9 +228,17 @@
 #define E0_MSLW	125
 #define E0_MSRW	126
 #define E0_MSTM	127
+/*
+ * Dell Inspiron Laptop Keyboard has four shortcut buttons
+ * e0 01 - e0 04  [alan@whirlnet.co.uk]
+ */
+#define E0_DELL1 121
+#define E0_DELL2 122
+#define E0_DELL3 123
+#define E0_DELL4 124
 
 static unsigned char e0_keys[128] = {
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x00-0x07 */
+  0, E0_DELL1, E0_DELL2, E0_DELL3, E0_DELL4, 0, 0, 0, /* 0x00-0x07 */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x08-0x0f */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x10-0x17 */
   0, 0, 0, 0, E0_KPENTER, E0_RCTRL, 0, 0,	      /* 0x18-0x1f */

--9jxsPFA5p3P2qPhR--
