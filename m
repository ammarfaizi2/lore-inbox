Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5163BC4338F
	for <io-uring@archiver.kernel.org>; Sun,  8 Aug 2021 13:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272B761028
	for <io-uring@archiver.kernel.org>; Sun,  8 Aug 2021 13:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhHHNzA (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 8 Aug 2021 09:55:00 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51826 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhHHNy7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 8 Aug 2021 09:54:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UiIyDWG_1628430874;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UiIyDWG_1628430874)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Aug 2021 21:54:39 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 0/2] bug fix for nr_workers
Date:   Sun,  8 Aug 2021 21:54:32 +0800
Message-Id: <20210808135434.68667-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The first one is to fix bugs in the previous patches about nr_workers.
The second one is to fix the IO_WORKER_F_FIXED logic.

Hao Xu (2):
  io-wq: fix bug of creating io-wokers unconditionally
  io-wq: fix IO_WORKER_F_FIXED issue in create_io_worker()

 fs/io-wq.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

-- 
2.24.4

