Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265969AbUFEBgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbUFEBgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 21:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUFEBgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 21:36:20 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:7952 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265969AbUFEBgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 21:36:18 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: wichert@wiggy.net (Wichert Akkerman)
Subject: Re: [2.6.6] Oops when unloading processor module
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Organization: Core
In-Reply-To: <20040604232817.GA11305@wiggy.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BWQ5C-0006cc-00@gondolin.me.apana.org.au>
Date: Sat, 05 Jun 2004 11:34:50 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman <wichert@wiggy.net> wrote:
> Since the IWP2100 driver has some issues with the acpi processor
> module entering C3 I tried to unload the processor module which
> resulted in the oops below.
> 
> 
> Badness in remove_proc_entry at fs/proc/generic.c:685
> Call Trace:
> [<c017d66a>] remove_proc_entry+0x10a/0x150
> [<e08e5f0e>] acpi_thermal_remove_fs+0x1d/0x2d [thermal]
> [<e08e61a7>] acpi_thermal_remove+0x77/0x80 [thermal]
> [<c01eab6d>] acpi_driver_detach+0x39/0x7c
> [<c01eac21>] acpi_bus_unregister_driver+0x12/0x51
> [<e08e61ba>] acpi_thermal_exit+0xa/0x1e [thermal]
> [<c012bf10>] sys_delete_module+0x150/0x1a0
> [<c0142faa>] do_munmap+0x14a/0x190
> [<c010411b>] syscall_call+0x7/0xb

This has been fixed in 2.6.7-rc2 already.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
