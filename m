Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWCZMYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWCZMYB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWCZMYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:24:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55300 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751279AbWCZMYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:24:00 -0500
Date: Sun, 26 Mar 2006 14:23:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: [2.6 patch] Change dash2underscore() return value to char
Message-ID: <20060326122358.GF4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

Since dash2underscore() just operates and returns chars,
I guess its safe to change the return value to a char.
With my .config, this reduces its size by 5 bytes.

   text    data     bss     dec     hex filename
   4155     152       0    4307    10d3 params.o.orig
   4150     152       0    4302    10ce params.o

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Alexey Dobriyan on:
- 4 Mar 2006

--- a/kernel/params.c
+++ b/kernel/params.c
@@ -31,7 +31,7 @@
 #define DEBUGP(fmt, a...)
 #endif
 
-static inline int dash2underscore(char c)
+static inline char dash2underscore(char c)
 {
 	if (c == '-')
 		return '_';

