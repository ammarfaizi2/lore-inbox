Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265914AbUAPUQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbUAPUQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:16:37 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:54189 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265914AbUAPUQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:16:34 -0500
Date: Fri, 16 Jan 2004 12:16:23 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Patrick Mau <mau@oscar.ping.de>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Stale Filehandles was: [2.6] nfs_rename: target $file busy, d_count=2
Message-ID: <20040116201623.GO1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Patrick Mau <mau@oscar.ping.de>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20040116050642.GF1748@srv-lnx2600.matchmail.com> <20040116130336.GA5220@oscar.prima.de> <20040116184031.GM1748@srv-lnx2600.matchmail.com> <20040116185504.GN1748@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116185504.GN1748@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 10:55:04AM -0800, Mike Fedyk wrote:
> On Fri, Jan 16, 2004 at 10:40:31AM -0800, Mike Fedyk wrote:
> > I only had a few nfs clients doing light load, (kde home directories, and
> > such) and was able to reproduce stale nfs file handles just by running "find
> > > /dev/null" on the nfs share.
> > 
> > Have you tried the -mm tree recently?  2.6.1-mm4 even has some new nfsd
> > patches in there (maybe you should wait until -mm5 though, there are a few
> 
> Stale filehandles is the main problem right now, and I don't see how
> nfs_raname would be related (just that it was there while I was having
> trouble with the stale file handles...)
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/nfsd-01-stale-filehandles-fixes.patch
> 
> This one looks particularly interesting...
> 

Most of the nfs client patches are for NFS4 or RPCSEC_GSS.  Except for:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/

nfs-26-sock_disconnect.patch
nfs-31-attr.patch
nfs-client-deadlock-fix.patch
nfs-fix-bogus-setattr-calls.patch
nfs-open-intent-fix.patch
nfs-optimise-COMMIT-calls.patch
nfs-readonly-mounts-fix.patch
nfs-rpc-debug-oops-fix.patch

These might be interesting to test, but so far I haven't had troubles with
the stock Linus 2.6 nfs3 client.

Mike
