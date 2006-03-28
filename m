Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWC1TLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWC1TLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 14:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWC1TLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 14:11:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751243AbWC1TLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 14:11:22 -0500
Date: Tue, 28 Mar 2006 11:11:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.16-mm2
Message-Id: <20060328111101.463d09e2.akpm@osdl.org>
In-Reply-To: <1143569778.26106.5.camel@dyn9047017100.beaverton.ibm.com>
References: <20060328003508.2b79c050.akpm@osdl.org>
	<1143569778.26106.5.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Tue, 2006-03-28 at 00:35 -0800, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm2/
> > 
> > 
> > - It seems to compile.
> 
> Well, depends :)
> 
> Ran into this on -mm1 also. Haven't digged into finding out why ?
> 
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/mm/built-in.o(.init.text+0x1298): In function `__change_page_attr':
> arch/x86_64/mm/pageattr.c:58: undefined reference to `srat_reserve_add_area'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Ideas ?
> 

Yes, that'll happen.  I guess you'll need to set CONFIG_ACPI_NUMA for now.
