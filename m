Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTJTEwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 00:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTJTEwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 00:52:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:48611 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262321AbTJTEwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 00:52:30 -0400
Date: Sun, 19 Oct 2003 21:52:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Message-Id: <20031019215259.7b1c7a01.akpm@osdl.org>
In-Reply-To: <3F933BE7.5080700@cyberone.com.au>
References: <20031020003745.GA2794@rushmore>
	<3F933BE7.5080700@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> 
> rwhron@earthlink.net wrote:
> 
> >There was about a 50% regression in jobs/minute in AIM7
> >database workload on quad P3 Xeon.  The CPU time has not
> >gone up, so the extra run time is coming from something
> >else.  (I/O or I/O scheduler?)
> >
> >tiobench sequential reads has a significant regression too.
> >
> >Regression appears unrelated to filesystem type.
> >
> >dbench was not affected.
> >
> >The AIM7 was run on ext2.
> >
> 
> Yeah I'd say its all due to the IO scheduler. There is a problem
> I'm thinking about how to fix - its the likely cause of this too.
> 

What change do you think it was due to?

It's rather strange that test6 is slow but test6-mm is not: generally the
IO scheduler regressions enter -mm first ;)

Testing versus deadline would be interesting.
