Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTFBNID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTFBNID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:08:03 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:63879 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262299AbTFBNIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:08:02 -0400
Date: Mon, 2 Jun 2003 09:21:26 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: [PATCH][CFT] blk-fair-batches vs 2.4.20-rc6
In-Reply-To: <3EDB48B7.2050604@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0306020919530.29823-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.44.0306020919532.29823@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Nick Piggin wrote:

> Previously:
> * request queue fills up
> * process 1 calls get_request, sleeps
> * a couple of requests are freed
> * process 2 calls get_request, proceeds
> * a couple of requests are freed
> * process 2 calls get_request, proceeds
> ...

In an early 2.4 kernel I've caught a few processes sleeping
in get_request_wait for 5 minutes or so, while other processes
were allocating new requests at exactly the speed they were
processed.

Of course, a patch to fix the problem was shot down due to
lower dbench performance ... good thing Andrew Morton has
more sense than that.

