Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWJaHXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWJaHXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422897AbWJaHXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:23:10 -0500
Received: from ns2.suse.de ([195.135.220.15]:58287 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422893AbWJaHXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:23:08 -0500
Date: Mon, 30 Oct 2006 23:22:41 -0800
From: Greg KH <gregkh@suse.de>
To: Mike Galbraith <efault@gmx.de>
Cc: "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061031072241.GB7306@suse.de>
References: <45461977.3020201@shadowen.org> <45461E74.1040408@google.com> <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com> <45463481.80601@shadowen.org> <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com> <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com> <20061031065912.GA13465@suse.de> <1162278594.6416.4.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162278594.6416.4.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:09:54AM +0100, Mike Galbraith wrote:
> On Mon, 2006-10-30 at 22:59 -0800, Greg KH wrote:
> > On Mon, Oct 30, 2006 at 10:37:47PM -0800, Martin J. Bligh wrote:
> > > Mike Galbraith wrote:
> > > >On Mon, 2006-10-30 at 21:14 +0100, Cornelia Huck wrote:
> > > >
> > > >>Maybe the initscripts have problems coping with the new layout
> > > >>(symlinks instead of real devices)?
> > > >
> > > >SuSE's /sbin/getcfg for one uses libsysfs, which apparently doesn't
> > > >follow symlinks (bounces off symlink and does nutty stuff instead).  If
> > > >any of the boxen you're having troubles with use libsysfs in their init
> > > >stuff, that's likely the problem.
> > > 
> > > If that is what's happening, then the problem is breaking previously
> > > working boxes by changing a userspace API. I don't know exactly which
> > > patch broke it, but reverting all Greg's patches (except USB) from
> > > -mm fixes the issue.
> > 
> > Merely change CONFIG_SYSFS_DEPRECATED to be set to yes, and it should
> > all work just fine.  Doesn't anyone read the Kconfig help entries for
> > new kernel options?
> 
> That's terminal here atm:  kernel BUG at arch/i386/mm/pageattr.c:165!
> 
> I did have it set, but had to disable it to not panic.

I think there are two different issues here.  That kernel config option
should not be causing an oops in mm code.

Can you bisect the different patches to see which one causes the
problem?

thanks,

greg k-h
