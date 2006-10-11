Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWJKBQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWJKBQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 21:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWJKBQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 21:16:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932291AbWJKBQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 21:16:16 -0400
Date: Tue, 10 Oct 2006 18:15:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bryce Harrington <bryce@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.19-rc1-mm1:  fs/file.c138 on ia64
Message-Id: <20061010181553.21a5141f.akpm@osdl.org>
In-Reply-To: <20061011010826.GA15741@osdl.org>
References: <20060316170814.02fa55a1.akpm@osdl.org>
	<20060317084653.GA4515@in.ibm.com>
	<20060317010412.3243364c.akpm@osdl.org>
	<20061006231012.GH22139@osdl.org>
	<20061006162924.344090f8.akpm@osdl.org>
	<20061007000031.GI22139@osdl.org>
	<20061007103559.GC30034@elf.ucw.cz>
	<20061007204220.GB24743@osdl.org>
	<20061008182941.GA8308@osiris.ibm.com>
	<20061008191447.GD3788@elf.ucw.cz>
	<20061011010826.GA15741@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 18:08:26 -0700
Bryce Harrington <bryce@osdl.org> wrote:

> On Sun, Oct 08, 2006 at 09:14:47PM +0200, Pavel Machek wrote:
> > On Sun 2006-10-08 20:29:41, Heiko Carstens wrote:
> > > > > > We've been running this testsuite fairly continuously for several
> > > > > > months, and irregularly for about a year before that.  We find that on
> > > > > > some platforms like PPC64 it's quite robust, and on others there are
> > > > > > issues, but the developers tend to be quick to provide fixes as the
> > > > > > issues are found.  I'm glad to see that the results are finally showing
> > > > > > green for ia64.
> 
> Spoke too soon.  ;-)
> 
> We've noticed a new ia64 issue on the 2.6.19-rc1-mm1 kernel.  It has not
> occurred on other 2.6.19 kernels we've tested.  We aslo encountered this
> BUG only on ia64; the x86 and x86_64 systems booted without issue.
> Apologies if this is already known; I didn't spot it in the list
> archives.
> 
> I have hotplug-cpu configured for this machine, however I don't know if
> it has anything to do with this BUG.  I can test with it turned of if
> it'd help.
> 
> The line referred to in the output is in copy_fdtable():
>         BUG_ON(nfdt->max_fds < ofdt->max_fds);
> 
> 
> http://crucible.osdl.org/runs/2511/sysinfo/ita01.console.log
> 
> Freeing unused kernel memory: 1840kB freed
> kernel BUG at fs/file.c:138!

Was that with
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/hot-fixes
applied?
