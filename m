Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE50C4338F
	for <io-uring@archiver.kernel.org>; Mon, 23 Aug 2021 16:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88979601FD
	for <io-uring@archiver.kernel.org>; Mon, 23 Aug 2021 16:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhHWQgj (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhHWQgi (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 23 Aug 2021 12:36:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 840A66101C;
        Mon, 23 Aug 2021 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629736555;
        bh=HBJBKVfBVUOvY/poMB/Dsj5WZ69VPn9lVCfO1CUxGBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RK3fRxoR8xzAdOD2fU9/etykDOZi7wjr51ntGuEtXiTUsWrEJSO8Qm8YikJGmVtfR
         dluMQWSAt/O4td6ZT4LHc4ud4wM/yEZOe18Xp9BjcKBufEqFuQ9hcwFKEnqu51FcYC
         ahnG44wqmM6U5R1+kqcJqc0CLhrtFv3x+qCMTTUYvZ4pGJkg4hhkW3PmFIFAksu/ip
         +VN3vpBc6+i+8yb7vb26X6pcRXbv2VLuqEkecvTx0vAcleKnZ2fF/eZZU8UtqUiQsr
         v5tvk/M5Vt2zRnM5RrWe6OhEj64lfNefmuKqNKT7rjVaOXtEmy0Sf0EoS6QUvFI0VN
         6tIaRIZ2UMZAQ==
Date:   Mon, 23 Aug 2021 09:35:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Stefan Metzmacher <metze@samba.org>
Subject: Re: [PATCH v3 1/4] net: add accept helper not installing fd
Message-ID: <20210823093554.30e4c343@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <0c5d77e34ebff09f1f2f6b9bff15b97ec8fbf8ca.1629559905.git.asml.silence@gmail.com>
References: <cover.1629559905.git.asml.silence@gmail.com>
        <0c5d77e34ebff09f1f2f6b9bff15b97ec8fbf8ca.1629559905.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Sat, 21 Aug 2021 16:52:37 +0100 Pavel Begunkov wrote:
> Introduce and reuse a helper that acts similarly to __sys_accept4_file()
> but returns struct file instead of installing file descriptor. Will be
> used by io_uring.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>
