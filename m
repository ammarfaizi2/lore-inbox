Return-Path: <SRS0=Hqes=7H=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878B8C433DF
	for <io-uring@archiver.kernel.org>; Mon, 25 May 2020 19:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628EC20671
	for <io-uring@archiver.kernel.org>; Mon, 25 May 2020 19:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C4YOR5nI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbgEYTI5 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 May 2020 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389437AbgEYTI4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 May 2020 15:08:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C2C061A0E;
        Mon, 25 May 2020 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=e37lDVxxBr245W9OHUibCWInfaR1PNkQAuXVTyn1hA8=; b=C4YOR5nIybZvW6zcj5ldHsAfVe
        63PalPqonvEBNzbBZKnRWAnpDY61Spq7czN/+bRI8cx+vPCZ3A8gc2+u5REUARGTKoTKM8sbmPJZG
        G5A7FWBkGp8WBtUnwIwgzOVWt7zHL/JnCi/q+nxfNmiS4dk0/JR3sVINrkURcAHSqgH2fFmNgiukA
        SErvXU6LHn/fhUdzqvPLSHfPw2fNbya7S21raIK4fu3ck+g07qlCQl2fmz1GVKKchQdfoNsY5BLcV
        Mj+aoE67tZOprIC1yJ5yeQBXrvcvHEFUbvJkyz+3mYkqQINdWMqs004WPi4lLhDXyUwyO0o9MA9Dh
        cK8p1o0A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdISz-0006kT-KB; Mon, 25 May 2020 19:08:53 +0000
Subject: Re: linux-next: Tree for May 25 (fs/io_uring)
To:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        io-uring@vger.kernel.org
References: <20200525224923.41fb5a47@canb.auug.org.au>
 <7fbfc86d-bda1-362b-b682-1a9aefa8560e@infradead.org>
 <f7a9445f-1619-08aa-3e98-5bef9e4409df@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <785bc7d8-7402-c876-6fd8-708c7ccbcb5c@infradead.org>
Date:   Mon, 25 May 2020 12:08:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f7a9445f-1619-08aa-3e98-5bef9e4409df@kernel.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 5/25/20 12:02 PM, Jens Axboe wrote:
> On 5/25/20 10:35 AM, Randy Dunlap wrote:
>> On 5/25/20 5:49 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20200522:
>>>
>>
>>
>> on i386:
>>
>> ../fs/io_uring.c:500:26: error: field ‘wpq’ has incomplete type
>>   struct wait_page_queue  wpq;
> 
> Missing pagemap.h include, didn't bite me on x86-64. I'll fold in
> a fix, thanks!
> 

I see it on x86_64. It must depend on some kernel config setting.

Thanks.
