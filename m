Return-Path: <SRS0=zNVv=EE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F788C388F7
	for <io-uring@archiver.kernel.org>; Thu, 29 Oct 2020 01:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B239A20790
	for <io-uring@archiver.kernel.org>; Thu, 29 Oct 2020 01:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bl4ckb0ne.ca header.i=@bl4ckb0ne.ca header.b="M/K56l7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgJ2BDR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:03:17 -0400
Received: from out0.migadu.com ([94.23.1.103]:64774 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbgJ2BDP (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Wed, 28 Oct 2020 21:03:15 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bl4ckb0ne.ca;
        s=default; t=1603933392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=uNgTr0d9Naqe0aJtkdN2DCS9K5tTqN1FeYfR74leqZY=;
        b=M/K56l7yZ/jPhX3Culnb5YHZjD2xjfRhsVxfQVnD4p0O9ZlkYd6ImTGojIpPrWaGcbmkh8
        j01nKT7uWvOL2dv0WqAmPLNWjYZsD0+sPS8qNxLv1EkcPEJHWZ/MP+NUikR26zAIgTtFW6
        UhDj+1iJ9P+fwSl3LsExa9z0BPaXqug=
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] Fix compilation with iso C standard
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Simon Zeni" <simon@bl4ckb0ne.ca>
To:     "Jens Axboe" <axboe@kernel.dk>, <io-uring@vger.kernel.org>
Date:   Wed, 28 Oct 2020 21:00:24 -0400
Message-Id: <C6OYVIZP1Q2H.2KH87B0QGDQ70@gengar>
In-Reply-To: <200e1c71-2214-f84e-f62d-0ed4b420d465@kernel.dk>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed Oct 28, 2020 at 12:31 PM EDT, Jens Axboe wrote:
> All of this good stuff should be in the commit message before
> the '---' or it won't make it into the git log. Which would be a
> shame!
>
> I get a bunch of these with this applied:
>
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:25,
> from setup.c:4:
> /usr/include/features.h:187:3: warning: #warning "_BSD_SOURCE and
> _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE" [-Wcpp]
> 187 | # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use
> _DEFAULT_SOURCE"
> | ^~~~~~~

I didn't want to fill the commit message with my patch explanation but I
can make a v2 to fix that definition warning and add the text into the
commit if you want.

Simon
