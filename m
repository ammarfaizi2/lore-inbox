Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129761AbQLPLIz>; Sat, 16 Dec 2000 06:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbQLPLIp>; Sat, 16 Dec 2000 06:08:45 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:24329 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129761AbQLPLIg>;
	Sat, 16 Dec 2000 06:08:36 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: f5ibh <f5ibh@db0bm.ampr.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre2, unresolved symbols 
In-Reply-To: Your message of "Sat, 16 Dec 2000 11:32:44 BST."
             <200012161032.LAA16091@db0bm.ampr.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Dec 2000 21:38:03 +1100
Message-ID: <14735.976963083@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000 11:32:44 +0100, 
f5ibh <f5ibh@db0bm.ampr.org> wrote:
>/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o
>/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_wake_up_task

Does this fix it?

Index: 0-test13-pre2.1/fs/lockd/svc.c
--- 0-test13-pre2.1/fs/lockd/svc.c Mon, 02 Oct 2000 15:28:44 +1100 kaos (linux-2.4/e/b/39_svc.c 1.1.1.2 644)
+++ 0-test13-pre2.1(w)/fs/lockd/svc.c Sat, 16 Dec 2000 21:26:35 +1100 kaos (linux-2.4/e/b/39_svc.c 1.1.1.2 644)
@@ -312,7 +312,6 @@ out:
 #ifdef MODULE
 /* New module support in 2.1.18 */
 
-EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
 MODULE_DESCRIPTION("NFS file locking service version " LOCKD_VERSION ".");
 MODULE_PARM(nlm_grace_period, "10-240l");


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
