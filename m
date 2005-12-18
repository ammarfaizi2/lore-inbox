Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965297AbVLRWoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbVLRWoP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbVLRWoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:44:15 -0500
Received: from solarneutrino.net ([66.199.224.43]:6407 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S965297AbVLRWoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:44:15 -0500
Date: Sun, 18 Dec 2005 17:44:10 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: lockd: couldn't create RPC handle for (host)
Message-ID: <20051218224409.GA21709@tau.solarneutrino.net>
References: <20051217055907.GC20539@tau.solarneutrino.net> <1134801822.7946.4.camel@lade.trondhjem.org> <20051217070222.GD20539@tau.solarneutrino.net> <1134847699.7950.25.camel@lade.trondhjem.org> <20051217194553.GE20539@tau.solarneutrino.net> <1134894836.7931.17.camel@lade.trondhjem.org> <20051218180150.GF20539@tau.solarneutrino.net> <1134934267.7966.37.camel@lade.trondhjem.org> <20051218200052.GA21665@tau.solarneutrino.net> <1134944665.11596.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1134944665.11596.9.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 05:24:24PM -0500, Trond Myklebust wrote:
> On Sun, 2005-12-18 at 15:00 -0500, Ryan Richter wrote:
> > On Sun, Dec 18, 2005 at 02:31:07PM -0500, Trond Myklebust wrote:
> > > On Sun, 2005-12-18 at 13:01 -0500, Ryan Richter wrote:
> > > > Code: 48 39 78 18 75 1c 8b 86 8c 00 00 00 a8 01 74 12 83 c8 02 89 
> > > > RIP <ffffffff801dbd9e>{nlmclnt_mark_reclaim+62} RSP <ffff81007dfade70>
> > > > CR2: 0000000000000018
> > > 
> > > Looks like the global lock list is corrupted. Could you cat the contents
> > > of /proc/locks?
> > 
> > $ cat /proc/locks
> > 1: POSIX  ADVISORY  WRITE 1657 00:0e:1771273 0 EOF
> > 2: FLOCK  ADVISORY  WRITE 1486 00:0e:1770759 0 EOF
> > 3: FLOCK  ADVISORY  WRITE 1478 00:0e:1770399 0 EOF
> 
> OK. I think this client patch ought to fix the Oopses. It should apply
> to a 2.6.14 kernel as well as 2.6.15-rc5.

Thanks, I'm testing it now, although I'm not sure how much testing it
will get before the new year.

Cheers,
-ryan
