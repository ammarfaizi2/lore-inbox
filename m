Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbSJMSoU>; Sun, 13 Oct 2002 14:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJMSoU>; Sun, 13 Oct 2002 14:44:20 -0400
Received: from h-64-105-34-19.SNVACAID.covad.net ([64.105.34.19]:12416 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261558AbSJMSoT>; Sun, 13 Oct 2002 14:44:19 -0400
Date: Sun, 13 Oct 2002 11:24:52 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: okir@monad.swb.de, neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.42/net/sunrpc/sunrpc_syms.c - symbols needed by new nfsd
Message-ID: <20021013112452.A286@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	nfsd in 2.5.42 needs a bunch of symbols that the sunrpc module
does not export.  This patch adds them to net/sunrpc/sunrpc_syms.c.
I am now running the nfsd and sunrpc modules based on this patch.

	I suspect that some of symbol exports in this patch may need
to be bracketed in some kind of #ifdef CONFIG_foo....#endif conditionals.

	Also, I know that having a central exports file like
sunrpc_syms.c impedes efforts to split the module if it turns out
that some users of it only need certain functions, but I thought I
ought to keep this patch as small as possible.  I would be happy to
make a patch to move the EXPORT_SYMBOL declarations in sunrpc_syms.c
to the files that actually define them if there is interest.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sunrpc.diff"

--- linux-2.5.42/net/sunrpc/sunrpc_syms.c	2002-10-11 21:22:18.000000000 -0700
+++ linux/net/sunrpc/sunrpc_syms.c	2002-10-13 11:15:13.000000000 -0700
@@ -111,6 +111,24 @@
 EXPORT_SYMBOL(nlm_debug);
 #endif
 
+EXPORT_SYMBOL(add_hex);
+EXPORT_SYMBOL(add_word);
+EXPORT_SYMBOL(auth_domain_find);
+EXPORT_SYMBOL(auth_domain_put);
+EXPORT_SYMBOL(auth_unix_add_addr);
+EXPORT_SYMBOL(auth_unix_forget_old);
+EXPORT_SYMBOL(auth_unix_lookup);
+EXPORT_SYMBOL(cache_check);
+EXPORT_SYMBOL(cache_clean);
+EXPORT_SYMBOL(cache_flush);
+EXPORT_SYMBOL(cache_fresh);
+EXPORT_SYMBOL(cache_init);
+EXPORT_SYMBOL(cache_register);
+EXPORT_SYMBOL(cache_unregister);
+EXPORT_SYMBOL(get_word);
+EXPORT_SYMBOL(svcauth_unix_purge);
+EXPORT_SYMBOL(unix_domain_find);
+
 static int __init
 init_sunrpc(void)
 {

--ikeVEW9yuYc//A+q--
