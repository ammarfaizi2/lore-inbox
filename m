Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTD2Ncc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTD2Ncc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:32:32 -0400
Received: from verein.lst.de ([212.34.181.86]:62480 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262005AbTD2Nca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:32:30 -0400
Date: Tue, 29 Apr 2003 15:44:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] update dcache documentation
Message-ID: <20030429154444.B23413@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the dcache section in Documentation/filesystems/Locking to match
reality.  Note that there's other parts of this file that are badly out
of date - I'll look into it later.


--- 1.40/Documentation/filesystems/Locking	Fri Feb 14 21:26:42 2003
+++ edited/Documentation/filesystems/Locking	Mon Apr 21 10:54:15 2003
@@ -18,13 +18,13 @@
 
 locking rules:
 	none have BKL
-		dcache_lock	may block
-d_revalidate:	no		yes
-d_hash		no		yes
-d_compare:	no		no 
-d_delete:	yes		no
-d_release:	no		yes
-d_iput:		no		yes
+		dcache_lock	rename_lock	->d_lock	may block
+d_revalidate:	no		no		no		yes
+d_hash		no		no		no		yes
+d_compare:	no		yes		no		no 
+d_delete:	yes		no		yes		no
+d_release:	no		no		no		yes
+d_iput:		no		no		no		yes
 
 --------------------------- inode_operations --------------------------- 
 prototypes:
