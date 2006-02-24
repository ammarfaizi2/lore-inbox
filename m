Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWBXP6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWBXP6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWBXP6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:58:52 -0500
Received: from dvhart.com ([64.146.134.43]:34215 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932283AbWBXP6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:58:52 -0500
Message-ID: <43FF2D38.2020602@mbligh.org>
Date: Fri, 24 Feb 2006 07:58:48 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Problems for IBM x440 in 2.6.16-rc4-mm1 and -mm2 (PCI?)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, mainline is fine, but -mm won't boot:

mainline boot log:

http://test.kernel.org/23745/debug/console.log
(-git7)

-mm boot log:
http://test.kernel.org/23752/debug/console.log

It seems to find no PCI devices at all, and I note that when they first
seem to diverge, we get:

PCI: Probing PCI hardware
PCI quirk: region 0440-044f claimed by vt82c686 SMB
PCI->APIC IRQ transform: 0000:00:03.0[A] -> IRQ 39
PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:05.2[D] -> IRQ 47
PCI->APIC IRQ transform: 0000:00:05.3[D] -> IRQ 47
Setting up standard PCI resources

Instead of:

PCI: Probing PCI hardware
PCI quirk: region 0440-044f claimed by vt82c686 SMB
PCI: Discovered peer bus 01
PCI: Discovered peer bus 02
PCI: Discovered peer bus 05
PCI: Discovered peer bus 07
PCI: Discovered peer bus 09
PCI: Discovered peer bus 0c
PCI quirk: region 0440-044f claimed by vt82c686 SMB
PCI: Discovered peer bus 0d
PCI: Discovered peer bus 0e
PCI: Discovered peer bus 11
PCI: Discovered peer bus 13
PCI: Discovered peer bus 15
PCI->APIC IRQ transform: 0000:00:03.0[A] -> IRQ 39
PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:05.2[D] -> IRQ 47
PCI->APIC IRQ transform: 0000:00:05.3[D] -> IRQ 47
PCI->APIC IRQ transform: 0000:01:03.0[A] -> IRQ 40
PCI->APIC IRQ transform: 0000:01:03.1[B] -> IRQ 41
PCI->APIC IRQ transform: 0000:01:04.0[A] -> IRQ 42
PCI->APIC IRQ transform: 0000:02:02.0[A] -> IRQ 55
PCI->APIC IRQ transform: 0000:0c:04.0[A] -> IRQ 118
PCI->APIC IRQ transform: 0000:0d:03.0[A] -> IRQ 142
PCI->APIC IRQ transform: 0000:0d:03.1[B] -> IRQ 143
PCI->APIC IRQ transform: 0000:0d:04.0[A] -> IRQ 144

