Return-Path: <SRS0=UBdq=ZV=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6DC432C3
	for <io-uring@archiver.kernel.org>; Fri, 29 Nov 2019 08:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB1721781
	for <io-uring@archiver.kernel.org>; Fri, 29 Nov 2019 08:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfK2IZR convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:25:17 -0500
Received: from smtpbg509.qq.com ([203.205.250.90]:55901 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbfK2IZR (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 29 Nov 2019 03:25:17 -0500
X-QQ-mid: Xesmtp5t1575015911t8hg62c0h
Received: from [172.16.31.194] (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 29 Nov 2019 16:25:10 +0800 (CST)
X-QQ-SSF: 00000000000000B0SF101F00000000K
X-QQ-FEAT: 2DOzdMMimAhp4JGUWhcof8V0+jy2HkVuALSEWrFb7IjiIlEIKlFyGInzeIkF0
        73n5+S3ZyZBRHU63ZPrqtZlFo8fCN5vFQ/bXE/sVzGjHV0nKfxIC0kKnQ01h7MY8m+2xv0m
        jK8/y+WrEDLlgiwYsY9dcCjRiFecASNwNI+Z6yisSyOfTh1HMBGT96HHV2d72FEd2p/T6GH
        lsOppQP74mbDzTxJKigwio6OH2zg5KgUp05u76llBWrOj3H8esmsKZqmEhYSgjxgPoqAT57
        twldC2zXDq+Jhd8xKsGj7oYj2CR1RlxPhpeiQncW/kHCpL
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: delete unneeded int-type
From:   Jackie Liu <jackieliu@byteisland.com>
In-Reply-To: <CAPnMXWW=cV_H2xs=r21DOuhfKWcCaxgG2iXR9LaExuRMNGUvpA@mail.gmail.com>
Date:   Fri, 29 Nov 2019 16:25:09 +0800
Cc:     io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <743A423B-8270-4A31-ADF3-28E8A7EB8A72@byteisland.com>
References: <CAPnMXWW=cV_H2xs=r21DOuhfKWcCaxgG2iXR9LaExuRMNGUvpA@mail.gmail.com>
To:     liming wu <wu860403@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:byteisland.com:bgweb:bgweb2
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

2019年11月29日 16:19，liming wu <wu860403@gmail.com> 写道：
> 
> Hi
> 
> It can't buid successfully except use c99.
> 
> 
> Subject: [PATCH] delete unneede int-type
> 
> ---
> test/accept-link.c | 2 +-
> test/poll-link.c   | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/test/accept-link.c b/test/accept-link.c
> index 2fbc12e..91dbc2b 100644
> --- a/test/accept-link.c
> +++ b/test/accept-link.c
> @@ -131,7 +131,7 @@ void *recv_thread(void *arg)
> 
>        assert(io_uring_submit(&ring) == 2);
> 
> -       for (int i = 0; i < 2; i++) {
> +       for (i = 0; i < 2; i++) {
>                struct io_uring_cqe *cqe;
>                int idx;
> 
> diff --git a/test/poll-link.c b/test/poll-link.c
> index 3cc2ca7..abddb71 100644
> --- a/test/poll-link.c
> +++ b/test/poll-link.c
> @@ -127,7 +127,7 @@ void *recv_thread(void *arg)
> 
>        assert(io_uring_submit(&ring) == 2);
> 
> -       for (int i = 0; i < 2; i++) {
> +       for (i = 0; i < 2; i++) {
>                struct io_uring_cqe *cqe;
>                int idx;
> 
> --
> <delete-unneede-int-type.patch>

I think it would be better for you to send patches using git send-email
instead of using attachments.

--
Jackie Liu
