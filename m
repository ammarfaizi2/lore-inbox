Return-Path: <SRS0=RktD=AC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B1C433E0
	for <io-uring@archiver.kernel.org>; Sun, 21 Jun 2020 20:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72ECF248A2
	for <io-uring@archiver.kernel.org>; Sun, 21 Jun 2020 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgFUUgz (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:36:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39076 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbgFUUgy (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 21 Jun 2020 16:36:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id d66so7375947pfd.6
        for <io-uring@vger.kernel.org>; Sun, 21 Jun 2020 13:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wz1vbdwcD3pBDLeEDx415/o0EUM9Mxbad9BWSnumhFI=;
        b=XI+U90X+9W7Viq0jMNUq79GoWBAZpC64FjQSP3wuk38FgMjsILOUDdVBEpVhjzIJVB
         XDbgJwOS2EOf4+P8LVfgZz6DpAKNvgjZ3mvI5gJd/sC0cKmrCwDR6rzHAvGA49wBngCe
         hNvuj2aESN4/nyVlwMtoBUP9c5FHACnQj//ikRakcNzeMQlcsqdj6/iJpaHu2oEDFlxN
         c3WZkpCDrovYfcg26z0usDch6PAcdM4lPOU8SlE0s33bLuN+36RlOZ/hjHPrZIeugRZy
         hXIRpTMmW1Y7ks5jZpyRb+MLIg4lt/gVyiRcy0zkQ+Zn3ANZaIsGYp3JfUaVLyGm6dVT
         YH1Q==
X-Gm-Message-State: AOAM530+uBLlgLLyUcP05UWCz6Enu8h2YX0sY+PeET8RR+jvwXeUMtLi
        P1M7pKh0P27QBZif9++pxfaVMuuy
X-Google-Smtp-Source: ABdhPJx8GzWirJ7ZzZbat4XSQDvQDKiJ5vPhZfG3UT7StYlE76+vtvDXz5b75rOeChbUlLFVVK4iFA==
X-Received: by 2002:a62:7bd3:: with SMTP id w202mr16878608pfc.50.1592771814055;
        Sun, 21 Jun 2020 13:36:54 -0700 (PDT)
Received: from localhost.localdomain (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id d5sm10861387pjo.20.2020.06.21.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 13:36:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH liburing 0/3] Three small liburing patches
Date:   Sun, 21 Jun 2020 13:36:43 -0700
Message-Id: <20200621203646.14416-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Jens,

The changes in this patch series are as follows:
- Enable additional compiler warnings, similar to W=1 for kernel code.
- Simplify the barrier.h header file.
- Convert a macro into an inline function to allow compilers to produce
  better diagnostics.

Please consider this patch series for the official liburing repository.

Thanks,

Bart.

Bart Van Assche (3):
  Makefiles: Enable -Wextra
  src/include/liburing/barrier.h: Use C11 atomics
  Convert __io_uring_get_sqe() from a macro into an inline function

 src/Makefile                   |  3 ++-
 src/include/liburing/barrier.h | 44 ++++++++--------------------------
 src/queue.c                    | 22 +++++++++--------
 test/Makefile                  |  4 +++-
 4 files changed, 27 insertions(+), 46 deletions(-)

