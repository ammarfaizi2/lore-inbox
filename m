Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUDSF6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 01:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbUDSF6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 01:58:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:7857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263199AbUDSF6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 01:58:20 -0400
Date: Sun, 18 Apr 2004 22:57:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: piotr@larroy.com, linux-kernel@vger.kernel.org
Subject: Re: CFQ iosched praise: good perfomance and better latency
Message-Id: <20040418225752.56d10695.akpm@osdl.org>
In-Reply-To: <40835F4E.5000308@yahoo.com.au>
References: <20040419005651.GA7860@larroy.com>
	<40835F4E.5000308@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Pedro Larroy wrote:
> > Hi
> > 
> > I've been trying CFQ ioscheduler in my software raid5 with nice results,
> > I've observed that a latency pattern still exists, just as in the
> > anticipatory ioscheduler, but those spikes are now much lower (from
> > 6ms with AS to 2ms with CFQ as seen in the bottom of
> > http://pedro.larroy.com/devel/iolat/analisys/),
> > plus apps seems to get a fair amount of io so they don't get starved.
> > 
> > Seems a good choice for io loaded boxes. Thanks Jens Axboe.
> > 
> 
> Although AS isn't at its best when behind raid devices (it should
> probably be in front of them), you could be seeing some problem
> with the raid code.
> 
> I'd be interested to see what the graph looks like with elevator=noop

This isn't a very surprising result, is it?  AS throws away latency to gain
throughput.  Pedro is measuring latency...
