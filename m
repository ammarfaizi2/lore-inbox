Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUBLLqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 06:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUBLLqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 06:46:51 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50595 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266344AbUBLLqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 06:46:49 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Dott. Surricani" <surricani@surricani.cjb.net>
Subject: Re: Oops with SAtA siimage module
Date: Thu, 12 Feb 2004 12:51:52 +0100
User-Agent: KMail/1.5.3
References: <402A88A6.4000704@surricani.cjb.net>
In-Reply-To: <402A88A6.4000704@surricani.cjb.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402121251.52987.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Already fixed, please update kernel to 2.6.2-rc2.

On Wednesday 11 of February 2004 20:55, Dott. Surricani wrote:
> Unable to handle kernel paging request at virtual address 868b502e
>   printing eip:
> f884e8b5
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<f884e8b5>]    Not tainted
> EFLAGS: 00010286
> EIP is at ide_pci_register_host_proc+0x25/0x40 [ide_core]
> eax: 868b501e   ebx: f880c00d   ecx: 00070000   edx: f882565c
> esi: f7e5c000   edi: e3000000   ebp: f7e5c000   esp: f7a21e4c
> ds: 007b   es: 007b   ss: 0068
> Process insmod (pid: 17, threadinfo=f7a20000 task=f7a23980)
> Stack: f882206b f882565c f880c000 00000200 f882220f f7e5c000 0000000d
> f8822413
>         000000c9 f7e5c000 f8822413 f7a21ee0 f882508f f7e5c000 f8822413
> 000000c9
>         f8823298 00000001 c000be89 00000002 f884bf45 f7e5c000 f8822413
> f7e5c000
> Call Trace:
>   [<f882206b>] proc_reports_siimage+0x9b/0xb0 [siimage]
>   [<f882220f>] setup_mmio_siimage+0x18f/0x1a0 [siimage]
>   [<f882508f>] init_chipset_siimage+0x8f/0x280 [siimage]
>   [<f884bf45>] do_ide_setup_pci_device+0x105/0x160 [ide_core]
>   [<f884bfba>] ide_setup_pci_device+0x1a/0x70 [ide_core]
>   [<f8822257>] siimage_init_one+0x37/0xa0 [siimage]
>   [<c0188f2c>] pci_device_probe_static+0x2c/0x50
>   [<c0188f6f>] __pci_device_probe+0x1f/0x40
>   [<c0188fac>] pci_device_probe+0x1c/0x40
>   [<c01be9f1>] bus_match+0x31/0x60
>   [<c01beae0>] driver_attach+0x40/0x80
>   [<c01bed3b>] bus_add_driver+0x6b/0x90
>   [<c01bf114>] driver_register+0x34/0x40
>   [<c0189154>] pci_register_driver+0x54/0x80
>   [<f884c116>] ide_pci_register_driver+0x36/0x50 [ide_core]
>   [<f88222ca>] siimage_ide_init+0xa/0x10 [siimage]
>   [<c0130704>] sys_init_module+0xf4/0x200
>   [<c010a6ef>] syscall_call+0x7/0xb
>
> Code: 83 78 10 00 75 f7 89 50 10 c3 90 89 15 54 04 86 f8 c3 89 f6

