Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTH0Uyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbTH0Uyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 16:54:40 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:13836 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262153AbTH0Uyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 16:54:39 -0400
Date: Wed, 27 Aug 2003 22:48:58 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4] make log buffer length selectable
Message-ID: <20030827204858.GA11660@alpha.home.local>
References: <200308251148.h7PBmU8B027700@hera.kernel.org> <20030826042550.GJ734@alpha.home.local> <20030827200922.GH32065@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827200922.GH32065@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 01:09:22PM -0700, Tom Rini wrote:
> On Tue, Aug 26, 2003 at 06:25:50AM +0200, Willy Tarreau wrote:
> > On Mon, Aug 25, 2003 at 04:48:30AM -0700, Marcelo Tosatti wrote:
> > > final:
> > > 
> > > - 2.4.22-rc4 was released as 2.4.22 with no changes.
> > 
> > Hi Marcelo,
> > 
> > as you requested, here is the log_buf_len patch for inclusion in 23-pre.
> 
> Two things.  First, why not ask on every arch like 2.6 does?  Second:

I'm sorry, shame on me. It was an old one that I first showed as an example,
and I blindly resent without checking. I'll do my best to backport code in 2.6
on the next sleepless night.

> > +#if !defined(CONFIG_LOG_BUF_SHIFT) || (CONFIG_LOG_BUF_SHIFT - 0 == 0)
> 
> Why not just || (CONFIG_LOG_BUF_SHIFT == 0) ?

It's an old trick I was used to, but at other places. Basically, it was used
to avoid syntax errors when the macro was not defined, which would lead to
(-0 == 0) which is valid while ( == 0) is not. But it appears that cpp handles
the case correctly so it's not needed here. I'll fix it too.

Marcelo, sorry for this quick patch, I'll better check what I feed you next
time.

Cheers,
Willy

