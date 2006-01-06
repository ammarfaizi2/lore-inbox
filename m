Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWAFPQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWAFPQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWAFPQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:16:45 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:63897 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750869AbWAFPQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:16:45 -0500
Date: Fri, 6 Jan 2006 12:07:12 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: "<sergeh"@us.ibm.com, jaegert@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] xfrm: Sparse warning fix.
Message-Id: <20060106120712.019fdefe.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Fixes the following sparse warning:

security/selinux/xfrm.c:155:10: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 security/selinux/xfrm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index c4d87d4..16eb183 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -152,7 +152,7 @@ static int selinux_xfrm_sec_ctx_alloc(st
 	return rc;
 
 out:
-	*ctxp = 0;
+	*ctxp = NULL;
 	kfree(ctx);
 	return rc;
 }


-- 
Luiz Fernando N. Capitulino
