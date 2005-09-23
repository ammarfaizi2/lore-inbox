Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVIWHlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVIWHlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVIWHlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:41:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57741 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750728AbVIWHlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:41:18 -0400
Date: Fri, 23 Sep 2005 00:40:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 06/10] uml: run mconsole "sysrq" in process
 context
Message-Id: <20050923004031.6b7da42a.akpm@osdl.org>
In-Reply-To: <20050922203743.GA11648@ccure.user-mode-linux.org>
References: <200509211923.21861.blaisorblade@yahoo.it>
	<20050921172857.10219.71071.stgit@zion.home.lan>
	<20050921205028.GB9918@ccure.user-mode-linux.org>
	<200509222120.20922.blaisorblade@yahoo.it>
	<20050922203743.GA11648@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> On Thu, Sep 22, 2005 at 09:20:20PM +0200, Blaisorblade wrote:
> > sysrq t is broken (and stays), 
> 
> There's a fix on the way for that.  This has nothing to do with interrupt
> context anyway.
> 
> > but additionally there are some warnings from 
> > some commands (enable sleep inside spinlock checking and spinlock debugging), 
> > which go to the down_read inside handle_page_fault IIRC. So try to run in 
> > process context.
> 
> Which ones?  They should be fixed.
> 
> It is fairly fundamental to sysrq that it work from interrupt context.  You
> may be diagnosing a system which can't context switch any more.
> 
> This patch should be dropped, and the real problems fixed.
> 

Well Linus has just merged this patch.  If you hadn't removed me from the
cc yesterday this would not have happened.

