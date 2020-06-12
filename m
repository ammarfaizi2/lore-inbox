Return-Path: <SRS0=miIQ=7Z=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A947C433E0
	for <io-uring@archiver.kernel.org>; Fri, 12 Jun 2020 02:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A21F20835
	for <io-uring@archiver.kernel.org>; Fri, 12 Jun 2020 02:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgFLCaW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 11 Jun 2020 22:30:22 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:56495 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgFLCaW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 11 Jun 2020 22:30:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U.JoBw8_1591929019;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0U.JoBw8_1591929019)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 10:30:20 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com
Subject: [PATCH v3] io_uring: add EPOLLEXCLUSIVE flag for POLL_ADD operation 
Date:   Fri, 12 Jun 2020 10:30:16 +0800
Message-Id: <1591929018-73954-1-git-send-email-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Applications can use this flag to avoid accept thundering herd type
behavior.

