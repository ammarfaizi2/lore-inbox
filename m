Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbUATUM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbUATUM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:12:28 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:59590 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265639AbUATUM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:12:26 -0500
Date: Tue, 20 Jan 2004 12:12:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Patrick Mau <mau@oscar.ping.de>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [SOLVED] Stale Filehandles was: [2.6] nfs_rename: target $file busy, d_count=2
Message-ID: <20040120201212.GH23765@srv-lnx2600.matchmail.com>
Mail-Followup-To: Patrick Mau <mau@oscar.ping.de>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20040116050642.GF1748@srv-lnx2600.matchmail.com> <20040116130336.GA5220@oscar.prima.de> <20040116184031.GM1748@srv-lnx2600.matchmail.com> <20040116185504.GN1748@srv-lnx2600.matchmail.com> <20040117184716.GX1748@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117184716.GX1748@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 10:47:16AM -0800, Mike Fedyk wrote:
> On Fri, Jan 16, 2004 at 10:55:04AM -0800, Mike Fedyk wrote:
> > On Fri, Jan 16, 2004 at 10:40:31AM -0800, Mike Fedyk wrote:
> > > I only had a few nfs clients doing light load, (kde home directories, and
> > > such) and was able to reproduce stale nfs file handles just by running "find
> > > > /dev/null" on the nfs share.
> > > 
> > > Have you tried the -mm tree recently?  2.6.1-mm4 even has some new nfsd
> > > patches in there (maybe you should wait until -mm5 though, there are a few
> > 
> > Stale filehandles is the main problem right now, and I don't see how
> > nfs_raname would be related (just that it was there while I was having
> > trouble with the stale file handles...)
> > 
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/nfsd-01-stale-filehandles-fixes.patch
> > 
> > This one looks particularly interesting...
> > 
> 
> I'm running 2.6.1-bk2-nfs-stale-file-handles on my nfsd server now, and so
> far I haven't seen any stale filehandles.
> 
> Can you guys patch stock 2.6.1 with the above and test also so we can get
> more breadth in the testing results?
> 

Well, it's been running since friday with the same load that killed it in
less than a day, so I'm happy.

And BTW, the code has been merged by Linus and is in 2.6.1-bk6.

Mike
