Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315823AbSEJHSJ>; Fri, 10 May 2002 03:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315824AbSEJHSI>; Fri, 10 May 2002 03:18:08 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:5812 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315823AbSEJHSH>;
	Fri, 10 May 2002 03:18:07 -0400
Date: Fri, 10 May 2002 17:17:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
        Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] fix one of Re: 2.5.15 warnings
Message-Id: <20020510171716.1fb6d15b.sfr@canb.auug.org.au>
In-Reply-To: <26949.1021006885@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, 10 May 2002 15:01:25 +1000 Keith Owens <kaos@ocs.com.au> wrote:
>
> fs/dnotify.c: In function `__inode_dir_notify':
> fs/dnotify.c:139: warning: label `out' defined but not used

Obvious fix below.  (I removed the only goto ...)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.15/fs/dnotify.c 2.5.15-sfr/fs/dnotify.c
--- 2.5.15/fs/dnotify.c	Fri May 10 09:35:13 2002
+++ 2.5.15-sfr/fs/dnotify.c	Fri May 10 17:03:41 2002
@@ -135,7 +135,6 @@
 	}
 	if (changed)
 		redo_inode_mask(inode);
-out:
 	write_unlock(&dn_lock);
 }
 
