Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVCZC6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVCZC6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 21:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVCZC6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 21:58:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6308 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261920AbVCZC6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 21:58:44 -0500
Date: Fri, 25 Mar 2005 18:57:04 -0800
From: Jason Uhlenkott <jasonuhl@sgi.com>
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm3
Message-ID: <20050326025704.GE207782@dragonfly.engr.sgi.com>
References: <20050325002154.335c6b0b.akpm@osdl.org> <20050326014327.GB207782@dragonfly.engr.sgi.com> <1111802218.19916.59.camel@d845pe> <20050326020212.GC207782@dragonfly.engr.sgi.com> <1111803861.19920.91.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111803861.19920.91.camel@d845pe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 09:24:21PM -0500, Len Brown wrote:
> What bad things happen if you define CONFIG_PM on SN2?

None, other than slightly enlarging the kernel with some
suspend/resume stuff we don't care about.  It's always been
unavailable for SN2 builds:

depends on IA64_GENERIC || IA64_DIG || IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB

but there doesn't appear to be any particular reason for that other
than us not needing it (and in fact SN2 systems can run IA64_GENERIC
kernels with CONFIG_PM enabled without incident).

> Re: CONFIG_ACPI_BOOT
> I've got a patch that makes it go away -- this looks like
> a good reason for me to dust it off...  Looks like
> arch/ia64/Kconfig defines ACPI and then pulls in drivers/acpi/Kconfig,
> which it should not do - it should look like i386/Kconfig...

Sounds good to me.  Does that mean everything currently controlled by
CONFIG_ACPI_BOOT will be controlled by CONFIG_ACPI instead?
