Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUCBBu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 20:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUCBBu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 20:50:29 -0500
Received: from aun.it.uu.se ([130.238.12.36]:55175 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261537AbUCBBuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 20:50:24 -0500
Date: Tue, 2 Mar 2004 02:50:22 +0100 (MET)
Message-Id: <200403020150.i221oMpr024937@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: gf435@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: GigaBit Netdriver instability
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Feb 2004 18:57:32 +0100, Otto Meier wrote:
>I try to run a Dlink DGE-550T 64bit PCI Gigabit Card
>with the driver dl2k and kernel 2.6.3-mm4. on a dual
>athlon-MP MSI 6501 board.
>
>With some heavier load on the net (transfering 2 1-Gbyte files to 2 
>different clients on the net
>2 100Mbit connections)
>
>I get following messages in syslog
>
>APIC error on CPU0: 02(02)
>Feb 28 16:23:33 gate2 kernel: APIC error on CPU1: 02(02)
>Feb 28 16:23:38 gate2 kernel: eth0: Transmit error, TxStatus 400270f, 
>FrameId 67108864
>
>after some several of these messages the network connection stops.

02 is "receive checksum error". Your mainboard is
corrupting messages on the APIC bus. That's extremely bad.

Many people have had problems with older dual-Athlon boards.
Ensure that the power supply and cooling solution are adequate,
and that the memory modules are certified.

Failing that, try the "noapic" kernel parameter.
