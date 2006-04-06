Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWDFQru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWDFQru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWDFQru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:47:50 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:45643 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932187AbWDFQrt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:47:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TqJVoT/MIfeb3HYzRr5hRtLhzyVA1UBe8jO0uFzhAhGAxuGYaNojeXbIVkJVsqAsohDElaAtwVbXRM9RakIfZkWSKUqAs/erLgyPAsKNClrcH+722+tTOEOOuWhkLQLE3SvNOfKw1NZdx4Xw5zZB4tFu4VJwouPMpJHa6VDMVOY=
Message-ID: <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com>
Date: Thu, 6 Apr 2006 19:47:48 +0300
From: "saeed bishara" <saeed.bishara@gmail.com>
To: "Paolo Ornati" <ornati@fastwebnet.it>
Subject: Re: add new code section for kernel code
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
In-Reply-To: <20060406151003.0ef4e637@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
	 <20060406151003.0ef4e637@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I've tried to port this to my kernel (2.6.12.6), but the kenel
fails to boot; it stops after Starting kernel ....
   I tried to add only the CFLAGS += -ffunction-sections to the
arch/arm/Makefile, and it still fails. my tool chains is "gcc version
3.4.4 (release) (CodeSourcery ARM 2005q3-2)"
any ideas?

saeed

On 4/6/06, Paolo Ornati <ornati@fastwebnet.it> wrote:
> On Thu, 6 Apr 2006 15:45:47 +0300
> "saeed bishara" <saeed.bishara@gmail.com> wrote:
>
> >  I'm developing linux kernel for ARM cpu with direct-mapped
> > instruction cache, sometimes I notice that the pefromance of the
> > kernel (for some test) is highly dependent on the code layout, in
> > order to fix that I added new code section, and for each kernel
> > function that highly invokerd I added compiler attribute so it will
> > allocated in that section (exactly as the __init section)
>
> It's already done in 2.6.17-rc1 for x86_64:
>
> Processor type and feature --> Function reordering
>
> arch/x86_64/Kconfig:
>
> config REORDER
>         bool "Function reordering"
>         default n
>         help
>          This option enables the toolchain to reorder functions for a more
>          optimal TLB usage. If you have pretty much any version of binutils,
>          this can increase your kernel build time by roughly one minute.
>
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4bdc3b7f1b730c07f5a6ccca77ee68e044036ffc
>
> --
>         Paolo Ornati
>         Linux 2.6.16.1 on x86_64
>
