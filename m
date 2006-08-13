Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWHMBWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWHMBWm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 21:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWHMBWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 21:22:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030190AbWHMBWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 21:22:41 -0400
Date: Sat, 12 Aug 2006 18:22:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
Message-Id: <20060812182234.605b4fb4.akpm@osdl.org>
In-Reply-To: <20060812.180944.51301787.davem@davemloft.net>
References: <20060812162857.d85632b9.akpm@osdl.org>
	<20060812.174324.77324010.davem@davemloft.net>
	<20060812174549.9a8f8aeb.akpm@osdl.org>
	<20060812.180944.51301787.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2006 18:09:44 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Andrew Morton <akpm@osdl.org>
> Date: Sat, 12 Aug 2006 17:45:49 -0700
> 
> > Is that also adding 150 usecs to each IO operation?
> 
> I have no idea, Jens hasn't done enough to narrow down the true cause
> of the latencies he is seeing.  So pinpointing it on anything specific
> is highly premature at this stage.

Determining whether pre-conversion scsi was impacted in the same manner
would be part of that pinpointing process.

Deferring to softirq _has_ to add latency and any latency addition in
synchronous disk IO is very bad.  That being said, 150 usecs per request is
so bad that I'd be suspecting that it's not affecting most people, else
we'd have heard.

> My point was merely to encourage you to find out the facts before
> tossing accusations around. :-)

No, your point was that slotting this change into mainline without telling
anyone was OK because SCSI has been doing something similar.

