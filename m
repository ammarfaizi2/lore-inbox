Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWC1T50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWC1T50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 14:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWC1T50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 14:57:26 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:28876 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751253AbWC1T5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 14:57:25 -0500
Subject: Re: 2.6.16-mm2
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060328193815.GA63865@muc.de>
References: <20060328003508.2b79c050.akpm@osdl.org>
	 <1143569778.26106.5.camel@dyn9047017100.beaverton.ibm.com>
	 <20060328111101.463d09e2.akpm@osdl.org>  <20060328193815.GA63865@muc.de>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 11:59:19 -0800
Message-Id: <1143575959.26106.20.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 21:38 +0200, Andi Kleen wrote:
> On Tue, Mar 28, 2006 at 11:11:01AM -0800, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > On Tue, 2006-03-28 at 00:35 -0800, Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm2/
> > > > 
> > > > 
> > > > - It seems to compile.
> > > 
> > > Well, depends :)
> > > 
> > > Ran into this on -mm1 also. Haven't digged into finding out why ?
> > > 
> > >   LD      init/built-in.o
> > >   LD      .tmp_vmlinux1
> > > arch/x86_64/mm/built-in.o(.init.text+0x1298): In function `__change_page_attr':
> > > arch/x86_64/mm/pageattr.c:58: undefined reference to `srat_reserve_add_area'
> > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > > Ideas ?
> > > 
> > 
> > Yes, that'll happen.  I guess you'll need to set CONFIG_ACPI_NUMA for now.
> 
> Fixed.
> 
> (I could have sworn i added that ifdef earlier already, weird)
> 
> -Andi (who thinks we have too many CONFIGs)

Thanks. Setting CONFIG_X86_64_ACPI_NUMA=y solved my problem.

I carry around known-to-work .config file for each machine and don't
bother selecting new config options :(

