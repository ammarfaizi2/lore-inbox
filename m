Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSGQFWy>; Wed, 17 Jul 2002 01:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSGQFUc>; Wed, 17 Jul 2002 01:20:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15372 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318211AbSGQFTC>;
	Wed, 17 Jul 2002 01:19:02 -0400
Message-ID: <3D3500CD.174DB02E@zip.com.au>
Date: Tue, 16 Jul 2002 22:29:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 6/13] restore CHECK_EMERGENCY_SYNC.  Again.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Put the CHECK_EMERGENCY_SYNC back into the kupdate function.  I seem to
keep removing it.



 page-writeback.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- 2.5.26/mm/page-writeback.c~check_emergency_sync	Tue Jul 16 21:46:35 2002
+++ 2.5.26-akpm/mm/page-writeback.c	Tue Jul 16 21:59:38 2002
@@ -19,7 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/init.h>
-//#include <linux/sysrq.h>
+#include <linux/sysrq.h>
 #include <linux/backing-dev.h>
 #include <linux/mpage.h>
 
@@ -171,6 +171,8 @@ static void background_writeout(unsigned
 	long min_pages = _min_pages;
 	int nr_to_write;
 
+	CHECK_EMERGENCY_SYNC
+
 	do {
 		struct page_state ps;
 

.
