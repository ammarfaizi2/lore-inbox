Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313869AbSDIMRo>; Tue, 9 Apr 2002 08:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313874AbSDIMRn>; Tue, 9 Apr 2002 08:17:43 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:64652 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313869AbSDIMRl>;
	Tue, 9 Apr 2002 08:17:41 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15538.55969.982749.572988@argo.ozlabs.ibm.com>
Date: Tue, 9 Apr 2002 22:12:17 +1000 (EST)
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] two files need <linux/init.h>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

I have come across two files in 2.4.19-pre6 that need to include
<linux/init.h> but don't, causing compile errors on PPC.  Here is a
patch to fix that.

Thanks,
Paul.

diff -urN linux-2.4.19-pre6/fs/nfsd/nfsctl.c linuxppc-merge/fs/nfsd/nfsctl.c
--- linux-2.4.19-pre6/fs/nfsd/nfsctl.c	Sun Apr  7 21:31:20 2002
+++ linuxppc-merge/fs/nfsd/nfsctl.c	Mon Apr  8 22:27:30 2002
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/init.h>
 
 #include <linux/nfs.h>
 #include <linux/sunrpc/svc.h>
diff -urN linux-2.4.19-pre6/init/do_mounts.c linuxppc-merge/init/do_mounts.c
--- linux-2.4.19-pre6/init/do_mounts.c	Sun Apr  7 21:31:31 2002
+++ linuxppc-merge/init/do_mounts.c	Tue Apr  9 20:53:47 2002
@@ -7,6 +7,7 @@
 #include <linux/blk.h>
 #include <linux/fd.h>
 #include <linux/tty.h>
+#include <linux/init.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
