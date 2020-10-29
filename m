Return-Path: <SRS0=zNVv=EE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0249C4363A
	for <io-uring@archiver.kernel.org>; Thu, 29 Oct 2020 01:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE4B2075E
	for <io-uring@archiver.kernel.org>; Thu, 29 Oct 2020 01:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bl4ckb0ne.ca header.i=@bl4ckb0ne.ca header.b="rCl+41cF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgJ2B1B (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbgJ2B0S (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 28 Oct 2020 21:26:18 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809A8C0613CF
        for <io-uring@vger.kernel.org>; Wed, 28 Oct 2020 18:26:18 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bl4ckb0ne.ca;
        s=default; t=1603934777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=vjkHej/xkPmo2O/ZggwEclN0209FXojsoBqEZWGx3Sg=;
        b=rCl+41cFogcRMEdw0AOM6Y68IMKDW+ntHVWi26ZNKlLOLq+5rrJm7wJ6H0xkTJ9br+D4Kg
        U5CIODiUn1cLqlUM1vIgvgjMHR1+OTsctVxR2ne1ImdqB41UzIdW+7VCv7kvcDoYczQjvF
        2XTD3KdvinY9aFOpKyiUjqBntQtSkC8=
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] examples: disable ucontext-cp if ucontext.h is not
 available
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Simon Zeni" <simon@bl4ckb0ne.ca>
To:     "Jens Axboe" <axboe@kernel.dk>, <io-uring@vger.kernel.org>
Date:   Wed, 28 Oct 2020 21:23:52 -0400
Message-Id: <C6OZDHZNAEV7.2KUIZYYGFKTWW@gengar>
In-Reply-To: <f728786a-cd29-9ea5-68e9-eb2a2df6ecdc@kernel.dk>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed Oct 28, 2020 at 3:06 PM EDT, Jens Axboe wrote:
> The log for those would be interesting. rename/unlink is probably
> me messing up on skipping on not-supported, sq-poll-* ditto. The
> others, not sure - if you fail with -1/-12, probably just missing
> capability checks.

There you go
https://paste.sr.ht/~bl4ckb0ne/61a962894091a8442fc7ab66934e22930122ff18

