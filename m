Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264107AbUEHT2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbUEHT2F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 15:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUEHT2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 15:28:05 -0400
Received: from ns.suse.de ([195.135.220.2]:13213 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264107AbUEHT2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 15:28:01 -0400
Date: Sat, 8 May 2004 21:27:34 +0200
From: Olaf Hering <olh@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make tags for selinux
Message-ID: <20040508192734.GA21621@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make tags skips security/selinux/include because of
find . -name include -prune
This patch does just add it later. No idea if it can be done better.


--- linux-2.6.5.orig/Makefile	2004-05-08 13:04:16.000000000 +0200
+++ linux-2.6.5/Makefile	2004-05-08 21:14:06.808888847 +0200
@@ -1001,6 +1001,8 @@ define all-sources
 	       -name '*.[chS]' -print; \
 	  find arch/$(ARCH) $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
+	  find security/selinux/include $(RCS_FIND_IGNORE) \
+	       -name '*.[chS]' -print; \
 	  find include $(RCS_FIND_IGNORE) \
 	       \( -name config -o -name 'asm-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
