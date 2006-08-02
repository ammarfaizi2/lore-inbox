Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWHBU7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWHBU7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWHBU7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:59:42 -0400
Received: from dvhart.com ([64.146.134.43]:15552 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932098AbWHBU7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:59:41 -0400
Message-ID: <44D1123B.2000602@mbligh.org>
Date: Wed, 02 Aug 2006 13:59:39 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] add newline to nfs dprintk
Content-Type: multipart/mixed;
 boundary="------------090903030706030209020608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090903030706030209020608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add missing \n to dprintk
(attatched as well, cause thunderbird is pants)

Signed-off-by: mbligh@google.com

diff -aurpN -X /home/mbligh/.diff.exclude 
linux-2.6.18-rc3/fs/lockd/clntlock.c 
linux-2.6.18-rc3-nfs_printk/fs/lockd/clntlock.c
--- linux-2.6.18-rc3/fs/lockd/clntlock.c        2006-07-31 
10:18:54.000000000 -0700
+++ linux-2.6.18-rc3-nfs_printk/fs/lockd/clntlock.c     2006-08-02 
13:56:39.000000000 -0700
@@ -160,7 +160,7 @@ static void nlmclnt_prepare_reclaim(stru
          */
         list_splice_init(&host->h_granted, &host->h_reclaim);

-       dprintk("NLM: reclaiming locks for host %s", host->h_name);
+       dprintk("NLM: reclaiming locks for host %s\n", host->h_name);
  }

  static void nlmclnt_finish_reclaim(struct nlm_host *host)

--------------090903030706030209020608
Content-Type: text/plain;
 name="linux-2.6.18-rc3-nfs_printk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.18-rc3-nfs_printk"

Add missing \n to dprintk

Signed-off-by: mbligh@google.com

diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18-rc3/fs/lockd/clntlock.c linux-2.6.18-rc3-nfs_printk/fs/lockd/clntlock.c
--- linux-2.6.18-rc3/fs/lockd/clntlock.c	2006-07-31 10:18:54.000000000 -0700
+++ linux-2.6.18-rc3-nfs_printk/fs/lockd/clntlock.c	2006-08-02 13:56:39.000000000 -0700
@@ -160,7 +160,7 @@ static void nlmclnt_prepare_reclaim(stru
 	 */
 	list_splice_init(&host->h_granted, &host->h_reclaim);
 
-	dprintk("NLM: reclaiming locks for host %s", host->h_name);
+	dprintk("NLM: reclaiming locks for host %s\n", host->h_name);
 }
 
 static void nlmclnt_finish_reclaim(struct nlm_host *host)

--------------090903030706030209020608--
