Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316469AbSEUAoQ>; Mon, 20 May 2002 20:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316473AbSEUAoQ>; Mon, 20 May 2002 20:44:16 -0400
Received: from nacho.alt.net ([207.14.113.18]:16908 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id <S316469AbSEUAoO>;
	Mon, 20 May 2002 20:44:14 -0400
Date: Mon, 20 May 2002 17:44:10 -0700 (PDT)
From: Chris Caputo <ccaputo@alt.net>
To: netdev@oss.sgi.com
cc: linux-kernel@vger.kernel.org, <linux-net@vger.kernel.org>
Subject: [PATCH] net/core/sock.c - 2.4.18
Message-ID: <Pine.LNX.4.44.0205201738180.19839-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects a typo in net/core/sock.c.  The assignment to
sysctl_wmem_default was done twice in a row, rather than to
sysctl_wmem_default and sysctl_rmem_default.

This patch applies to 2.4.18.

Chris

--- net/core/sock.c.orig        Fri Dec 21 09:42:05 2001
+++ net/core/sock.c     Mon May 20 17:35:43 2002
@@ -626,7 +626,7 @@
                sysctl_wmem_max = 32767;
                sysctl_rmem_max = 32767;
                sysctl_wmem_default = 32767;
-               sysctl_wmem_default = 32767;
+               sysctl_rmem_default = 32767;
        } else if (num_physpages >= 131072) {
                sysctl_wmem_max = 131071;
                sysctl_rmem_max = 131071;

