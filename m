Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSEGBKi>; Mon, 6 May 2002 21:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSEGBKf>; Mon, 6 May 2002 21:10:35 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:696 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315275AbSEGBKb>;
	Mon, 6 May 2002 21:10:31 -0400
Date: Tue, 7 May 2002 11:09:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: TRIVIAL: Remove warning in fs/nfs/nfsroot.c
Message-ID: <20020507010911.GC1163@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  The patch below removes a warning in
fs/nfs/nfsroot.c by including a header file providing a prototype for
in_aton().

diff -urN /home/dgibson/kernel/linuxppc-2.5/fs/nfs/nfsroot.c linux-bluefish/fs/nfs/nfsroot.c
--- /home/dgibson/kernel/linuxppc-2.5/fs/nfs/nfsroot.c	Fri May  3 22:39:18 2002
+++ linux-bluefish/fs/nfs/nfsroot.c	Tue May  7 10:55:29 2002
@@ -80,6 +80,7 @@
 #include <linux/in.h>
 #include <linux/major.h>
 #include <linux/utsname.h>
+#include <linux/inet.h>
 #include <net/ipconfig.h>
 
 /* Define this to allow debugging output */


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
