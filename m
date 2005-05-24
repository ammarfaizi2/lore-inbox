Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVEXSUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVEXSUE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEXSUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:20:04 -0400
Received: from colin.muc.de ([193.149.48.1]:9481 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261946AbVEXSSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:18:53 -0400
Date: 24 May 2005 20:18:51 +0200
Date: Tue, 24 May 2005 20:18:51 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, zwane@arm.linux.org.uk, rusty@rustycorp.com.au,
       vatsa@in.ibm.com, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [patch 1/4] CPU Hotplug support for X86_64
Message-ID: <20050524181851.GH86233@muc.de>
References: <20050524081113.409604000@csdlinux-2.jf.intel.com> <20050524081304.011927000@csdlinux-2.jf.intel.com> <20050524121542.GA86182@muc.de> <20050524085112.A20866@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524085112.A20866@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 08:51:13AM -0700, Ashok Raj wrote:
> On Tue, May 24, 2005 at 02:15:42PM +0200, Andi Kleen wrote:
> > On Tue, May 24, 2005 at 01:11:14AM -0700, Ashok Raj wrote:
> > >   * RED-PEN audit/test this more. I bet there is more state messed up here.
> > >   */
> > > -static __cpuinit void disable_smp(void)
> > > +static __init void disable_smp(void)
> > 
> > Why all these cpuinit->init changes? I think they should stay __cpuinit
> > 
> > The other way round looks ok.
> 
> disable_smp() is called only in smp_prepare_cpus() which is not required 
> for hotplug. Its currently only required only for startup, and not later.
> 
> I changed the ones from __cpuinit to __init, just in functions marked 
> with paranoia... i think it can stay cpuinit, unless there is another reason
> i didnt catch.

Ok. Makes sense.

But how about all the other functions that you changed too? Can you
double check them. SOme looked suspicious.

-Andi
