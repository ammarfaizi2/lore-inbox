Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263713AbRFDT2A>; Mon, 4 Jun 2001 15:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262195AbRFDT1u>; Mon, 4 Jun 2001 15:27:50 -0400
Received: from tartu.cyber.ee ([193.40.32.242]:28173 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S263475AbRFDT1p>;
	Mon, 4 Jun 2001 15:27:45 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac7 usb-uhci appears twice in /proc/interrupts
In-Reply-To: <Pine.LNX.4.33.0106040258200.2088-100000@portland.hansa.lan>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.4.5-ac7 (i586))
Message-Id: <E15700s-0000Nw-00@roos.tartu-labor>
Date: Mon, 04 Jun 2001 21:27:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PR> I don't know, maybe it's Ok, but it looks confusing - usb-uhci is listed
PR> twice on the same IRQ 9.
[...]
PR>   9:          0          XT-PIC  usb-uhci, usb-uhci
[...]
PR> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
PR> 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)

This is normal, you do have two of these.

But a there's a little copy-paste error(?) on uhci.c:
both usb-uhci.c and uhci.c register themselves as usb-uhci.
(in request_region and request_irq and uhci_pci_driver).

--
Meelis Roos (mroos@linux.ee)
