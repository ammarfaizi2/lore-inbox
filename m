Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSIAIvY>; Sun, 1 Sep 2002 04:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSIAIvY>; Sun, 1 Sep 2002 04:51:24 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:21769 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316580AbSIAIvX>; Sun, 1 Sep 2002 04:51:23 -0400
Date: Sun, 1 Sep 2002 10:55:24 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: davem@redhat.com, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org
Subject: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020901085524.GB32122@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 5 days, 8:49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against 2.4.20-pre5 - fix up the type of nlink_t. This makes jfs and
reiserfs stop complaining about comparisons always turning up false
due to limited range of data type.

T.

--- linux-2.4.19/include/asm-sparc/posix_types.h	2000-01-16 07:08:29.000000000 +0100
+++ linux-2.4.20-pre5/include/asm-sparc/posix_types.h	2002-09-01 10:41:35.000000000 +0200
@@ -21,7 +21,7 @@
 typedef unsigned long          __kernel_ino_t;
 typedef unsigned short         __kernel_mode_t;
 typedef unsigned short         __kernel_umode_t;
-typedef short                  __kernel_nlink_t;
+typedef unsigned short         __kernel_nlink_t;
 typedef long                   __kernel_daddr_t;
 typedef long                   __kernel_off_t;
 typedef char *                 __kernel_caddr_t;
