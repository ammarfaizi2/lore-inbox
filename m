Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRKER0E>; Mon, 5 Nov 2001 12:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281254AbRKERZx>; Mon, 5 Nov 2001 12:25:53 -0500
Received: from colorfullife.com ([216.156.138.34]:13329 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S281251AbRKERZi>;
	Mon, 5 Nov 2001 12:25:38 -0500
Message-ID: <3BE6CB90.D08FB64C@colorfullife.com>
Date: Mon, 05 Nov 2001 18:25:36 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.13-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Who sees "IRQ routing conflict" in dmesg?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who has a line
	IRQ routing conflict for 01:23.4, have irq 5, want irq 6
in his dmesg dump?

If you find that line, please send me the relevant lines from the dmesg
dump, lspci -vx and cat /proc/interrupts. And obviously: does everything
work.

Thanks,
	Manfred

Background:
Linux always uses the interrupts choosen by the bios. The bios stores
the irq number in PCI_INTERRUPT_LINE, and configures the irq router
accordingly.
If both do not match, then the above message is printed.
Right now the kernel uses the value from PCI_INTERRUPT_LINE, and ignores
the irq router.
That doesn't work with some vaio's, but before submitting that change to
Linus I want to verify that this won't break other setups.
