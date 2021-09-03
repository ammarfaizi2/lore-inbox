Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFFDC433EF
	for <io-uring@archiver.kernel.org>; Fri,  3 Sep 2021 11:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8B9610CC
	for <io-uring@archiver.kernel.org>; Fri,  3 Sep 2021 11:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348390AbhICLCB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 3 Sep 2021 07:02:01 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43649 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348412AbhICLCA (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 3 Sep 2021 07:02:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Un61DbM_1630666849;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0Un61DbM_1630666849)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Sep 2021 19:00:58 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 2/6] io_uring: add IORING_ACCEPT_MULTISHOT for accept
Date:   Fri,  3 Sep 2021 19:00:45 +0800
Message-Id: <20210903110049.132958-3-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210903110049.132958-1-haoxu@linux.alibaba.com>
References: <20210903110049.132958-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

add an accept_flag IORING_ACCEPT_MULTISHOT for accept, which is to
support multishot.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 include/uapi/linux/io_uring.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 3caec9199658..faa3f2e70e46 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -177,6 +177,10 @@ enum {
 #define IORING_POLL_UPDATE_EVENTS	(1U << 1)
 #define IORING_POLL_UPDATE_USER_DATA	(1U << 2)
 
+/*
+ * accept flags stored in accept_flags
+ */
+#define IORING_ACCEPT_MULTISHOT	(1U << 0)
 /*
  * IO completion data structure (Completion Queue Entry)
  */
-- 
2.24.4

