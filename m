Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbTIGGRz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 02:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbTIGGRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 02:17:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:32168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261978AbTIGGRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 02:17:54 -0400
Date: Sat, 6 Sep 2003 23:18:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: rml@tech9.net, jyau_kernel_dev@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Message-Id: <20030906231856.6282cd44.akpm@osdl.org>
In-Reply-To: <3F5ABD3A.7060709@cyberone.com.au>
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>
	<1062878664.3754.12.camel@boobies.awol.org>
	<3F5ABD3A.7060709@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> So it is quite sad that the scheduler in 2.6 is
>  sitting there doing nothing but waiting to be obsoleted, while Con's
>  good (and begnin) scheduler patches are waiting around and getting
>  less than 1% of the testing they need.

My concern is the (large) performance regression with specjbb and
volanomark, due to increased idle time.

We cannot just jam all this code into Linus's tree while crossing our
fingers and hoping that something will turn up to fix this problem. 
Because we don't know what causes it, nor whether we even _can_ fix it.

So this is the problem which everyone who is working on the CPU scheduler
should be concentrating on, please.

