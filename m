Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVCZB5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVCZB5U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 20:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVCZB5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 20:57:20 -0500
Received: from fmr22.intel.com ([143.183.121.14]:8633 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261446AbVCZB5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 20:57:16 -0500
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm3
From: Len Brown <len.brown@intel.com>
To: Jason Uhlenkott <jasonuhl@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20050326014327.GB207782@dragonfly.engr.sgi.com>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	 <20050326014327.GB207782@dragonfly.engr.sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1111802218.19916.59.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2005 20:56:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 20:43, Jason Uhlenkott wrote:
> On Fri, Mar 25, 2005 at 12:21:54AM -0800, Andrew Morton wrote:
> >  bk-acpi.patch
> 
> This doesn't build for SGI sn2:
> 
> arch/ia64/kernel/mca.c: In function `ia64_mca_init':
> arch/ia64/kernel/mca.c:1394: error: `ACPI_INTERRUPT_CPEI' undeclared
> (first use in this function)
> arch/ia64/kernel/mca.c:1394: error: (Each undeclared identifier is
> reported only once
> arch/ia64/kernel/mca.c:1394: error: for each function it appears in.)
> make[1]: *** [arch/ia64/kernel/mca.o] Error 1
> make: *** [arch/ia64/kernel] Error 2
> 
> This is because we lost CONFIG_ACPI_BOOT -- it now depends on
> CONFIG_PM, which we don't have (or want) on sn2.  The following fixes
> it, but I'm not sure what the original rationale was.  Len?
> 
> Signed-off-by: Jason Uhlenkott <jasonuhl@sgi.com>
> 

Please send me the .config you'd like to build.
I believe that what we want to do is include CONFIG_PM.
Note also that CONFIG_ACPI_BOOT will be going away --
to be replaced simply by CONFIG_ACPI.

thanks,
-Len


