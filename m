Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbTGJH05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbTGJH04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:26:56 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:44177 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266291AbTGJH0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:26:55 -0400
Date: Thu, 10 Jul 2003 09:43:54 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: David Lewis <dlewis@vnxsolutions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Bridge problems
Message-ID: <20030710074354.GC26717@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <EMEOIBCHEHCPNABJGHGOKEJOCOAA.dlewis@vnxsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EMEOIBCHEHCPNABJGHGOKEJOCOAA.dlewis@vnxsolutions.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 11:47:24PM -0400, David Lewis wrote:
>Greetings,
>I am running into a problem with some PCI cards and I believe I have it
>narrowed down to the fact that they have PCI-PCI bridges and they dont seem
>to be agreeing with the kernel (2.4.18, 2.4.20, 2.4.21-ac4).

How do you check this ? :)
I wonder if I have the same problem on my mainboard.
Everything is ok under moderate load, but on high load it breaks down
(the system locks up, which makes me suspect some low level issue, like
incorrectly setup PCI bridges ?).

>The cards are a Adlink PCI-8214 dual ethernet nic (Intel 82559 eth
>controller and 21154 pci bridge) and IDS imaging Falcon quatto (4 Bt878
>frame grabbers and a ethernet bridge). Both cards work well with 2.4.18 in a
>motherboard with a single pci bus (Tyan Tiger 200 Apollo Pro 133A dual P3),
>but when used with an Intel SE7500CW2 Dual Xeon (multiple pci busses) they
>become very flaky. My suspicion is that the busses are not being recognized
>correctly, but everything does show up in lspci.

Ah, you have multiple PCI busses and a PCI-PCI bridge, which I don't, so
its not like my problem probably (hm).

vincent@kalimero:~$ lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
AGP Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev
05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
(rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev
03)
00:08.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev
01)
00:0b.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet
Controller (Copper) (rev 01)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev
05)
02:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 10)

regards,

v
