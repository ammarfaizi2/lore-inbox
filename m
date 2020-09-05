Return-Path: <SRS0=YIAO=CO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F483C43461
	for <io-uring@archiver.kernel.org>; Sat,  5 Sep 2020 03:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6ECD208DB
	for <io-uring@archiver.kernel.org>; Sat,  5 Sep 2020 03:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIED3w (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 4 Sep 2020 23:29:52 -0400
Received: from mail.nickhill.org ([77.72.3.32]:48690 "EHLO mail.nickhill.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgIED3w (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 4 Sep 2020 23:29:52 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2020 23:29:51 EDT
Received: from _ (localhost [127.0.0.1])
        by mail.nickhill.org (Postfix) with ESMTPSA id 2704F40BF4
        for <io-uring@vger.kernel.org>; Sat,  5 Sep 2020 03:22:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Sep 2020 20:22:09 -0700
From:   nick@nickhill.org
To:     io-uring@vger.kernel.org
Subject: WRITEV with IOSQE_ASYNC broken?
Message-ID: <382946a1d3513fbb1354c8e2c875e036@nickhill.org>
X-Sender: nick@nickhill.org
User-Agent: Roundcube Webmail
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi,

I am helping out with the netty io_uring integration, and came across 
some strange behaviour which seems like it might be a bug related to 
async offload of read/write iovecs.

Basically a WRITEV SQE seems to fail reliably with -BADADDRESS when the 
IOSQE_ASYNC flag is set but works fine otherwise (everything else the 
same). This is with 5.9.0-rc3.

Sorry if I've made a mistake somehow, and thanks for all the great work 
on this game-changing feature!

Nick
