Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161497AbWJaHgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161497AbWJaHgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161520AbWJaHgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:36:52 -0500
Received: from mail.gmx.de ([213.165.64.20]:42931 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161497AbWJaHgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:36:52 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@suse.de>
Cc: "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <20061031065912.GA13465@suse.de>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	 <45461977.3020201@shadowen.org> <45461E74.1040408@google.com>
	 <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>
	 <45463481.80601@shadowen.org>
	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	 <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com>
	 <20061031065912.GA13465@suse.de>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 08:36:22 +0100
Message-Id: <1162280182.6416.16.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 22:59 -0800, Greg KH wrote:
> On Mon, Oct 30, 2006 at 10:37:47PM -0800, Martin J. Bligh wrote:
> > Mike Galbraith wrote:
> > >On Mon, 2006-10-30 at 21:14 +0100, Cornelia Huck wrote:
> > >
> > >>Maybe the initscripts have problems coping with the new layout
> > >>(symlinks instead of real devices)?
> > >
> > >SuSE's /sbin/getcfg for one uses libsysfs, which apparently doesn't
> > >follow symlinks (bounces off symlink and does nutty stuff instead).  If
> > >any of the boxen you're having troubles with use libsysfs in their init
> > >stuff, that's likely the problem.
> > 
> > If that is what's happening, then the problem is breaking previously
> > working boxes by changing a userspace API. I don't know exactly which
> > patch broke it, but reverting all Greg's patches (except USB) from
> > -mm fixes the issue.
> 
> Merely change CONFIG_SYSFS_DEPRECATED to be set to yes, and it should
> all work just fine.  Doesn't anyone read the Kconfig help entries for
> new kernel options?

There's another thread concerning that kaboom, and I think the culprit
is known?

	-Mike

