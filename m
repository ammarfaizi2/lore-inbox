Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96C8C2D0A3
	for <io-uring@archiver.kernel.org>; Thu, 12 Nov 2020 06:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4922100A
	for <io-uring@archiver.kernel.org>; Thu, 12 Nov 2020 06:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKLG4D (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 12 Nov 2020 01:56:03 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44894 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbgKLG4D (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 12 Nov 2020 01:56:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UF3.Ewq_1605164160;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0UF3.Ewq_1605164160)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Nov 2020 14:56:00 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com
Subject: [PATCH 5.11 0/2] two minor cleanup and improvement for sqpoll
Date:   Thu, 12 Nov 2020 14:55:58 +0800
Message-Id: <20201112065600.8710-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Xiaoguang Wang (2):
  io_uring: initialize 'timeout' properly in io_sq_thread()
  io_uring: don't acquire uring_lock twice

 fs/io_uring.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

-- 
2.17.2

