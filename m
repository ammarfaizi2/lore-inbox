Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317133AbSEXMUT>; Fri, 24 May 2002 08:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317132AbSEXMUS>; Fri, 24 May 2002 08:20:18 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:54994 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317133AbSEXMUQ>; Fri, 24 May 2002 08:20:16 -0400
Date: Fri, 24 May 2002 14:20:07 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Subject: [PATCH 2.5] fs/nfsd/nfs3xdr.c compile fix
Message-ID: <20020524122007.GE26918@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	hch@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent namei.h split broke nfsd compile, which is fixed by the 
following patch.

Linus, please apply.

Stelian.

===== fs/nfsd/nfs3xdr.c 1.12 vs edited =====
--- 1.12/fs/nfsd/nfs3xdr.c	Wed May 22 21:19:24 2002
+++ edited/fs/nfsd/nfs3xdr.c	Fri May 24 13:03:24 2002
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/nfs3.h>
+#include <linux/fs.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
