Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTIIVhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbTIIVhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:37:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:24791 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264505AbTIIVhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:37:21 -0400
Date: Tue, 9 Sep 2003 14:36:56 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, intermezzo-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Get rid of Intermezzo warning
Message-Id: <20030909143656.47978506.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.0-test5 there is a leftover MOD_ warning in intermezzo,  since it sets
owner on the file system operations there should be no need for explicit
module manipulation.

diff -Nru a/fs/intermezzo/inode.c b/fs/intermezzo/inode.c
--- a/fs/intermezzo/inode.c	Tue Sep  9 11:21:57 2003
+++ b/fs/intermezzo/inode.c	Tue Sep  9 11:21:57 2003
@@ -167,7 +167,6 @@
 exit:
         CDEBUG(D_MALLOC, "after umount: kmem %ld, vmem %ld\n",
                presto_kmemory, presto_vmemory);
-        MOD_DEC_USE_COUNT;
         return ;
 }
 
