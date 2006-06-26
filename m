Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933140AbWFZXtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbWFZXtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933135AbWFZXtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:49:43 -0400
Received: from mail.sdi-muenchen.de ([62.245.203.250]:16121 "EHLO
	linux.sdi-muenchen.de") by vger.kernel.org with ESMTP
	id S933139AbWFZXtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:49:42 -0400
From: Stephan =?iso-8859-1?q?M=FCller?= <smueller@chronox.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 06/06] ecryptfs: Print the actual option that is problematic
Date: Tue, 27 Jun 2006 01:49:36 +0200
User-Agent: KMail/1.9.1
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270149.36679.smueller@chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: 2.6.17-mm1

When parsing unknown mount options, the printk will now issue the 
problematic option instead of the whole option string.

Signed-off-by: Stephan Mueller <smueller@chronox.de>

---

 fs/ecryptfs/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

aef091d547149874971834ae41a3b5e3982ef679
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 3592834..e09de17 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -280,7 +280,7 @@ static int ecryptfs_parse_options(struct
 		default:
 			ecryptfs_printk(KERN_WARNING,
 					"eCryptfs: unrecognized option '%s'\n",
-					options);
+					p);
 		}
 	}
 	/* Do not support lack of mount-wide signature in 0.1
