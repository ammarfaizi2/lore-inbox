Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWEaMzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWEaMzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 08:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWEaMzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 08:55:25 -0400
Received: from rtr.ca ([64.26.128.89]:14274 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964978AbWEaMzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 08:55:24 -0400
Message-ID: <447D923B.1080503@rtr.ca>
Date: Wed, 31 May 2006 08:55:23 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447CF252.7010704@rtr.ca> <20060531061110.GB29535@suse.de>
In-Reply-To: <20060531061110.GB29535@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>
> NCQ helps us with something we can never fix in software - the
> rotational latency. Ordering is only a small part of the picture.

Yup.  And it also helps reduce the command-to-command latencies.

I'm all for it, and have implemented tagged queuing for a variety
of device drivers over the past five years (TCQ & NCQ).  In every
case people say.. wow, I expected more of a difference than that,
while still noting the end result was faster under Linux than MS$.

Of course with artificial benchmarks, and the right firmware in
the right drives, it's easier to create and see a difference.
But I'm talking more life-like loads than just a multi-threaded
random seek generator.

Cheers
