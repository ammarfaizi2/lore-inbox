Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTHWRUf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTHWRAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:00:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263394AbTHWQ56 (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Sat, 23 Aug 2003 12:57:58 -0400
Date: Sat, 23 Aug 2003 18:59:27 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: "Brown, Len" <len.brown@intel.com>
Cc: LKML <linux-kernel@vger.redhat.com>
Subject: Re: 2.6.0-test4 - lost ACPI
Message-ID: <20030823165927.GA1755@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	"Brown, Len" <len.brown@intel.com>,
	LKML <linux-kernel@vger.redhat.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCC7@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FCC7@hdsmsx402.hd.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 12:47:04PM -0400, Brown, Len wrote:
 
> I didn't see which VIA 693 MB you've got, but it could be that a
> BIOS upgrade would move it from 09/13/00 to something past 1/1/2001 --
> the (yes, arbitrary) cutoff for enabling ACPI by default.

It's Matsonic 7132A (http://www.matsonic.com/ms7132a.htm ; 
http://206.135.80.155/manual/ms7132a.pdf).
Pretty nice board. Latest bios for it is dated 09/13/00 and
there is no upgrade.
 
> Or you could add "acpi=force" to your command line, as suggested in the
> dmesg output.

Tried this with strange results - kernel halted during boot,
after displaying:

[... dmesg ...]
PM: Adding info for ide:1.0
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice

HALT. No sysrq, no shift+pgup, no response for power button.

Dmesg _without_ acpi=force: 

hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
PCI: Found IRQ 10 for device 0000:00:0b.0

And so on.

> Or you could change the source to alter or disable #define
> ACPI_BLACKLIST_CUTOFF_YEAR 2001

I will try this next. ACPI was working flawlessly for me almost from
the beginning.

-- 
Tomasz Torcz                                                       72->|   80->|
zdzichu@irc.-nie.spam-.pl                                          72->|   80->|
