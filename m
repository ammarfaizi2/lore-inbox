Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTKTPyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 10:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTKTPyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 10:54:12 -0500
Received: from intra.cyclades.com ([64.186.161.6]:50583 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261953AbTKTPyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 10:54:11 -0500
Date: Thu, 20 Nov 2003 13:51:49 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Samuel Flory <sflory@rackable.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-rc2 amd64 compile still broken
In-Reply-To: <3FBC176C.3060701@rackable.com>
Message-ID: <Pine.LNX.4.44.0311201348060.1383-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Nov 2003, Samuel Flory wrote:

>    The amd64 compile is still breaking for me.
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.23-rc2/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -mno-red-zone -mcmodel=kernel -pipe 
> -fno-reorder-blocks -finline-limit=2000 -fno-strength-reduce 
> -Wno-sign-compare -fno-asynchronous-unwind-tables    -nostdinc 
> -iwithprefix include -DKBUILD_BASENAME=pci_x86_64  -c -o pci-x86_64.o 
> pci-x86_64.c
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.23-rc2/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -mno-red-zone -mcmodel=kernel -pipe 
> -fno-reorder-blocks -finline-limit=2000 -fno-strength-reduce 
> -Wno-sign-compare -fno-asynchronous-unwind-tables    -nostdinc 
> -iwithprefix include -DKBUILD_BASENAME=pci_pc  -c -o pci-pc.o pci-pc.c
> pci-pc.c:573: redefinition of `use_acpi_pci'
> pci-pc.c:30: `use_acpi_pci' previously defined here
> pci-pc.c:573: warning: `use_acpi_pci' was declared `extern' and later 
> `static'
> {standard input}: Assembler messages:
> {standard input}:1581: Error: symbol `use_acpi_pci' is already defined
> make[1]: *** [pci-pc.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.23-rc2/arch/x86_64/kernel'
> make: *** [_dir_arch/x86_64/kernel] Error 2A

Samuel,

Len Brown just sent me a fix for this.

Can you please try again using the BK tree?





