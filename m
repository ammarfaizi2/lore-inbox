Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270500AbTGSTnB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 15:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270521AbTGSTnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 15:43:00 -0400
Received: from 31.Red-80-25-50.pooles.rima-tde.net ([80.25.50.31]:29568 "EHLO
	femto") by vger.kernel.org with ESMTP id S270500AbTGSTm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 15:42:58 -0400
Date: Sat, 19 Jul 2003 21:57:54 +0200
From: Eric Van Buggenhaut <ericvb@debian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 fails at insmoding orinoco_cs
Message-ID: <20030719195754.GA3687@eric.ath.cx>
Reply-To: Eric.VanBuggenhaut@AdValvas.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Echelon: FBI WTC NSA Handgun Anthrax Afgahnistan Bomb Heroin Laden
X-message-flag: Microsoft discourages the use of Outlook.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just gave a try to 2.6.0-test1, all is fine except there's an IRQ
conflict occuring when modprobing my wireless card's driver:

Jul 19 20:53:37 femto kernel: Linux Kernel Card Services 3.1.22
Jul 19 20:53:37 femto kernel:   options:  [pci] [cardbus] [pm]
Jul 19 20:53:37 femto kernel: PCI: Found IRQ 11 for device 0000:00:0b.0
Jul 19 20:53:37 femto kernel: Yenta IRQ list 06b0, PCI irq11
Jul 19 20:53:37 femto kernel: Socket status: 30000411
Jul 19 20:53:37 femto kernel: PCI: Found IRQ 11 for device 0000:00:0b.1
Jul 19 20:53:37 femto kernel: Yenta IRQ list 06b0, PCI irq11
Jul 19 20:53:37 femto kernel: Socket status: 30000087
Jul 19 20:53:38 femto kernel: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xf0000-0xfffff
Jul 19 20:53:38 femto kernel: orinoco_cs: RequestIRQ: Resource in use

It's the same driver I used with 2.4.21 and it worked fine. Is this a
bug ? I'm not a kernel guru... If you need help to debug, lemme know.

Please CC me on reply.

-- 
Eric VAN BUGGENHAUT
Eric.VanBuggenhaut@AdValvas.be
