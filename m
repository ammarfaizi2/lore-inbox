Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133051AbRAHV5M>; Mon, 8 Jan 2001 16:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135312AbRAHV5E>; Mon, 8 Jan 2001 16:57:04 -0500
Received: from abort.boom.net ([66.54.4.10]:58373 "HELO abort.boom.net")
	by vger.kernel.org with SMTP id <S132964AbRAHV4b>;
	Mon, 8 Jan 2001 16:56:31 -0500
Date: Mon, 8 Jan 2001 13:56:29 -0800
From: Taner Halicioglu <taner@taner.net>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 and EMU10K1 problems...
Message-ID: <20010108135629.S3871@boom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-URL: http://www.taner.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me if you reply - thanks :)

I probably missed a message or note or something about this, but when I went
from 2.2.17 to 2.2.18, my sound card (SB Live!) stopped working.  It seems
that in 2.2.18, it gets detected TWICE:

--------------------------------
kernel: Linux version 2.2.18
[...]
kernel: Creative EMU10K1 PCI Audio Driver, version 0.7, 20:05:23 Jan  7 2001 
kernel: emu10k1: EMU10K1 rev 5 model 0x21 found, IO at 0xb400-0xb41f, IRQ 10 
[... IDE, floppy, SCSI, eth0, partition check ...]
kernel: Creative EMU10K1 PCI Audio Driver, version 0.7, 20:05:23 Jan  7 2001 
--------------------------------

This is what it normally does:

--------------------------------
kernel: Linux version 2.2.17
[...]
kernel: Creative EMU10K1 PCI Audio Driver, version 0.6, 20:25:53 Jan  7 2001 
kernel: emu10k1: EMU10K1 rev 5 model 0x21 found, IO at 0xb400-0xb41f, IRQ 10 
[...]
--------------------------------

In the 2.2.18 case, /proc/interrupts doesn't show anything on int 10.

I guess I should (and will) take this up with the EMU10k people, but I was
just wondering if anyone here has seen this problem before?  I'm curious how
a broken driver would have made it into .18 like that ;-)  ...unless I'm the
one that is broken :)

Thanks,

	-Taner
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
