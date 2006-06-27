Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWF0UME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWF0UME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWF0UMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:12:01 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45440 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161256AbWF0UL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:11:58 -0400
Message-Id: <20060627200946.412443000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:04 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>, Tushar Gohad <tgohad@mvista.com>
Subject: [PATCH 04/25] PFKEYV2: Fix inconsistent typing in struct sadb_x_kmprivate.
Content-Disposition: inline; filename=pfkeyv2-fix-inconsistent-typing-in-struct-sadb_x_kmprivate.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Tushar Gohad <tgohad@mvista.com>

Fixes inconsistent use of "uint32_t" vs. "u_int32_t".
Fix pfkeyv2 userspace builds.

Signed-off-by: Tushar Gohad <tgohad@mvista.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 include/linux/pfkeyv2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.1.orig/include/linux/pfkeyv2.h
+++ linux-2.6.17.1/include/linux/pfkeyv2.h
@@ -159,7 +159,7 @@ struct sadb_spirange {
 struct sadb_x_kmprivate {
 	uint16_t	sadb_x_kmprivate_len;
 	uint16_t	sadb_x_kmprivate_exttype;
-	u_int32_t	sadb_x_kmprivate_reserved;
+	uint32_t	sadb_x_kmprivate_reserved;
 } __attribute__((packed));
 /* sizeof(struct sadb_x_kmprivate) == 8 */
 

--
