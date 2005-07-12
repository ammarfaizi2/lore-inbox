Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVGLFdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVGLFdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 01:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVGLFdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 01:33:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:11669 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262371AbVGLFdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 01:33:51 -0400
Date: Mon, 11 Jul 2005 22:23:33 -0700
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
Message-ID: <20050712052333.GA11614@kroah.com>
References: <17107.6290.734560.231978@tut.ibm.com> <20050712030555.GA1487@kroah.com> <42D3331F.8020705@opersys.com> <20050712032424.GA1742@kroah.com> <42D33E99.7030101@opersys.com> <20050712043056.GC2363@kroah.com> <42D349C9.3060805@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D349C9.3060805@opersys.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 12:40:41AM -0400, Karim Yaghmour wrote:
> 
> Greg KH wrote:
> > The path/filename dictates how it is used, so putting relayfs type files
> > in debugfs is just fine.  debugfs allows any types of files to be there.
> ...
> > New trees in / are not LSB compliant, hence the reason for writing
> > securityfs to get rid of /selinux and other LSM filesystems that were
> > starting to sprout up.
> ...
> > But that's exactly what debugfs is for, to allow data to be dumped out
> > of the kernel for different usages.
> ...
> > Ok, have a better name for it?  It's simple and easy to understand.
> 
> It also carries with it the stigma of "kernel debugging", which I just
> don't see production system maintainers liking very much.

But they like the name "dtrace" instead?  (sorry, couldn't resist...)

Come on, they will never see the name "debugfs", right?  Your tools will
then have a common place to look for your ltt and other files, as you
_know_ where it will be mounted in the fs namespace.

And you _are_ doing kernel debugging and tracing with ltt, what's wrong
with admitting that?

> So tell you what, how about if we merged what's in debugfs into relayfs
> instead? We'll still end up with one filesystem, but we'll have a more
> inocuous name. After all, if debugfs is indeed for dumping data from the
> kernel to user-space for different usages, then relaying is what it's
> actually doing, right?

Sorry, but debugfs was there first, and people are already using it in
the kernel tree :)

Anyway, good luck trying to get the distros to accept
yet-another-fs-to-mount-somewhere, I know it was hard to get support for
sysfs as it was...

greg k-h
