Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVKLSkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVKLSkN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVKLSkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:40:12 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:8867 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932454AbVKLSkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:40:10 -0500
Date: Sat, 12 Nov 2005 11:40:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sven-Thorsten Dietrich <sven@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.14-rt11 3/3] Fix ppc32 bootwrapper code for new zlib
Message-ID: <20051112183322.GB3839@smtp.west.cox.net>
References: <20051111204312.11609.23222.sendpatchset@localhost.localdomain> <20051111204331.11609.46440.sendpatchset@localhost.localdomain> <20051112142428.GC24163@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051112142428.GC24163@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 03:24:28PM +0100, Ingo Molnar wrote:
> 
> * Tom Rini <trini@kernel.crashing.org> wrote:
> 
> > Make the ppc32 bootwrapper code mirror what the ppc64 version does to 
> > clean out locking, etc, from lib/zlib_inflate/
> > 
> > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> why is this needed in -rt? Shouldnt this go upstream?

This is only needed by the 'add spinlocks/etc to zlib_inflate' changes
that aren't in 2.6.14 stock at least, and I don't think will be in
2.6.15-rc1.

The slightly better solution is I need to talk with Matt Mackall about
his zlib changes and how he thinks p*pc* can be done better, but without
duplicating code again.

-- 
Tom Rini
http://gate.crashing.org/~trini/
