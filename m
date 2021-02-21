Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06660C433E0
	for <io-uring@archiver.kernel.org>; Sun, 21 Feb 2021 13:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EA564EEC
	for <io-uring@archiver.kernel.org>; Sun, 21 Feb 2021 13:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhBUNXc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 21 Feb 2021 08:23:32 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36640 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhBUNXb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 21 Feb 2021 08:23:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UP6rv01_1613913766;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UP6rv01_1613913766)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 21 Feb 2021 21:22:46 +0800
Subject: Re: [PATCH v2 0/4] rsrc quiesce fixes/hardening v2
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <cover.1613844023.git.asml.silence@gmail.com>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <c8248b0f-eab9-9c63-9571-a31de9a6e6a4@linux.alibaba.com>
Date:   Sun, 21 Feb 2021 21:22:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1613844023.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

ÔÚ 2021/2/21 ÉÏÎç2:03, Pavel Begunkov Ð´µÀ:
> v2: concurrent quiesce avoidance (Hao)
>      resurrect-release patch
> 
> Pavel Begunkov (4):
>    io_uring: zero ref_node after killing it
>    io_uring: fix io_rsrc_ref_quiesce races
>    io_uring: keep generic rsrc infra generic
>    io_uring: wait potential ->release() on resurrect
> 
>   fs/io_uring.c | 96 ++++++++++++++++++++++++---------------------------
>   1 file changed, 45 insertions(+), 51 deletions(-)
> 
I tested this patchset with the same tests
for "io_uring: don't hold uring_lock ..."

Tested-by: Hao Xu <haoxu@linux.alibaba.com>
