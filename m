Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVETKxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVETKxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 06:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVETKxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 06:53:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:37336 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261409AbVETKxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 06:53:05 -0400
Date: Fri, 20 May 2005 16:22:59 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: vgoyal@in.ibm.com, maneesh@in.ibm.com, coywolf@lovecn.org,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: kexec?
Message-ID: <20050520105259.GC3637@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050508202050.GB13789@charite.de> <200505170011.44196.petkov@uni-muenster.de> <20050517100227.GC6196@in.ibm.com> <200505180958.03570.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505180958.03570.petkov@uni-muenster.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 09:58:03AM +0200, Borislav Petkov wrote:
> On Tuesday 17 May 2005 12:02, Vivek Goyal wrote:
> > On Tue, May 17, 2005 at 12:11:43AM +0200, Borislav Petkov wrote:
> > Hi,
> >
> > > <snip>
> > >
> > > > It will be nice if you could try kdump also on the similar lines.
> > >
> > > HI,
> > >
> > > After patching kexec-tools with the kdump patch here's what I did
> > > according to the test plan:
> > >
> > > 0. load kernel with crashkernel=64M@16M
> > > 1. kexec -p vmlinux --args-linux --append="root=/dev/hda1 init 1" (loads
> > > fine) 2. sysrq+c
> > > the system issues here : SysRq: Trigger a crashdump and hangs so that
> > > even SysRq is dead.
> >
> > Thanks for testing this out. So kexec on panic seems to be hanging. Are you
> > booted in first kernel with commandline option nmi_watchdog? We have a
> > known issue with nmi_watchdog and just now I have posted a patch.
> 
> No, my kernel commandline options are: root=/dev/hda1 vga=0 
> crashkernel=64M@16M


Boris, I used your config files and it is working for me. I disabled kgdb 
from your first config and enabled serial console output in second config.


> 
> > Could you please try loading the new kernel with --console-vga or
> > --console-serial option (depending on what console you are on) and post
> > the output.
> 
> Same thing happens - total lockup.

Second kernel did not have serial console output enabled in config file. Is
it possible to test it out once again with serial console enabled. May be
disable kgdb in first kernel.

With --console-serial option enabled while loading panic kernel (kexec -p) I 
am expecting at least following message on serial console after Sysrq-c.

"I am in purgatory".

It gives me some indicator whether purgatory code started execution or not.

Thanks
Vivek
