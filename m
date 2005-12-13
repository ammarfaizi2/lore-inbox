Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVLMNSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVLMNSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVLMNSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:18:01 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:61319 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932075AbVLMNSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:18:00 -0500
Date: Tue, 13 Dec 2005 11:17:43 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ext2: trivial indentation fix.
Message-Id: <20051213111743.17f96151.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 This memset() line was indented with seven spaces, this patch fixes
it to use a tab instead. Yes, very trivial but it's the third time
I have to look at this line..

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 fs/ext2/dir.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 5b5f528..7442bdd 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -592,7 +592,7 @@ int ext2_make_empty(struct inode *inode,
 		goto fail;
 	}
 	kaddr = kmap_atomic(page, KM_USER0);
-       memset(kaddr, 0, chunk_size);
+	memset(kaddr, 0, chunk_size);
 	de = (struct ext2_dir_entry_2 *)kaddr;
 	de->name_len = 1;
 	de->rec_len = cpu_to_le16(EXT2_DIR_REC_LEN(1));


-- 
Luiz Fernando N. Capitulino
