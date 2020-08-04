Return-Path: <SRS0=sS5N=BO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7355C433E0
	for <io-uring@archiver.kernel.org>; Tue,  4 Aug 2020 09:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D942086A
	for <io-uring@archiver.kernel.org>; Tue,  4 Aug 2020 09:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHDJV5 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:21:57 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51878 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbgHDJV5 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 4 Aug 2020 05:21:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U4jpU.3_1596532915;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0U4jpU.3_1596532915)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 17:21:55 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, metze@samba.org
Subject: [PATCH liburing v2 0/2] add support for new timeout feature 
Date:   Tue,  4 Aug 2020 17:21:51 +0800
Message-Id: <1596532913-70757-1-git-send-email-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Kernel can handle timeout when feature IORING_FEAT_GETEVENTS_TIMEOUT
supported. Applications should use io_uring_set_cqwait_timeout()
explicitly to asked for the new feature.

Jiufei Xue (2):
io_uring_enter: add timeout support
test/timeout: add testcase for new timeout feature
