Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWJaH7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWJaH7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWJaH7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:59:02 -0500
Received: from cantor2.suse.de ([195.135.220.15]:19892 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422700AbWJaH7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:59:00 -0500
Date: Mon, 30 Oct 2006 23:58:25 -0800
From: Greg KH <gregkh@suse.de>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Mike Galbraith <efault@gmx.de>, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061031075825.GA8913@suse.de>
References: <45461977.3020201@shadowen.org> <45461E74.1040408@google.com> <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com> <45463481.80601@shadowen.org> <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com> <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com> <20061031065912.GA13465@suse.de> <4546FB79.1060607@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4546FB79.1060607@google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 11:30:01PM -0800, Martin J. Bligh wrote:
> Greg KH wrote:
> >On Mon, Oct 30, 2006 at 10:37:47PM -0800, Martin J. Bligh wrote:
> >>Mike Galbraith wrote:
> >>>On Mon, 2006-10-30 at 21:14 +0100, Cornelia Huck wrote:
> >>>
> >>>>Maybe the initscripts have problems coping with the new layout
> >>>>(symlinks instead of real devices)?
> >>>SuSE's /sbin/getcfg for one uses libsysfs, which apparently doesn't
> >>>follow symlinks (bounces off symlink and does nutty stuff instead).  If
> >>>any of the boxen you're having troubles with use libsysfs in their init
> >>>stuff, that's likely the problem.
> >>If that is what's happening, then the problem is breaking previously
> >>working boxes by changing a userspace API. I don't know exactly which
> >>patch broke it, but reverting all Greg's patches (except USB) from
> >>-mm fixes the issue.
> >
> >Merely change CONFIG_SYSFS_DEPRECATED to be set to yes, and it should
> >all work just fine.  Doesn't anyone read the Kconfig help entries for
> >new kernel options?
> 
> 1. This doesn't fix it.

I think acpi is now being fingered here, right?

> 2. Breaking things by default with an option to unbreak them is not
> the finest of plans ;-)

Yes, I have now changed the default for that option to be on to help
guide people even better than before.

thanks,

greg k-h
