Return-Path: <SRS0=4ZiW=AH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F0AC433E0
	for <io-uring@archiver.kernel.org>; Fri, 26 Jun 2020 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172DA20675
	for <io-uring@archiver.kernel.org>; Fri, 26 Jun 2020 20:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=remexre.xyz header.i=@remexre.xyz header.b="SdbA/foT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgFZUrZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:47:25 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:20972 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZUrZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 26 Jun 2020 16:47:25 -0400
Date:   Fri, 26 Jun 2020 20:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=remexre.xyz;
        s=protonmail; t=1593204443;
        bh=e03K4pHUjuSJSeHKZo5NDisdlejkUTAAwR4ZHsvU6+4=;
        h=Date:To:From:Reply-To:Subject:From;
        b=SdbA/foTkOzdnRxgOkuKlv5/kQ3QclkecZtKS0WzAsfCu34FhF45vVp2oUQOixOjO
         pTs1N0RIkV594KYpvHXXGzCWaoOfWbtkbaEQGbNblvNOtp3CgRLxR0LVOrc8hX8W6k
         fC2ZNV4r4FihZxOm/u9SVJc91HVusL6T9g7lqWag=
To:     "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
From:   Nathan Ringo <nathan@remexre.xyz>
Reply-To: Nathan Ringo <nathan@remexre.xyz>
Subject: sendto(), recvfrom()
Message-ID: <bRmxY0zzqGcGWE4Xg-O3jlU42WtEEMUb4iGvfOvesLybmoDNJ242_9phm-DHLM8zJzu7C63iKCZq4ZJLcrYXnuVewHvCgiO21tW2CSuabnE=@remexre.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Would adding IORING_OP_{SENDTO,RECVFROM} be a reasonable first kernel
contribution? I'd like to write a program with io_uring that's listening
on a UDP socket, so recvfrom() at least is important to my use-case.

--
Nathan Ringo

