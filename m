Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbTHZTXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTHZTXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:23:37 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16658
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262870AbTHZTXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:23:35 -0400
Date: Tue, 26 Aug 2003 12:23:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cache limit
Message-ID: <20030826192333.GA1258@matchmail.com>
Mail-Followup-To: Ihar 'Philips' Filipau <filia@softhome.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <oJ5P.699.21@gated-at.bofh.it> <oJ5P.699.23@gated-at.bofh.it> <oJ5P.699.25@gated-at.bofh.it> <oJ5P.699.27@gated-at.bofh.it> <oJ5P.699.19@gated-at.bofh.it> <oQh2.4bQ.13@gated-at.bofh.it> <3F4BB043.6010805@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4BB043.6010805@softhome.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 09:08:51PM +0200, Ihar 'Philips' Filipau wrote:
> Mike Fedyk wrote:
> >Ok, let's benchmark it.
> >
> >Yes, I can see the logic in your argument, but at this point, numbers are
> >needed to see if or how much of a win this might be.
> 
>   [ I beleive you can see those thread about O_STREAMING patch. 
> Not-caching was giving 10%-15% peformance boost for gcc on kernel 
> compiles. Isn't that overhead? ]
> 

That was because they wanted the non-streaming files to be left in the cache.

>   I will try to produce some benchmarktings tomorrow with different 
> 'mem=%dMB'. I'm afraid to confirm that it will make difference.
>   But in advance: mantainance of page tables for 1GB and for 128MB of 
> RAM are going to make a difference.

I'm sorry to say, but you *will* get lower performance if you lower the mem=
value below your working set.  This will also lower the total amount of
memory available for your applications, and force your apps, to swap and
balance cache, and app memory.

That's not what you are looking to benchmark.
