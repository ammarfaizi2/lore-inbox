Return-Path: <linux-kernel-owner+w=401wt.eu-S1750761AbWLKXyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWLKXyx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWLKXyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:54:53 -0500
Received: from ns.suse.de ([195.135.220.2]:35607 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbWLKXyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:54:52 -0500
From: Neil Brown <neilb@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 12 Dec 2006 10:54:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17789.61385.621098.265840@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1 (md/raid1 randomly drops partitions)
In-Reply-To: message from Rafael J. Wysocki on Tuesday December 12
References: <20061211005807.f220b81c.akpm@osdl.org>
	<200612112341.42140.rjw@sisk.pl>
	<17789.57670.482913.886349@cse.unsw.edu.au>
	<200612120043.22550.rjw@sisk.pl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 12, rjw@sisk.pl wrote:
> On Monday, 11 December 2006 23:52, Neil Brown wrote:
> > On Monday December 11, rjw@sisk.pl wrote:
> > > Hi,
> > > 
> > > On Monday, 11 December 2006 09:58, Andrew Morton wrote:
> > > > 
> > > > Temporarily at
> > > > 
> > > > 	http://userweb.kernel.org/~akpm/2.6.19-mm1/
> > > > 
> > > > Will appear later at
> > > > 
> > > > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/
> > > 
> > > It caused all of the md RAID1s on my test box to drop one of their partitions,
> > > apparently at random.
> > 
> > That's clever....
> > 
> > Do you have any kernel logs of this happening?  My guess would be the
> > underlying device driver is returned more errors than before, but we
> > need the logs to be sure.
> 
> I've only found lots of messages like this:
> 
> md: super_written gets error=-5, uptodate=0

So when md writes to write out the superblock, to gets EIO... Odd that
you aren't getting errors for normal writes.

What devices are the md/raid1 built on?

> 
> I'll try to reproduce it tomorrow and collect some more information.

Thanks.  More information is definitely better than less, so send over
anything you can find.

NeilBrown
