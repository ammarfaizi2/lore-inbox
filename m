Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWDQBmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWDQBmx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 21:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDQBmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 21:42:53 -0400
Received: from nproxy.gmail.com ([64.233.182.185]:20206 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750936AbWDQBmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 21:42:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=qeTu9IDspqQLgzROWOx60KGiRQ3vYt4qamFkwMsVnkVz/7ROAdMLP931ZTGOAfcqCR6s/0v1yboxA00A8KluUR/FVOmOIwQm3DgTRQSNrL4O4+Wb+5JRZ3S4NAVjlsF5/G17IGamW5X6P8ddxsyWgLuCWjithYMF/A0rrIbVLdg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Remove redundant NULL checks before [kv]free - in fs/
Date: Mon, 17 Apr 2006 03:29:11 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Mark Fasheh <mark.fasheh@oracle.com>,
       Kurt Hackel <kurt.hackel@oracle.com>, ocfs2-devel@oss.oracle.com,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200604170329.11589.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant NULL checks before kfree
for fs/

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/ocfs2/vote.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff -upr linux-2.6.17-rc1-git12-orig/fs/ocfs2/vote.c linux-2.6.17-rc1-git12/fs/ocfs2/vote.c
--- linux-2.6.17-rc1-git12-orig/fs/ocfs2/vote.c	2006-04-09 13:58:32.000000000 +0200
+++ linux-2.6.17-rc1-git12/fs/ocfs2/vote.c	2006-04-16 15:03:05.000000000 +0200
@@ -988,9 +988,7 @@ int ocfs2_request_mount_vote(struct ocfs
 	}
 
 bail:
-	if (request)
-		kfree(request);
-
+	kfree(request);
 	return status;
 }
 
@@ -1021,9 +1019,7 @@ int ocfs2_request_umount_vote(struct ocf
 	}
 
 bail:
-	if (request)
-		kfree(request);
-
+	kfree(request);
 	return status;
 }
 
