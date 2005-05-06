Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVEFXC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVEFXC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVEFXAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:00:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56079 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261336AbVEFW6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:58:51 -0400
Date: Fri, 6 May 2005 23:58:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, davej@redhat.com, torvalds@osdl.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050506235842.A23651@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, davej@redhat.com,
	torvalds@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050304113626.E3932@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Fri, Mar 04, 2005 at 11:36:26AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 11:36:26AM +0000, Russell King wrote:
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
> 
> I was thinking at the time "great, this is one problem which should be
> solved".  How silly of me.  It seems, yet again, that it comes down to
> a case of "if rmk doesn't do it, it won't get done."  Sad but true.
> Now, why do I keep feeling that I'm being taken advantage of all the
> time?  Could it be the complete lack of productive help from anyone else.
> 
> Anyway, going back to why -mm doesn't work:
> 
>  arch/arm/kernel/built-in.o(.init.text+0xb64): In function `$a':
>  : undefined reference to `rd_size'
>  make[1]: *** [.tmp_vmlinux1] Error 1
> 
> So "rd_size" got deleted in -mm kernels without reference to anyone else
> who's using it.  Greeeeaaatttt....

And guess what?  This patch is now in Linus kernel. Greeeeaaaattttt
stuff whoever did that.  Truely wonderful job.

Thanks for taking notice of me a month ago.  I really appreciate it.
Especially when stuff gets merged which has already been pointed out
as needlessly _BREAKING_ stuff.

Linus - please revert the change which caused this.

  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/kernel/built-in.o(.init.text+0x9d4): In function `$a':
: undefined reference to `rd_size'
make: *** [.tmp_vmlinux1] Error 1

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
