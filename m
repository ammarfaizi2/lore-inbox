Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTEZW0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTEZW0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:26:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49546 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262321AbTEZWTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:19:39 -0400
Date: Mon, 26 May 2003 19:30:44 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: AA's 00_backout_gcc_3-0-patch-1
Message-ID: <Pine.LNX.4.55L.0305261929460.30175@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea,

For what reason are you doing this?

diff -urN 2.4.6pre3/kernel/timer.c backoutgcc/kernel/timer.c
--- 2.4.6pre3/kernel/timer.c	Wed Jun 13 04:02:52 2001
+++ backoutgcc/kernel/timer.c	Wed Jun 13 15:49:13 2001
@@ -32,7 +32,7 @@
 long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */

 /* The current time */
-struct timeval xtime __attribute__ ((aligned (16)));
+volatile struct timeval xtime __attribute__ ((aligned (16)));

 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */

