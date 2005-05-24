Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVEXPzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVEXPzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVEXPxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:53:02 -0400
Received: from fmr24.intel.com ([143.183.121.16]:26528 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262140AbVEXPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:52:25 -0400
Date: Tue, 24 May 2005 08:51:13 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org, zwane@arm.linux.org.uk,
       rusty@rustycorp.com.au, vatsa@in.ibm.com, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [patch 1/4] CPU Hotplug support for X86_64
Message-ID: <20050524085112.A20866@unix-os.sc.intel.com>
References: <20050524081113.409604000@csdlinux-2.jf.intel.com> <20050524081304.011927000@csdlinux-2.jf.intel.com> <20050524121542.GA86182@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050524121542.GA86182@muc.de>; from ak@muc.de on Tue, May 24, 2005 at 02:15:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 02:15:42PM +0200, Andi Kleen wrote:
> On Tue, May 24, 2005 at 01:11:14AM -0700, Ashok Raj wrote:
> >   * RED-PEN audit/test this more. I bet there is more state messed up here.
> >   */
> > -static __cpuinit void disable_smp(void)
> > +static __init void disable_smp(void)
> 
> Why all these cpuinit->init changes? I think they should stay __cpuinit
> 
> The other way round looks ok.

disable_smp() is called only in smp_prepare_cpus() which is not required 
for hotplug. Its currently only required only for startup, and not later.

I changed the ones from __cpuinit to __init, just in functions marked 
with paranoia... i think it can stay cpuinit, unless there is another reason
i didnt catch.

> 
> -Andi

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
