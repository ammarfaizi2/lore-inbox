Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264870AbRFTKAD>; Wed, 20 Jun 2001 06:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264871AbRFTJ7x>; Wed, 20 Jun 2001 05:59:53 -0400
Received: from malvek.artecdesign.ee ([194.204.53.4]:61530 "EHLO
	malvek.artecdesign.ee") by vger.kernel.org with ESMTP
	id <S264870AbRFTJ7s>; Wed, 20 Jun 2001 05:59:48 -0400
Message-ID: <3B307415.C80C0C59@artecdesign.ee>
Date: Wed, 20 Jun 2001 11:59:50 +0200
From: Heiki Kask <heiki.kask@artecdesign.ee>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cs5530 and UDMA implementation questions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have following problems/questions I could not find answer from the
kernel source code:

- cs5530.c does not initialize hwif->speedproc hook. This means that
hdparm -X does not call routine for chipset registers reprogramming.
Did I miss something?

- how chipset/disk initialization is supposed to work?

When kernel is compiled without CONFIG_IDEDMA_PCI_AUTO, then there are
no calls performed to initialize  chipset for PIO or UDMA mode and
therefore there is no possibility to recalculate IDE timings for
different bus speeds (if it is implemented)  before root filesystem gets
mounted.
This  is basically OK when BIOS or BIOS replacement is initializing
IDE controller to match the bus speed and the kernel does not make
attempt to reprogram IDE controller, but then there is no sense to
implement the feature at all because nobody will change bus speed at
runtime, I guess.

Thanks for listening.

heiki





