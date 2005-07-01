Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVGAXmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVGAXmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVGAXlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:41:40 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:22800 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261636AbVGAXlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:41:32 -0400
Date: Fri, 1 Jul 2005 18:56:23 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "blaisorblade@yahoo.it" <blaisorblade_spam@yahoo.it>
Subject: Re: [PATCH 1/2] UML - skas0 - separate kernel address space on stock hosts
Message-ID: <20050701225623.GA28413@ccure.user-mode-linux.org>
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org> <20050701145802.5cebabd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701145802.5cebabd2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 02:58:02PM -0700, Andrew Morton wrote:
> I note that this patch assumes that
> uml-kill-some-useless-vmalloc-tlb-flushing.patch is applied.
> 
> AFAIK that patch is still in limbo due to objections from Paolo.  Can we
> sort that out please?

I did some testing to check that vmalloc is OK.  

First, boot and do a kernel build on COWed devices, which uses vmalloc space
for the block bitmaps.

Second, modprobed all modules, and made sure that one of them actually worked.
Ran a kernel build to induce lots of context switches, made sure it still 
worked.

It sure seems OK to me.

				Jeff
