Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVCVQrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVCVQrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVCVQrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:47:16 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37576 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261424AbVCVQrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:47:00 -0500
Date: Tue, 22 Mar 2005 09:46:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, sameer.abhinkar@intel.com,
       linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: KGDB question
Message-ID: <20050322164657.GD25923@smtp.west.cox.net>
References: <D30E01168D637641AA9D3667F3BB741603F9125F@orsmsx403.amr.corp.intel.com> <20050317135417.6cee8336.akpm@osdl.org> <200503171409.07290.jbarnes@engr.sgi.com> <20050317142958.462822d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317142958.462822d2.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 02:29:58PM -0800, Andrew Morton wrote:
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> >
> > > kgdb patches are maintained in -mm kernels.
> > >
> > > Patches are in
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
> > >-mm1/broken-out/*kgdb*
> > >
> > > And the patch application order is described in
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
> > >-mm1/patch-series -
> > 
> > What's the latest status on these?  Last I heard, some cleanup was going to 
> > happen to make kgdb suitable for the mainline, did that ever happen?
> 
> It part-happened, then the effort seemed to die.

Mutter, mutter, curse, mutter.
We got stuck on things like backtrace going on forever, and then trying
to find a way to get GDB to believe we want it to stop backtracing.  I
think we've finally got that, in a way the GDB folks will approve and
won't horribly clutter the kernel.
We also got stuck on catching memory faults cleanly since it seems the
set_fs(KERNEL_DS) trick we used to use (and I swear worked), stopped
working around 2.6.10, but I haven't found time to go back and verify
when it stopped working.

-- 
Tom Rini
http://gate.crashing.org/~trini/
