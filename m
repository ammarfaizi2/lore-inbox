Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVCDMUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVCDMUC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVCDMSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:18:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:30430 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262896AbVCDLpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:45:13 -0500
Date: Fri, 4 Mar 2005 03:44:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: davej@redhat.com, torvalds@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304034410.2ccfba74.akpm@osdl.org>
In-Reply-To: <20050304113626.E3932@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002733.GH10124@redhat.com>
	<20050302203812.092f80a0.akpm@osdl.org>
	<20050304105247.B3932@flint.arm.linux.org.uk>
	<20050304032632.0a729d11.akpm@osdl.org>
	<20050304113626.E3932@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Fri, Mar 04, 2005 at 03:26:32AM -0800, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >
> > > On Wed, Mar 02, 2005 at 08:38:12PM -0800, Andrew Morton wrote:
> > >  > Grump.  Have all these regressions received the appropriate level of
> > >  > visibility on this mailing list?
> > > 
> > >  Looking at the http://l4x.org/k/ site, it appears that all -mm versions
> > >  have broken ARM support with the defconfig, while Linus kernels at least
> > >  build fine.
> > 
> > It's very much in an arch maintainer's interest to make sure that
> > cross-compilers are easily obtainable.  Any hints?
> 
> Been trying to achieve that since it's a FAQ on ARM lists.  Even gone to
> the extent of setting up a separate mailing list, getting a volunteer to
> track what people want and do the hard work to build them.  That was
> about 6 months ago, and I haven't seen any results.

hm.  That's strange.  I'd have thought that 99% of the arm embedded
developers cross-build.

> Anyway, going back to why -mm doesn't work:
> 
>  arch/arm/kernel/built-in.o(.init.text+0xb64): In function `$a':
>  : undefined reference to `rd_size'
>  make[1]: *** [.tmp_vmlinux1] Error 1
> 
> So "rd_size" got deleted in -mm kernels without reference to anyone else
> who's using it.  Greeeeaaatttt....

Ah.  Fixed, thanks.
