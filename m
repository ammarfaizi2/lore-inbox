Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbTIDBx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTIDBx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:53:57 -0400
Received: from www.mail15.com ([194.186.131.96]:23556 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S264527AbTIDBxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:53:05 -0400
Message-ID: <3F569AF8.9040507@myrealbox.com>
Date: Wed, 03 Sep 2003 18:52:56 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tg3/Broadcom gigabit driver just got worse in 2.4.23-pre3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff et all,

I just tried 2.4.23-pre3 with results that are disastrous, for me at least.

As you will remember, I'm the one who has to do an ifconfig down/up cycle
on my asus A7V8X mobo with built-in Broadcom chip.  But after the updates
in -pre3 the chip no longer will work at all.

In fact, if I try 'ifconfig eth0 down' the command hangs forever and chews
up 99.9% of the CPU.  No packets are ever transmitted in spite of a normal
'ifconfig' output after bootup.  The chip is correctly identified in dmesg:

eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit)
10/100/1000BaseT Ethernet 00:e0:18:d2:a6:c1

and lspci:
00:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702 Gigabit Ethernet (rev 02)
         Subsystem: Asustek Computer, Inc.: Unknown device 80a9
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
         Memory at f1800000 (64-bit, non-prefetchable) [size=64K]
         Expansion ROM at f7ff0000 [disabled] [size=64K]
         Capabilities: [40] PCI-X non-bridge device.
         Capabilities: [48] Power Management version 2
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

The data above were taken from 2.6.0-test4, but are the same in 2.4.23-pre3.

I would ask that you please not apple these recent changes to 2.6.0 until
we figure out what the problem is.

Again, I offer to do whatever testing/patching/whatever that I can do to
get this resolved, but you'll need to give me some specific instructions.

Thanks!

