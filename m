Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSDJFVL>; Wed, 10 Apr 2002 01:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSDJFVK>; Wed, 10 Apr 2002 01:21:10 -0400
Received: from harddata.com ([216.123.194.198]:41745 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S312447AbSDJFVK>;
	Wed, 10 Apr 2002 01:21:10 -0400
Date: Tue, 9 Apr 2002 23:20:39 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tossati <marcelo@conectiva.com.br>
Subject: [PATCH] more missing <linux/init.h>
Message-ID: <20020409232039.B21063@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run into a missing "#include <linux/init.h>" on Alpha in another
place then init/do_mounts.c (see recent messages from Jurriaan
and Al Viro).  To avoid syntax errors one needs also this:

--- linux-2.4.19-pre/fs/nfsd/nfsctl.c~	Tue Apr  9 22:36:41 2002
+++ linux-2.4.19-pre/fs/nfsd/nfsctl.c	Tue Apr  9 23:05:59 2002
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/init.h>
 
 #include <linux/nfs.h>
 #include <linux/sunrpc/svc.h>


   Michal
