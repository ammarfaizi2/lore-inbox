Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143394AbREKUgL>; Fri, 11 May 2001 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143393AbREKUgC>; Fri, 11 May 2001 16:36:02 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:17927 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S143394AbREKUft>;
	Fri, 11 May 2001 16:35:49 -0400
Date: Fri, 11 May 2001 13:35:46 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: alan@lxorguk.ukuu.org.uk
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Patch for 2.4.4-ac7
Message-ID: <20010511133546.A9304@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix

http://boudicca.tux.org/hypermail/linux-kernel/this-week/0901.html


H.J.
----
--- linux-2.4.4-ac7/mm/filemap.c.module	Fri May 11 13:32:20 2001
+++ linux-2.4.4-ac7/mm/filemap.c	Fri May 11 13:33:03 2001
@@ -9,6 +9,8 @@
  * most "normal" filesystems (but you don't /have/ to use this:
  * the NFS filesystem used to do this differently, for example)
  */
+#include <linux/config.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
