Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVCZCZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVCZCZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 21:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVCZCZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 21:25:47 -0500
Received: from fmr23.intel.com ([143.183.121.15]:17366 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261915AbVCZCZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 21:25:40 -0500
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm3
From: Len Brown <len.brown@intel.com>
To: Jason Uhlenkott <jasonuhl@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20050326020212.GC207782@dragonfly.engr.sgi.com>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	 <20050326014327.GB207782@dragonfly.engr.sgi.com>
	 <1111802218.19916.59.camel@d845pe>
	 <20050326020212.GC207782@dragonfly.engr.sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1111803861.19920.91.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2005 21:24:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 21:02, Jason Uhlenkott wrote:
> On Fri, Mar 25, 2005 at 08:56:58PM -0500, Len Brown wrote:
> > Please send me the .config you'd like to build.
> 
> arch/ia64/configs/sn2_defconfig


> > I believe that what we want to do is include CONFIG_PM.
> 
> At first glance, it looks like that will enable suspend/resume
> functionality (which I don't think we want on SGI sn2) for a bunch of
> drivers.

What bad things happen if you define CONFIG_PM on SN2?

Re: CONFIG_ACPI_BOOT
I've got a patch that makes it go away -- this looks like
a good reason for me to dust it off...  Looks like
arch/ia64/Kconfig defines ACPI and then pulls in drivers/acpi/Kconfig,
which it should not do - it should look like i386/Kconfig...

-Len

