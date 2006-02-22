Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWBVIoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWBVIoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 03:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWBVIoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 03:44:00 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:29969 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932570AbWBVIoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 03:44:00 -0500
Date: Wed, 22 Feb 2006 16:43:26 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: [PATCH] autofs4 - second try - set fields size for pipe packet
Message-ID: <Pine.LNX.4.64.0602221633520.19127@eagle.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have made almost all the changes recommended by Christoph.

I'm reluctant to change the type of autofs_wqt_t as it is part of the 
existing autofs4 struture. While such a change shouldn't cause a problem 
I'd rather not change what's been there for a long time just in case there 
are unexpected side effects.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.16-rc4-mm1/include/linux/auto_fs4.h.set-fields-size-for-packet	2006-02-22 16:07:57.000000000 +0800
+++ linux-2.6.16-rc4-mm1/include/linux/auto_fs4.h	2006-02-22 16:08:29.000000000 +0800
@@ -65,11 +65,11 @@ struct autofs_v5_packet {
 	autofs_wqt_t wait_queue_token;
 	__u32 dev;
 	__u64 ino;
-	uid_t uid;
-	gid_t gid;
-	pid_t pid;
-	pid_t tgid;
-	int len;
+	__u32 uid;
+	__u32 gid;
+	__u32 pid;
+	__u32 tgid;
+	__u32 len;
 	char name[NAME_MAX+1];
 };
 
