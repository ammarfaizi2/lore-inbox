Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279467AbRKFOVe>; Tue, 6 Nov 2001 09:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279382AbRKFOVP>; Tue, 6 Nov 2001 09:21:15 -0500
Received: from rose.iinf.polsl.gliwice.pl ([157.158.57.35]:30240 "EHLO
	rose.iinf.polsl.gliwice.pl") by vger.kernel.org with ESMTP
	id <S279416AbRKFOVH>; Tue, 6 Nov 2001 09:21:07 -0500
Date: Tue, 6 Nov 2001 15:20:41 +0100
From: Piotr Kasprzyk <kwadrat@rose.iinf.polsl.gliwice.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.14 redundant instruction in kernel/module.c
Message-ID: <20011106152041.A4794@rose.iinf.polsl.gliwice.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.4.14.
The line below has no effect on code and can be safely removed.
Why it is there?
I have also similar patch for kernel 2.2.20.

 Piotr Kasprzyk

diff -r -u linux-2.4.14/kernel/module.c linux-2.4.14new/kernel/module.c
--- linux-2.4.14/kernel/module.c	Fri Sep 14 01:33:03 2001
+++ linux-2.4.14new/kernel/module.c	Tue Nov  6 14:57:13 2001
@@ -1189,7 +1189,6 @@
 				len = 0;
 				begin = pos;
 			}
-			pos = begin + len;
 			if (pos > offset+length)
 				goto leave_the_loop;
 		}
