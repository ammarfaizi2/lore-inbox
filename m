Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131101AbQLJXQA>; Sun, 10 Dec 2000 18:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131138AbQLJXPv>; Sun, 10 Dec 2000 18:15:51 -0500
Received: from zero.tech9.net ([209.61.188.187]:23044 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S131101AbQLJXPh>;
	Sun, 10 Dec 2000 18:15:37 -0500
Date: Sun, 10 Dec 2000 17:45:07 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.0 task queue updates for smbfs's sock.c
Message-ID: <Pine.LNX.4.30.0012101743140.18138-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fs/smbfs/sock.c needs updating for the new task queue as well. find the
patch below. if i find any more of these ill put together a mass patch
instead of these individual emails.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

--- linux/fs/smbfs/sock.c~      Sun Dec 10 17:40:56 2000
+++ linux/fs/smbfs/sock.c       Sun Dec 10 17:41:43 2000
@@ -163,7 +163,7 @@
                found_data(sk);
                return;
        }
-       job->cb.next = NULL;
+       INIT_LIST_HEAD(&job->cb.list);
        job->cb.sync = 0;
        job->cb.routine = smb_data_callback;
        job->cb.data = job;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
