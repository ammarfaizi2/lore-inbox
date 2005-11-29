Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVK2Vyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVK2Vyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVK2Vyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:54:41 -0500
Received: from solarneutrino.net ([66.199.224.43]:62724 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932434AbVK2Vyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:54:40 -0500
Date: Tue, 29 Nov 2005 16:54:35 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: NFS oops on 2.6.14.2
Message-ID: <20051129215435.GA6483@tau.solarneutrino.net>
References: <20051129200013.GB6326@tau.solarneutrino.net> <1133299597.17363.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1133299597.17363.2.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 04:26:37PM -0500, Trond Myklebust wrote:
> Both presumably following a server reboot?
> 
> Do you have any sure-fire way to reproduce it?

Correct.  The server crashed and rebooted this morning but I didn't see
anything like this (these happened a few days ago after another
mysterious server reboot).  I'll be rebooting the server again tonight,
so we'll see.  So no, I don't yet have a sure-fire way to reproduce.

> > These machines have an NFS-mounted root, but this is mounted nolock so I'm
> > assuming that's unrelated.  The other NFS mounts have options like:
> > 
> > rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,udp,lock
> > 
> > I've also been seeing lots of the "do_vfs_lock: VFS is out of sync with lock
> > manager!", but that has been happening at least since 2.6.13.
> 
> That is usually the result of doing kill -9/kill -TERM/kill -INT on a
> process that was in the act of grabbing a lock.

OK, well it doesn't seem to cause any problems so I guess I'll ignore
it.  Just wanted to mention it since it sounds kind of ominous.

Thanks,
-ryan
