Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbTI3E4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 00:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTI3E4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 00:56:51 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:53188 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263115AbTI3E4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 00:56:49 -0400
Date: Tue, 30 Sep 2003 06:56:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test[56] pcnet32 problems
Message-ID: <20030930045647.GA20742@ucw.cz>
References: <blasc7$jfi$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <blasc7$jfi$1@news.cistron.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 03:13:11AM +0000, Danny ter Haar wrote:
> Got an cyrix box with built in ethernet & 2 extra ethernet cards
> as a firewall at home with a dsl line (connected to eth0)
> 
> pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
> PCI: Found IRQ 11 for device 0000:00:0f.0
> IRQ routing conflict for 0000:00:0f.0, have irq 9, want irq 11
> pcnet32: PCnet/FAST III 79C973 at 0xfca0, warning: CSR address invalid,
>     using instead PROM address of 00 00 e2 24 41 1d assigned IRQ 9.
> eth0: registered as PCnet/FAST III 79C973
> pcnet32: 1 cards_found.
> 
> Sometimes (even during low traffic) eth0 simply locks up:
> In dmesg i see:
> kernel: eth0: Bus master arbitration failure, status 88f3.
> 
> rmmod pcnet32 results in kernel-panic.
> Only reboot works.
> tried:
> acpi == disabled
> pci=noacpi
> 
> Another weird thing is output of ifconfig eth0:
> 
> eth0      Link encap:Ethernet  HWaddr 00:00:E2:24:41:1D  
>           inet addr:195.64.94.48  Bcast:195.64.94.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:30345 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:16042 dropped:0 overruns:0 carrier:16042
>           collisions:0 txqueuelen:1000 
>           RX bytes:38404293 (36.6 MiB)  TX bytes:1298028 (1.2 MiB)
>           Interrupt:9 Base address:0xfca0 
> 
> 0 packets transmitted , all errors ans carrier faults ?
> Still it works! (this could be counters that are wrong)
> 
> kernel config, lspci -v and dmesg output available at:
> 
> http://dth.net/kernel/
> 
> Any help/suggestions/hints appreciated.

Upgrade ifconfig?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
