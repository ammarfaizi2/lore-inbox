Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966347AbWKNXM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966347AbWKNXM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966442AbWKNXM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:12:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966347AbWKNXM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:12:27 -0500
Date: Tue, 14 Nov 2006 15:09:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
Subject: Re: 2.6.19-rc5-mm2: warnings in MODPOST and later
Message-Id: <20061114150902.f772c75c.akpm@osdl.org>
In-Reply-To: <20061114225622.GO22565@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061114225622.GO22565@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 23:56:22 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> Since people were recently complaining about too many warnings:
> Here is a list of the warnings I'm getting in MODPOST and later.
> 
> Since the warnings by far exceed the 100kB limit of linux-kernel (sic), 
> I had to attach them compressed.
> 
> With the exception of the "drivers/ide/pci/atiixp:FFFF05", none of these 
> warnings is present in Linus' tree.

yes, lots of new section mismatch warnings.

A large number of them are due to the paravirt patches:

WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458470) and '__stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458478) and '__stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458480) and '__stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458488) and '__stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458490) and '__stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458498) and '__stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc04584a0) and '__stop_parainstructions'
WARNING: Can't handle masks in drivers/ata/ahci:FFFF05
WARNING: drivers/ata/pata_legacy.o - Section mismatch: reference to .init.text: from .parainstructions after '' (at offset 0x18)
WARNING: drivers/ata/pata_legacy.o - Section mismatch: reference to .init.text: from .parainstructions after '' (at offset 0x20)
WARNING: drivers/ata/pata_legacy.o - Section mismatch: reference to .init.text: from .parainstructions after '' (at offset 0x28)
WARNING: drivers/ata/pata_qdi.o - Section mismatch: reference to .init.text: from .parainstructions after '' (at offset 0x0)
WARNING: drivers/ata/pata_qdi.o - Section mismatch: reference to .init.text: from .parainstructions after '' (at offset 0x8)

but there are others too.

