Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVCJAzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVCJAzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVCJApu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:45:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:54943 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262627AbVCJAma convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:30 -0500
Cc: gregkh@suse.de
Subject: [PATCH] debugfs: fix bool built-in type.
In-Reply-To: <1110414382208@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:26:22 -0800
Message-Id: <11104143823768@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2034, 2005/03/09 15:24:27-08:00, gregkh@suse.de

[PATCH] debugfs: fix bool built-in type.

Thanks to Alessandro Rubini <rubini@gnudd.com> for pointing this out.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 fs/debugfs/file.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/fs/debugfs/file.c b/fs/debugfs/file.c
--- a/fs/debugfs/file.c	2005-03-09 16:23:02 -08:00
+++ b/fs/debugfs/file.c	2005-03-09 16:23:02 -08:00
@@ -186,7 +186,7 @@
 	char buf[3];
 	u32 *val = file->private_data;
 	
-	if (val)
+	if (*val)
 		buf[0] = 'Y';
 	else
 		buf[0] = 'N';

