Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291012AbSBLMsq>; Tue, 12 Feb 2002 07:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291007AbSBLMsg>; Tue, 12 Feb 2002 07:48:36 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:56515 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S291012AbSBLMsW>;
	Tue, 12 Feb 2002 07:48:22 -0500
Date: Tue, 12 Feb 2002 13:47:51 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Davidovac Zoran <zdavid@unicef.org.yu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about i820 chipset.
In-Reply-To: <Pine.LNX.4.33.0202121321400.7616-100000@unicef.org.yu>
Message-ID: <Pine.LNX.4.21.0202121345430.20359-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Davidovac Zoran wrote:

> try to change slot
> perhaps one of your nic is sharing irq with mouse usb ide
> etc so change slot
> check with more /proc/interrupts

Using an UP kernel with IO-APIC support and MPS 1.4 they don't share irqs:

           CPU0       
  0:   66083638    IO-APIC-edge  timer
  1:        828    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  4:          3    IO-APIC-edge  serial
  8:          0    IO-APIC-edge  rtc
 14:      17840    IO-APIC-edge  ide0
 16:         14   IO-APIC-level  eth2
 17:         12   IO-APIC-level  eth3
 18:      20790   IO-APIC-level  eth0
 19:         39   IO-APIC-level  eth1
NMI:   66083576 
LOC:   66081746 
ERR:          0
MIS:          0

I've tried changing slots aswell and I havn't seen any improvments with
either MPS 1.1 or 1.4
 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

