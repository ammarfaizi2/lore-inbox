Return-Path: <SRS0=IQQj=BI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D92C433DF
	for <io-uring@archiver.kernel.org>; Wed, 29 Jul 2020 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3F9206D7
	for <io-uring@archiver.kernel.org>; Wed, 29 Jul 2020 10:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgG2KKU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:10:20 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55793 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbgG2KKU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 29 Jul 2020 06:10:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0U48noCL_1596017417;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0U48noCL_1596017417)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Jul 2020 18:10:17 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
Subject: [PATCH liburing 0/2] add two interfaces for new timeout feature 
Date:   Wed, 29 Jul 2020 18:10:13 +0800
Message-Id: <1596017415-39101-1-git-send-email-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This patch adds two interfaces for new timeout feature. They are 
safe for applications that split SQ and CQ handling in two threads.

Jiufei Xue (2):

io_uring_enter: add timeout support
test/timeout: add testcase for new timeout interface
