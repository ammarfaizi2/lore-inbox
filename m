Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317817AbSFSIwn>; Wed, 19 Jun 2002 04:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317820AbSFSIwm>; Wed, 19 Jun 2002 04:52:42 -0400
Received: from hera.cwi.nl ([192.16.191.8]:55510 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317817AbSFSIwm>;
	Wed, 19 Jun 2002 04:52:42 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 19 Jun 2002 10:52:41 +0200 (MEST)
Message-Id: <UTC200206190852.g5J8qfS01101.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] tiny compilation fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -r -u linux-2.5.23/linux/fs/smbfs/sock.c linux-2.5.23a/linux/fs/smbfs/sock.c
--- linux-2.5.23/linux/fs/smbfs/sock.c	Sun Jun  9 07:28:55 2002
+++ linux-2.5.23a/linux/fs/smbfs/sock.c	Wed Jun 19 10:35:39 2002
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/netdevice.h>
 #include <linux/smp_lock.h>
+#include <linux/tqueue.h>
 #include <net/scm.h>
 #include <net/ip.h>
 


This, and the smp fix, makes my kernel compile.
However, just like 2.5.22 also 2.5.23 hangs at boot with

hda: status error: status=0x58 [ drive ready seek complete data request ]
hda: recalibrating...

Andries
