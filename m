Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVLaJUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVLaJUa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 04:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVLaJUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 04:20:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28307 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932111AbVLaJU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 04:20:29 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051230221222.GJ3356@waste.org>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org>  <20051230221222.GJ3356@waste.org>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 10:20:20 +0100
Message-Id: <1136020820.2901.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 16:12 -0600, Matt Mackall wrote:
> On Wed, Dec 28, 2005 at 08:11:50PM -0800, Andrew Morton wrote:
> > If no-forced-inlining makes the kernel smaller then we probably have (yet
> > more) incorrect inlining.  We should hunt those down and fix them.  We did
> > quite a lot of this in 2.5.x/2.6.early.  Didn't someone have a script which
> > would identify which functions are a candidate for uninlining?
> 
> It was a combination of a tool I wrote for -tiny, which added
> deprecation warnings to inlines along with a post-processing tool to
> count instantiations, nestings, etc., and a post-post-processing tool
> written by Denis Vlasenko that guessed at the space usage.


my current patch to deinline a bunch of big offenders is at
http://www.fenrus.org/noinline

(it's on the big side for lkml for now)

