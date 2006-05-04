Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWEDVZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWEDVZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWEDVZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:25:05 -0400
Received: from kenga.kmv.ru ([217.13.212.5]:39375 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S1751366AbWEDVZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:25:03 -0400
From: Andrey Melnikoff <temnota+news@kmv.ru>
To: cel@citi.umich.edu
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: 2.6.17-rc3 PCI init hang
In-Reply-To: <44565BB9.8020504@citi.umich.edu>
X-Newsgroups: gmane.linux.kernel
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.17-rc2 (i686))
Message-Id: <E1FblP5-00057m-Uo@BlackLife.kmv.ru>
Date: Fri, 05 May 2006 01:30:32 +0400
X-AV-Scanned: Clamav!
X-Data-Status: msg.XXs81GD0:23244@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <44565BB9.8020504@citi.umich.edu> you wrote:
> Newsgroups: gmane.linux.kernel

> I have a dual Pentium III I use for testing.  Since late last week 
> (around about 2.6.17-rc3) it hangs during boot just after "Setting up 
> standard PCI resources".  2.6.17-rc2 works fine.

Same situation, random hung when apply quirk_usb_early_handoff.
Intel SCB2 board, dual PIII, 2Gb memory.

> A push in the right direction would be appreciated.  Please reply off 
> list as I'm not subscribed.

Try compile USB stuff as modules or without it. 

For me 2.6.16.9 kernel with CONFIG_USB=m works.

> ...

> PCI: PCI BIOS revision 2.10 entry at 0xfdbc1, last bus=1
> Setting up standard PCI resources

>  >>> 2.6.17-rc3 stops here and hangs.
>  >>> 2.6.17-rc2 continues with:

> PCI: Probing PCI hardware
> PCI: Discovered peer bus 01
> PCI: Using IRQ router ServerWorks [1166/0200] at 0000:00:0f.0
> PCI->APIC IRQ transform: 0000:00:03.0[A] -> IRQ 31
> PCI->APIC IRQ transform: 0000:01:03.0[A] -> IRQ 23
> PCI: Cannot allocate resource region 0 of device 0000:00:0f.2
> ...

> lspci -v:

[skipp]

> 00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 04) 
> (prog-if 10 [OHCI])
>          Subsystem: Broadcom OSB4/CSB5 OHCI USB Controller
>          Flags: medium devsel
>          Memory at 30000000 (32-bit, non-prefetchable) [size=4K]

0000:00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
        Subsystem: Intel Corporation: Unknown device 340f
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at fea40000 (32-bit, non-prefetchable) [size=4K]
00: 66 11 20 02 17 00 80 02 05 10 03 0c 08 40 00 00
10: 00 00 a4 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0f 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 50
