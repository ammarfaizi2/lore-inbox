Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWARKMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWARKMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWARKMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:12:09 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:38154 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751384AbWARKMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:12:07 -0500
Date: Wed, 18 Jan 2006 18:11:32 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] autofs4 - fix typo in expire-not-busy-only patch
Message-ID: <Pine.LNX.4.64.0601181807480.9142@eagle.themaw.net>
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


Sorry, this error got through.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.16-rc1/fs/autofs4/expire.c.expire-not-busy-only-fix	2006-01-18 17:55:15.000000000 +0800
+++ linux-2.6.16-rc1/fs/autofs4/expire.c	2006-01-18 17:56:28.000000000 +0800
@@ -255,11 +255,11 @@ static struct dentry *autofs4_expire(str
 				dentry, (int)dentry->d_name.len, dentry->d_name.name);
 
 			/* Can we umount this guy */
-			if (autofs4_mount_busy(mnt, dentry)) {
+			if (autofs4_mount_busy(mnt, dentry))
 				goto next;
 
 			/* Can we expire this guy */
-			if (autofs4_can_expire(dentry, timeout, do_now))
+			if (autofs4_can_expire(dentry, timeout, do_now)) {
 				expired = dentry;
 				break;
 			}

