Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D609C433E0
	for <io-uring@archiver.kernel.org>; Sat, 23 Jan 2021 23:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24EAE22CF7
	for <io-uring@archiver.kernel.org>; Sat, 23 Jan 2021 23:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAWX3k (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Jan 2021 18:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbhAWX3i (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Jan 2021 18:29:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B196DC0613D6;
        Sat, 23 Jan 2021 15:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3yZG/MXVqlbwoylF6Mu7eqGVO8ZMyTpVlbCjsWzD+LE=; b=dFtFpDpo9JGJHPyarlu931wkH2
        fF2+P6HNqUkd/fQWYg0ZRCWZc6D4UEcw2FBIQXfmqmdHw5lsuNQlqsgyBxAyWVo9GiinypEFBu6se
        +9X7xkfHZGndCvRfQAc+01VlYtWoGPB1mtxh/xn26CvSD98mDQCNItjoLZjMN7b7W3kqETQDyd7re
        xSUwcNzxAahiQrMDg9LVj/FANADeyNV7nG+sjqA2LN1y76xnzfVeFOBJCiyTxo3TGTSZ4DwCECHHJ
        yUHCOXmEskWRRDgCRpUE90fiFnVc98gMXOtTYfF17QT4NH6yDDjnoCchSIAsToaTj9kmAQwHoIR3a
        jX+g4Zgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3SJu-002QFn-CG; Sat, 23 Jan 2021 23:28:03 +0000
Date:   Sat, 23 Jan 2021 23:27:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Lennert Buytenhek <buytenh@wantstofly.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH] io_uring: add support for IORING_OP_GETDENTS64
Message-ID: <20210123232754.GA308988@casper.infradead.org>
References: <20210123114152.GA120281@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123114152.GA120281@wantstofly.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Sat, Jan 23, 2021 at 01:41:52PM +0200, Lennert Buytenhek wrote:
> IORING_OP_GETDENTS64 behaves like getdents64(2) and takes the same

Could we drop the '64'?  We don't, for example, have IOURING_OP_FADVISE64
even though that's the name of the syscall.

