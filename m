Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVADLIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVADLIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVADLIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:08:46 -0500
Received: from imag.imag.fr ([129.88.30.1]:52985 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261152AbVADLIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:08:42 -0500
Date: Tue, 4 Jan 2005 12:08:39 +0100 (MET)
From: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
X-X-Sender: colbuse@ensisun
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]vt.c, kernel 2.6.10 (also applies to 2.4.28 and 2.2.26).
In-Reply-To: <Pine.GSO.4.40.0501040904430.2249-500000@ensisun>
Message-ID: <Pine.GSO.4.40.0501041203310.2249-100000@ensisun>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Tue, 04 Jan 2005 12:08:40 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sorry, my attachements are not well readable.
This is the 2.6.10 patch :

--- old/drivers/char/vt.c       2004-12-24 22:35:25.000000000 +0100
+++ patched/drivers/char/vt.c   2005-01-04 10:37:46.000000000 +0100
@@ -1847,7 +1847,7 @@
                        csi_J(currcons, 2);
                        video_erase_char =
                                (video_erase_char & 0xff00) | ' ';
-                       do_update_region(currcons, origin,
screenbuf_size/2);
+                       update_region(currcons, origin, screenbuf_size/2);
                }
                return;
        case ESsetG0:



----------------------------------------
This is the 2.4.28 patch :

--- old/drivers/char/console.c  2005-01-03 15:51:22.000000000 +0100
+++ patched/drivers/char/console.c      2005-01-03 15:31:45.000000000
+0100
@@ -1781,7 +1781,7 @@
                        csi_J(currcons, 2);
                        video_erase_char =
                                (video_erase_char & 0xff00) | ' ';
-                       do_update_region(currcons, origin,
screenbuf_size/2);
+                       update_region(currcons, origin, screenbuf_size/2);
                }
                return;
        case ESsetG0:



----------------------------------------
This is the 2.2.26 patch :

--- old/drivers/char/console.c  Mon Sep 16 18:26:11 2002
+++ patched/drivers/char/console.c      Tue Jan  4 09:54:58 2005
@@ -1742,7 +1742,7 @@
                        csi_J(currcons, 2);
                        video_erase_char =
                                (video_erase_char & 0xff00) | ' ';
-                       do_update_region(currcons, origin,
screenbuf_size/2);
+                       update_region(currcons, origin, screenbuf_size/2);
                }
                return;
        case ESsetG0:




----------------------------------------
This is the README file the linux-kernel mailing list FAQ recommands :

DEC screen alignment test bug fix Emmanuel Colbus
<emmanuel.colbus@ensimag.imag.fr>


