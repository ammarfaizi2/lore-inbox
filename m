Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbULLTxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbULLTxD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbULLTws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:52:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60945 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262096AbULLTu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:50:57 -0500
Date: Sun, 12 Dec 2004 20:50:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove unused
Message-ID: <20041212195047.GH22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't able to find any usage of this file (it seems the 
EXPORT_SYMBOL's were moved away, but deleting the filw was forgotten).


diffstat output:
 net/sunrpc/auth_gss/sunrpcgss_syms.c |   37 ---------------------------
 1 files changed, 37 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/sunrpcgss_syms.c	2004-10-18 23:54:39.000000000 +0200
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,37 +0,0 @@
-#include <linux/config.h>
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/sched.h>
-#include <linux/uio.h>
-#include <linux/unistd.h>
-
-#include <linux/sunrpc/auth_gss.h>
-#include <linux/sunrpc/svcauth_gss.h>
-#include <linux/sunrpc/gss_asn1.h>
-#include <linux/sunrpc/gss_krb5.h>
-
-/* svcauth_gss.c: */
-EXPORT_SYMBOL(svcauth_gss_register_pseudoflavor);
-
-/* registering gss mechanisms to the mech switching code: */
-EXPORT_SYMBOL(gss_mech_register);
-EXPORT_SYMBOL(gss_mech_unregister);
-EXPORT_SYMBOL(gss_mech_get);
-EXPORT_SYMBOL(gss_mech_get_by_pseudoflavor);
-EXPORT_SYMBOL(gss_mech_get_by_name);
-EXPORT_SYMBOL(gss_mech_put);
-EXPORT_SYMBOL(gss_pseudoflavor_to_service);
-EXPORT_SYMBOL(gss_service_to_auth_domain_name);
-
-/* generic functionality in gss code: */
-EXPORT_SYMBOL(g_make_token_header);
-EXPORT_SYMBOL(g_verify_token_header);
-EXPORT_SYMBOL(g_token_size);
-EXPORT_SYMBOL(make_checksum);
-EXPORT_SYMBOL(krb5_encrypt);
-EXPORT_SYMBOL(krb5_decrypt);
-
-/* debug */
-EXPORT_SYMBOL(print_hexl);
