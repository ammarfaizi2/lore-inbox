Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWFWN2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWFWN2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWFWN2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:28:43 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:31120 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751564AbWFWN2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:28:42 -0400
Date: Fri, 23 Jun 2006 15:28:11 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>,
       Frank Pavlic <fpavlic@de.ibm.com>
Subject: [patch 4/4] lock validator: fix qeth compile warning
Message-ID: <20060623132811.GH9446@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add #ifdef CONFIG_LOCKDEP to avoid compile warning.

Cc: Frank Pavlic <fpavlic@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/net/qeth_main.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.17-mm1/drivers/s390/net/qeth_main.c
===================================================================
--- linux-2.6.17-mm1.orig/drivers/s390/net/qeth_main.c
+++ linux-2.6.17-mm1/drivers/s390/net/qeth_main.c
@@ -85,7 +85,9 @@ static debug_info_t *qeth_dbf_qerr = NUL
 
 DEFINE_PER_CPU(char[256], qeth_dbf_txt_buf);
 
+#ifdef CONFIG_LOCKDEP
 static struct lockdep_type_key qdio_out_skb_queue_key;
+#endif
 
 /**
  * some more definitions and declarations
