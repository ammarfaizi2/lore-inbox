Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267946AbUHEUhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267946AbUHEUhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267941AbUHEUhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:37:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:3554 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267946AbUHEUg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:36:56 -0400
Date: Thu, 5 Aug 2004 22:32:05 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Duffy <tduffy@sun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix x86_64 build of mmconfig.c
Message-Id: <20040805223205.3dd2ee1a.ak@suse.de>
In-Reply-To: <1091728096.10131.16.camel@duffman>
References: <1091728096.10131.16.camel@duffman>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2004 10:48:16 -0700
Tom Duffy <tduffy@sun.com> wrote:

> Signed-by: Tom Duffy <tduffy@sun.com>
> 
>   gcc -Wp,-MD,arch/x86_64/pci/.mmconfig.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/build1/tduffy/openib-work/linux-2.6.8-rc3-openib/include -I/build1/tduffy/openib-work/linux-2.6.8-rc3-openib/arch/x86_64/pci -Iarch/x86_64/pci -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -mno-red-zone -mcmodel=kernel -pipe -fno-reorder-blocks -Wno-sign-compare -fno-asynchronous-unwind-tables -O2 -fomit-frame-pointer -Wdeclaration-after-statement -I/build1/tduffy/openib-work/linux-2.6.8-rc3-openib/ -I arch/i386/pci  -DKBUILD_BASENAME=mmconfig -DKBUILD_MODNAME=mmconfig -c -o arch/x86_64/pci/mmconfig.o /build1/tduffy/openib-work/linux-2.6.8-rc3-openib/arch/x86_64/pci/mmconfig.c
> /build1/tduffy/openib-work/linux-2.6.8-rc3-openib/arch/x86_64/pci/mmconfig.c:10:17: pci.h: No such file or directory
> 
> --- arch/x86_64/pci/Makefile.orig	2004-08-05 09:54:24.932007000 -0700
> +++ arch/x86_64/pci/Makefile	2004-08-05 09:53:53.171006000 -0700
> @@ -3,7 +3,7 @@
>  #
>  # Reuse the i386 PCI subsystem
>  #
> -CFLAGS += -I arch/i386/pci
> +CFLAGS += -Iarch/i386/pci

It never failed this way for me in hundreds of builds. Why is it failing for you? 
What gcc version do you use? 

Normally -Ifoo and -I foo should be really equivalent.

-Andi
