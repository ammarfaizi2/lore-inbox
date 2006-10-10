Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWJJRwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWJJRwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWJJRwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:52:46 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:43403 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S964846AbWJJRwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:52:45 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 10 Oct 2006 13:51:09 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Auke Kok <auke-jan.h.kok@intel.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, NetDev <netdev@vger.kernel.org>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH] ixgb: Delete IXGB_DBG() macro and call pr_debug()
 directly.
In-Reply-To: <452BCF5C.2090407@intel.com>
Message-ID: <Pine.LNX.4.64.0610101347270.10344@localhost.localdomain>
References: <Pine.LNX.4.64.0610100816440.7711@localhost.localdomain>
 <452BC6C9.3050902@intel.com> <Pine.LNX.4.64.0610101227170.9699@localhost.localdomain>
 <452BCF5C.2090407@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Auke Kok wrote:

> Robert P. J. Day wrote:

... snip ...

> >   if someone wants to tell me what, in the context of ixgb_main.c,
> > i would use as that "dev" argument [for dev_dbg], i'm all for
> > that.
>
> (CC netdev since it's a network driver topic).
>
> all our macro's (e100, e1000, ixgb) use adapter->netdev->name
> inserted through the DPRINTK macro.
>
> if you'd really want to clean it all up, you'd have to replace all
> DPRINTK() calls with dev_dbg(adapter->netdev->name, ....) which
> would just make it more lengthy and uncomfortable to read.
>
> which puts this in a bigger perspective. I suppose the nicest way to do
> program these is to do something like this:
>
> #define ixgb_dbg(args...) dev_dbg(adapter->netdev->name, args)
> #define ixgb_err(args...) dev_err(adapter->netdev->name, args)
> #define ixgb_info(args...) dev_info(adapter->netdev->name, args)
>
> and use those consistently throughout the driver, ditto for e100/e1000.
>
> I'll look into it and see what I can do.

um, yeah.  i'm rapidly getting out of my comfort zone here.  this
seemed like such a simple submission six hours ago.  :-)  live and
learn.

rday
