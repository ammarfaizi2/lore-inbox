Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWF3Hdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWF3Hdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWF3Hdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:33:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56030 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751219AbWF3Hdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:33:50 -0400
Date: Fri, 30 Jun 2006 00:33:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm4
Message-Id: <20060630003336.4cbc4c3b.akpm@osdl.org>
In-Reply-To: <44A4D036.1040501@reub.net>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<44A3BD65.3070201@reub.net>
	<20060629105215.02587a67.akpm@osdl.org>
	<44A4D036.1040501@reub.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 19:18:14 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> > - Confirm that it is reproducible.
> 
> It is.  3 out of 3 times that I booted into -mm4, that oops has appeared on 
> shutdown.

yeah, I just hit it too.  Right toward the end of a massive `yum upgrade' and
now I don't know whether or not to blame RH for this:

/etc/profile.d/kde.sh:4: = not found

> > - If it is, test http://www.zip.com.au/~akpm/linux/patches/stuff/rf.bz2. 
> >   That's a patch against 2.6.17.  It's basically -mm4, with
> >   ro-bind-mounts-*.patch removed (and with x86[_64] generic IRQ wired up). 
> >   If that fails in the same way, we know that
> >   destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch is
> >   the bad guy.
> 
> It oopsed again the fourth time which was built with rf.tar.gz, so it looks like 
> it's not that patch.  It's definitely the same oops though, the call trace is 
> identical.  I changed the version number slightly to identify it:

Thanks, I dropped the patch.
