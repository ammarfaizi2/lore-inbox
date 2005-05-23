Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVEWQ7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVEWQ7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 12:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVEWQ7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 12:59:08 -0400
Received: from fmr24.intel.com ([143.183.121.16]:7897 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261916AbVEWQ7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 12:59:03 -0400
Date: Mon, 23 May 2005 09:58:17 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, zwane@arm.linux.org.uk,
       discuss@x86-64.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/4] CPU hot-plug support for x86_64
Message-ID: <20050523095816.B8193@unix-os.sc.intel.com>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050520223417.532048000@csdlinux-2.jf.intel.com> <20050523163816.GA39821@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050523163816.GA39821@muc.de>; from ak@muc.de on Mon, May 23, 2005 at 06:38:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 06:38:16PM +0200, Andi Kleen wrote:
> On Fri, May 20, 2005 at 03:16:24PM -0700, Ashok Raj wrote:
> > Experimental CPU hotplug patch for x86_64
> > -----------------------------------------
> > - Most of init code that needs to be there for hotplug marked now as __devinit
> > 	(Didn't use cpuinit, simply because the main framework code in kernel
> > 	 is not the same way, just trying to be consistent)
> 
> I dont like that. Can you keep it as __cpuinit please?  e.g. 
> if cpuhot plug turns out to be a lot of code we could later
> mark it free when we detect at boot the system does not support
> cpu hotplug. With devinit that is pretty much impossible these days.
> 
> Also it is better for documentation purposes.

If its for documentation, then its ok, the reason i thought it will
be dead code/documentation soon is since 90% of the hotplug code is
generic kernel code, which is not under __cpuinit, just some pieces of 
x86_64 would alone exist this way, and will not serve real purpose very soon.

If you still prefer to exist as __cpuinit, i dont have a problem leaving them
around for the time being.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
