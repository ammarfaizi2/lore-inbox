Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2134C4338F
	for <io-uring@archiver.kernel.org>; Mon, 23 Aug 2021 03:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64E26135D
	for <io-uring@archiver.kernel.org>; Mon, 23 Aug 2021 03:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhHWD0C (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 22 Aug 2021 23:26:02 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43814 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230474AbhHWDZ6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 22 Aug 2021 23:25:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UlAN5vv_1629689106;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UlAN5vv_1629689106)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Aug 2021 11:25:14 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH for-5.15 v2 0/2] fix failed linkchain code logic
Date:   Mon, 23 Aug 2021 11:25:04 +0800
Message-Id: <20210823032506.34857-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

the first patch is code clean.
the second is the main one, which refactors linkchain failure path to
fix a problem, detail in the commit message.

v1-->v2
 - update patch with Pavel's suggestion.

Hao Xu (2):
  io_uring: remove redundant req_set_fail()
  io_uring: fix failed linkchain code logic

 fs/io_uring.c | 60 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 16 deletions(-)

-- 
2.24.4

