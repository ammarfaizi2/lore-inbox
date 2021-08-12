Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41251C4338F
	for <io-uring@archiver.kernel.org>; Thu, 12 Aug 2021 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212D26103E
	for <io-uring@archiver.kernel.org>; Thu, 12 Aug 2021 16:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhHLQTg (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhHLQTf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 12 Aug 2021 12:19:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57EBC0617AD;
        Thu, 12 Aug 2021 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=VqANNtBV1KY1iSsAlieSGXPNyA
        G8GijrnFU8EEwSNqzAnaZj4PrjJ3eZZw/waFfwo3zX6zFyVHxuNK58GpRRlbiuAA3mbULvI1+qwm/
        n0amQKv1e32K2BcI8yMlOy4SN0uMf/M1ZXjuI/RrkVPMYRa3NE1y6DMhMIVMP+YqpgEAEt/b9VrRS
        MBxPLzoub1aTXx62RaV0RA16++RBYvEGED896BZhEa6EOkQrMzAZwxGr3URnKIqsd5CDnEC8JGBFc
        RgiXr2eHpO96avr5fzQmxnTcpJIwV/QPYfQatYxhMRIauGsFnqBWOEPpNPEmyCpRovZsnJkNWYDC+
        j+81vDEw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEDNx-00EkbR-CM; Thu, 12 Aug 2021 16:17:39 +0000
Date:   Thu, 12 Aug 2021 17:16:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org
Subject: Re: [PATCH 1/6] bio: optimize initialization of a bio
Message-ID: <YRVJcfonk/WDSHLD@infradead.org>
References: <20210812154149.1061502-1-axboe@kernel.dk>
 <20210812154149.1061502-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812154149.1061502-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
