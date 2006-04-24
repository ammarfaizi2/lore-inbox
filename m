Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWDXKWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWDXKWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 06:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWDXKWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 06:22:23 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49658 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750713AbWDXKWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 06:22:22 -0400
Date: Mon, 24 Apr 2006 12:22:20 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>
Cc: shemminger@osdl.org, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, fpavlic@de.ibm.com
Subject: [patch] ipv4: inet_init() -> fs_initcall
Message-ID: <20060424102220.GB16007@osiris.boeblingen.de.ibm.com>
References: <20060408100213.GA9412@osiris.boeblingen.de.ibm.com> <20060408.031404.111884281.davem@davemloft.net> <20060415072745.GA17011@osiris.boeblingen.de.ibm.com> <20060415.003457.103031290.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060415.003457.103031290.davem@davemloft.net>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert inet_init to an fs_initcall to make sure its called before any device
driver's initcall.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 net/ipv4/af_inet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index dc206f1..0a27745 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1257,7 +1257,7 @@ out_unregister_udp_proto:
 	goto out;
 }
 
-module_init(inet_init);
+fs_initcall(inet_init);
 
 /* ------------------------------------------------------------------------ */
 
