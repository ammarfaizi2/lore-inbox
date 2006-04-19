Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWDSH0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWDSH0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWDSH0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:26:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750716AbWDSH0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:26:16 -0400
Date: Wed, 19 Apr 2006 00:25:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc1-mm3] doesn't compile (msi/smp.h compile error)
Message-Id: <20060419002527.185503d9.akpm@osdl.org>
In-Reply-To: <20060419045734.GA30172@amd64.of.nowhere>
References: <20060419045734.GA30172@amd64.of.nowhere>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jurriaan <thunder7@xs4all.nl> wrote:
>
> INTEL :make bzImage
>    CHK     include/linux/version.h
>    CHK     include/linux/compile.h
>    CC      drivers/pci/msi-apic.o
>  In file included from include/asm/msi.h:11,
>                   from drivers/pci/msi.h:71,
>                   from drivers/pci/msi-apic.c:8:
>  include/asm/smp.h:104: error: syntax error before '->' token
>  make[2]: *** [drivers/pci/msi-apic.o] Error 1
>  make[1]: *** [drivers/pci] Error 2
>  make: *** [drivers] Error 2
> 
>  #
>  # Automatically generated make config: don't edit

There's something wrong with the .config you've sent.  When I put it into a
2.6.17-rc1-mm3 tree and do `make oldconfig' there are a huge number of
promptings and CONFIG_PCI_MSI ends up getting disabled, so
drivers/pci/msi-apic.c won't be compiled anyway.

So I think you need to send the real .config, please.
