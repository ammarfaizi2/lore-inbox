Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVLDKG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVLDKG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 05:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVLDKG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 05:06:28 -0500
Received: from hell.sks3.muni.cz ([147.251.210.189]:168 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1750719AbVLDKG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 05:06:28 -0500
Date: Sun, 4 Dec 2005 11:05:56 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: CX8800 driver and 2.6.15-RC2
Message-ID: <20051204100556.GD11293@mail.muni.cz>
References: <20051202201408.GA11046@mail.muni.cz> <4390B0A7.8060306@m1k.net> <20051203180740.GA11293@mail.muni.cz> <439209C6.9080004@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <439209C6.9080004@m1k.net>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 04:10:30PM -0500, Michael Krufky wrote:
> Which card do you have?  What card # does it report in dmesg?  What 
> tuner # is it using?  What is the PCI Subsystem id?

This is from dmesg:
cx2388x v4l2 driver version 0.0.5 loaded
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 18 (level, low) -> IRQ 19
CORE cx88[0]: subsystem: 107d:6611, board: Leadtek Winfast 2000XP Expert
[card=5,autodetected]
TV tuner 44 at 0x1fe, Radio tuner -1 at 0x1fe
cx88[0]: Leadtek Winfast 2000XP Expert config: tuner=38, eeprom[0]=0x01
input: cx88 IR (Leadtek Winfast 2000XP as /class/input/input2
cx88[0]/0: found at 0000:01:05.0, rev: 5, irq: 19, latency: 64, mmio: 0xfd000000
tuner 0-0060: All bytes are equal. It is not a TEA5767
tuner 0-0060: chip found @ 0xc0 (cx88[0])
tuner 0-0060: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3))
tda9887 0-0043: chip found @ 0x86 (cx88[0])
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
cx88[0]/0: registered device radio0


I have Leadtek Winfast 2000XP Expert (it means, it's detected correctly)

However, I see it's a little bit confused about tunner - once it reports tunner
# 44 and # 38.

I noticed some messages from /var/log/messages:
kernel: cx88[0]: video y / packed - dma channel status dump
kernel: cx88[0]:   cmds: initial risc: 0x07e15000
kernel: cx88[0]:   cmds: cdt base    : 0x00180440
kernel: cx88[0]:   cmds: cdt size    : 0x0000000c
kernel: cx88[0]:   cmds: iq base     : 0x00180400
kernel: cx88[0]:   cmds: iq size     : 0x00000010
kernel: cx88[0]:   cmds: risc pc     : 0x07e15034
kernel: cx88[0]:   cmds: iq wr ptr   : 0x00000109
kernel: cx88[0]:   cmds: iq rd ptr   : 0x0000010d
kernel: cx88[0]:   cmds: cdt current : 0x00000488
kernel: cx88[0]:   cmds: pci target  : 0x06ecf000
kernel: cx88[0]:   cmds: line / byte : 0x03200000
kernel: cx88[0]:   risc0: 0x80008200 [ sync resync count=512 ]
kernel: cx88[0]:   risc1: 0x1c000300 [ write sol eol count=768 ]
kernel: cx88[0]:   risc2: 0x0720f000 [ INVALID eol irq2 irq1 21 resync 14 13 12 count=0 ]
kernel: cx88[0]:   risc3: 0x1c000300 [ write sol eol count=768 ]
kernel: cx88[0]:   iq 0: 0x0720f300 [ INVALID eol irq2 irq1 21 resync 14 13 12 count=768 ]
kernel: cx88[0]:   iq 1: 0x1c000300 [ write sol eol count=768 ]
kernel: cx88[0]:   iq 2: 0x0720f600 [ arg #1 ]
kernel: cx88[0]:   iq 3: 0x1c000300 [ write sol eol count=768 ]
kernel: cx88[0]:   iq 4: 0x0720f900 [ arg #1 ]
kernel: cx88[0]:   iq 2: 0x0720f600 [ arg #1 ]
kernel: cx88[0]:   iq 3: 0x1c000300 [ write sol eol count=768 ]
kernel: cx88[0]:   iq 4: 0x0720f900 [ arg #1 ]
kernel: cx88[0]:   iq 5: 0x1c000300 [ write sol eol count=768 ]
kernel: cx88[0]:   iq 6: 0x0720fc00 [ arg #1 ]
kernel: cx88[0]:   iq 7: 0x18000100 [ write sol count=256]
kernel: cx88[0]:   iq 8: 0x0720ff00 [ arg #1 ]
kernel: cx88[0]:   iq 9: 0x1c000300 [ write sol eol count=768 ]
kernel: cx88[0]:   iq a: 0x06eced00 [ arg #1 ]
kernel: cx88[0]:   iq b: 0x71010000 [ jump irq1 cnt0 count=0 ]
kernel: cx88[0]:   iq c: 0x80008200 [ arg #1 ]
kernel: cx88[0]:   iq d: 0x1c000300 [ write sol eol count=768 ]
kernel: cx88[0]:   iq e: 0x0720f000 [ arg #1 ]
kernel: cx88[0]:   iq f: 0x1c000300 [ write sol eol count=768 ]
kernel: cx88[0]:   iq 10: 0x00180c00 [ arg #1 ]
kernel: cx88[0]: fifo: 0x00180c00 -> 0x183400
kernel: cx88[0]: ctrl: 0x00180400 -> 0x180460
kernel: cx88[0]:   ptr1_reg: 0x00180c00
kernel: cx88[0]:   ptr2_reg: 0x00180448
kernel: cx88[0]:   cnt1_reg: 0x00000000
kernel: cx88[0]:   cnt2_reg: 0x00000000
kernel: cx88[0]/0: [c1299580/0] timeout - dma=0x07e15000
kernel: cx88[0]/0: [c1299b80/1] timeout - dma=0x06ecd000


> The following MIGHT fix it.... If so, I'll need the answers to the four 
> questions above, in order to make this behavior occur by default:
> 
> modprobe  tda9887

Ok, I try it on next weekend (unfortunately, I'm able to do test only on
weekends).

-- 
Luká¹ Hejtmánek
