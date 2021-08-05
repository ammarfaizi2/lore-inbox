Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99FCC4338F
	for <io-uring@archiver.kernel.org>; Thu,  5 Aug 2021 10:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B2E60C3F
	for <io-uring@archiver.kernel.org>; Thu,  5 Aug 2021 10:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbhHEKGI (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:06:08 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47057 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239866AbhHEKGB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 5 Aug 2021 06:06:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui1e.zi_1628157938;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0Ui1e.zi_1628157938)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 18:05:44 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 0/3] code clean and nr_worker fixes
Date:   Thu,  5 Aug 2021 18:05:35 +0800
Message-Id: <20210805100538.127891-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org


Hao Xu (3):
  io-wq: clean code of task state setting
  io-wq: fix no lock protection of acct->nr_worker
  io-wq: fix lack of acct->nr_workers < acct->max_workers judgement

 fs/io-wq.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

-- 
2.24.4

