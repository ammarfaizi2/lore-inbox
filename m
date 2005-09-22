Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVIVUo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVIVUo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVIVUo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:44:59 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:37896 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751164AbVIVUo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:44:58 -0400
Date: Thu, 22 Sep 2005 16:37:43 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 06/10] uml: run mconsole "sysrq" in process context
Message-ID: <20050922203743.GA11648@ccure.user-mode-linux.org>
References: <200509211923.21861.blaisorblade@yahoo.it> <20050921172857.10219.71071.stgit@zion.home.lan> <20050921205028.GB9918@ccure.user-mode-linux.org> <200509222120.20922.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509222120.20922.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 09:20:20PM +0200, Blaisorblade wrote:
> sysrq t is broken (and stays), 

There's a fix on the way for that.  This has nothing to do with interrupt
context anyway.

> but additionally there are some warnings from 
> some commands (enable sleep inside spinlock checking and spinlock debugging), 
> which go to the down_read inside handle_page_fault IIRC. So try to run in 
> process context.

Which ones?  They should be fixed.

It is fairly fundamental to sysrq that it work from interrupt context.  You
may be diagnosing a system which can't context switch any more.

This patch should be dropped, and the real problems fixed.

				Jeff
