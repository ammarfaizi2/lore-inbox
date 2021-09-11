Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B2C433F5
	for <io-uring@archiver.kernel.org>; Sat, 11 Sep 2021 19:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0F16113E
	for <io-uring@archiver.kernel.org>; Sat, 11 Sep 2021 19:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhIKTmN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:42:13 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:32880 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhIKTmN (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 11 Sep 2021 15:42:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uo.lhDo_1631389252;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0Uo.lhDo_1631389252)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Sep 2021 03:40:58 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 0/4] iowq fix
Date:   Sun, 12 Sep 2021 03:40:48 +0800
Message-Id: <20210911194052.28063-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

several iowq fixes, all in theory, haven't been manually triggered.
Hao Xu (4):
  io-wq: tweak return value of io_wqe_create_worker()
  io-wq: code clean of io_wqe_create_worker()
  io-wq: fix worker->refcount when creating worker in work exit
  io-wq: fix potential race of acct->nr_workers

 fs/io-wq.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.24.4

