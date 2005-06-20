Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVFTUTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVFTUTe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFTURo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:17:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2026 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261517AbVFTUOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:14:23 -0400
Date: Mon, 20 Jun 2005 13:15:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1 compile failure on PPC64
Message-Id: <20050620131513.17c044d3.akpm@osdl.org>
In-Reply-To: <20050620153322.GA4874@elte.hu>
References: <191640000.1119281438@[10.10.2.4]>
	<20050620153322.GA4874@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> > kernel/built-in.o(.init.text+0x440): In function `.sched_cacheflush':
> > : undefined reference to `.cacheflush'
> > make: *** [.tmp_vmlinux1] Error 1
> > 06/20/05-01:28:25 Build the kernel. Failed rc = 2
> > 06/20/05-01:28:25 build: kernel build Failed rc = 1
> > 06/20/05-01:28:25 command complete: (2) rc=126
> > Failed and terminated the run
> >  Fatal error, aborting autorun
> > 
> > Works with some configs, but not this one:
> > 
> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/p570
> > 
> > I'm guessing :
> > 
> > scheduler-cache-hot-autodetect.patch
> 
> the patch below (from akpm) should fix this:

That patch is already in 2.6.12-mm1, so it's not covering all cases
for some reason.
