Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422829AbWJaG7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWJaG7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWJaG7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:59:46 -0500
Received: from ns1.suse.de ([195.135.220.2]:54508 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422829AbWJaG7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:59:46 -0500
Date: Mon, 30 Oct 2006 22:59:12 -0800
From: Greg KH <gregkh@suse.de>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Mike Galbraith <efault@gmx.de>, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061031065912.GA13465@suse.de>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <45461977.3020201@shadowen.org> <45461E74.1040408@google.com> <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com> <45463481.80601@shadowen.org> <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com> <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4546EF3B.1090503@google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 10:37:47PM -0800, Martin J. Bligh wrote:
> Mike Galbraith wrote:
> >On Mon, 2006-10-30 at 21:14 +0100, Cornelia Huck wrote:
> >
> >>Maybe the initscripts have problems coping with the new layout
> >>(symlinks instead of real devices)?
> >
> >SuSE's /sbin/getcfg for one uses libsysfs, which apparently doesn't
> >follow symlinks (bounces off symlink and does nutty stuff instead).  If
> >any of the boxen you're having troubles with use libsysfs in their init
> >stuff, that's likely the problem.
> 
> If that is what's happening, then the problem is breaking previously
> working boxes by changing a userspace API. I don't know exactly which
> patch broke it, but reverting all Greg's patches (except USB) from
> -mm fixes the issue.

Merely change CONFIG_SYSFS_DEPRECATED to be set to yes, and it should
all work just fine.  Doesn't anyone read the Kconfig help entries for
new kernel options?

thanks,

greg k-h
