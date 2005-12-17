Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVLQHC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVLQHC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 02:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVLQHC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 02:02:27 -0500
Received: from solarneutrino.net ([66.199.224.43]:61190 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751159AbVLQHC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 02:02:26 -0500
Date: Sat, 17 Dec 2005 02:02:22 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: lockd: couldn't create RPC handle for (host)
Message-ID: <20051217070222.GD20539@tau.solarneutrino.net>
References: <20051216205536.GA20497@tau.solarneutrino.net> <1134776945.7952.4.camel@lade.trondhjem.org> <20051216235841.GA20539@tau.solarneutrino.net> <1134797577.20929.2.camel@lade.trondhjem.org> <20051217055907.GC20539@tau.solarneutrino.net> <1134801822.7946.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1134801822.7946.4.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 01:43:42AM -0500, Trond Myklebust wrote:
> On Sat, 2005-12-17 at 00:59 -0500, Ryan Richter wrote:
> 
> > There's no filtering between the two.  I get this on the machine itself:
> > $ rpcinfo -u localhost 100021
> > rpcinfo: RPC: Timed out
> > program 100021 version 0 is not available
> > zsh: exit 1     rpcinfo -u localhost 100021
> > 
> > There's no lockd process running on this client machine anymore.
> 
> ...yet the client still has the partition mounted, and isn't using the
> -onolock option? That sounds weird.

There are lots of nfs mounts, the root is ro nolock, but the trouble is
with the home directories which are rw lock.  Everything is still
mounted, I can ssh in fine etc.  The problem is with people using kde -
it tries to lock some file in the home directory during the login
process and hangs.

> Is the client also running 2.6.15-rc5?

No, 2.6.14.2.

-ryan
