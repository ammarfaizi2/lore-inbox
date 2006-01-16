Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWAPPnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWAPPnN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWAPPnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:43:13 -0500
Received: from pat.uio.no ([129.240.130.16]:23277 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751009AbWAPPnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:43:11 -0500
Subject: Re: Linux 2.6.8 NFS not stateless and random failures?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michael Loftis <mloftis@wgops.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5B305675488C8F97FCE35455@dhcp-2-206.wgops.com>
References: <5B305675488C8F97FCE35455@dhcp-2-206.wgops.com>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 10:42:48 -0500
Message-Id: <1137426168.7853.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.131, required 12,
	autolearn=disabled, AWL 1.68, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 02:01 -0700, Michael Loftis wrote:
> (Sincere apologies if this gets posted twice, old habits die hard, and I 
> was posting to rutgers instead of kernel.org!)
> 
> We recently attempted to upgrade a completely working Linux 2.4 NFS 
> environment to 2.6 based server, nothing else has changed, at all, just the 
> server.
> 
> On with the show, when did the 2.6 series NFS lose it's stateless ability? 
> Now whenever I update NFS exports, or reboot the NFS server, I have to 
> remount or reboot all NFS clients now.  I thought part of the whole point 
> of NFS is it is stateless.  Indeed we didn't have this behavior before 
> 2.6...
> 
> Secondly we're getting weird intermittent failures, most easily seen by the 
> webservers with logs along the lines of below, apparently random, and 
> inconsistent.  I removed the particular path and client from the below log 
> entry.  There is NOT a permissions problem on these elements.  Subsequent 
> accesses will (usually) succeed.  Right after a reboot everything will be 
> fine for a while...then after a bit the webserver starts to get these 
> errors intermittently, with no apparent reasoning behind them.  Again, with 
> 2.4, we had nothing of the sort going on except in the (very very limited 
> and few) legitimate cases caused by customers setting incorrect perms.
> 
> [Sun Jan 15 12:14:00 2006] [error] [client a.b.c.d] (13)Permission denied: 
> access to /path... failed because search permissions are missing on a 
> component of the path
> 
> Debian 3.1 Kernel 2.6.8-2-686-smp w/ ReiserFS on LVM on a qlogic QLA2342 
> (2312) based PCI-X/133Mhz card.

AFAIK, most of these bugs have been fixed.

Please try to reproduce the problems on a more recent kernel, or get
Debian to backport the fixes.

Cheers,
  Trond

