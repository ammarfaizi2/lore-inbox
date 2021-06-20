Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6221C48BDF
	for <io-uring@archiver.kernel.org>; Sun, 20 Jun 2021 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80377610A1
	for <io-uring@archiver.kernel.org>; Sun, 20 Jun 2021 19:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhFTTan (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 20 Jun 2021 15:30:43 -0400
Received: from cloud48395.mywhc.ca ([173.209.37.211]:38800 "EHLO
        cloud48395.mywhc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFTTam (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 20 Jun 2021 15:30:42 -0400
Received: from modemcable064.203-130-66.mc.videotron.ca ([66.130.203.64]:33254 helo=[192.168.1.179])
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1lv37H-000547-Va; Sun, 20 Jun 2021 15:28:24 -0400
Message-ID: <b0c5175177af0bfd216d45da361e114870f07aad.camel@trillion01.com>
Subject: Re: [PATCH v2] io_uring: reduce latency by reissueing the operation
From:   Olivier Langlois <olivier@trillion01.com>
To:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 20 Jun 2021 15:28:21 -0400
In-Reply-To: <c5394ace-d003-df18-c816-2592fc40bf08@infradead.org>
References: <e4614f9442d971016f47d69fbcba226f758377a8.1624215754.git.olivier@trillion01.com>
         <c5394ace-d003-df18-c816-2592fc40bf08@infradead.org>
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Sun, 2021-06-20 at 12:07 -0700, Randy Dunlap wrote:
> On 6/20/21 12:05 PM, Olivier Langlois wrote:
> > -               return false;
> > +               return ret?IO_ARM_POLL_READY:IO_ARM_POLL_ERR;
> 
> Hi,
> Please make that return expression more readable.
> 
> 
How exactly?

by adding spaces?
Changing the define names??


