Return-Path: <SRS0=4B3G=3R=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF5CC33CB3
	for <io-uring@archiver.kernel.org>; Tue, 28 Jan 2020 10:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386FF21739
	for <io-uring@archiver.kernel.org>; Tue, 28 Jan 2020 10:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgA1KbR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:31:17 -0500
Received: from yourcmc.ru ([195.209.40.11]:34580 "EHLO yourcmc.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1KbQ (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Tue, 28 Jan 2020 05:31:16 -0500
Received: from yourcmc.ru (localhost [127.0.0.1])
        by yourcmc.ru (Postfix) with ESMTP id 79B5FFE0656
        for <io-uring@vger.kernel.org>; Tue, 28 Jan 2020 13:31:15 +0300 (MSK)
Received: from localhost (unknown [31.173.85.95])
        by yourcmc.ru (Postfix) with ESMTPSA id 43A82FE00CA
        for <io-uring@vger.kernel.org>; Tue, 28 Jan 2020 13:31:15 +0300 (MSK)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
Subject: write / fsync ordering
Date:   Tue, 28 Jan 2020 13:31:14 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Vitaliy Filippov" <vitalif@yourcmc.ru>
Message-ID: <op.0e3l6cmc0ncgu9@localhost>
User-Agent: Opera Mail/12.16 (Linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi everyone,

Can someone point out if io_uring may reorder write and fsync requests?

If I submit a write request and an fsync request at the same time, does  
that mean that fsync will sync that write request, or does it only sync  
completed requests?

-- 
With best regards,
   Vitaliy Filippov
