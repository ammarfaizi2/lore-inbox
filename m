Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUEPVaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUEPVaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 17:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbUEPVaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 17:30:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:62903 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261830AbUEPV3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 17:29:54 -0400
Date: Sun, 16 May 2004 14:29:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: andrea@suse.de, torvalds@osdl.org, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040516142916.7d07c9f3.akpm@osdl.org>
In-Reply-To: <200405161519.03834.elenstev@mesatop.com>
References: <200405132232.01484.elenstev@mesatop.com>
	<200405160928.22021.elenstev@mesatop.com>
	<20040516203818.GY3044@dualathlon.random>
	<200405161519.03834.elenstev@mesatop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> Anyway, although the regression for my particular machine for this
>  particular load may be interesting, the good news is that I've seen
>  none of the failures which started this whole thread, which are relatively
>  easily reproduceable with PREEMPT set.  

So...  would it be correct to say that with CONFIG_PREEMPT, ppp or its
underlying driver stack

a) screws up the connection and hangs and

b) scribbles on pagecache?

Because if so, the same will probably happen on SMP.
