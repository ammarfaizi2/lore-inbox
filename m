Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbTFASFr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264691AbTFASFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:05:47 -0400
Received: from mx02.qsc.de ([213.148.130.14]:17309 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S264689AbTFASFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:05:42 -0400
Date: Sun, 1 Jun 2003 20:21:07 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: flaw in interrupt-handler - 2.5.69
Message-ID: <20030601182107.GA11856@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.70 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

there seems to be a flaw in the interrupt-handler. When I insert my
pcmcia networking card into my slot the kernel prints error messages to
the logfile. The module of the card gets loaded and it works as
expected. I have the module-init-tools suite and a fairly up-to-date
system. Kernel was 2.5.69, I cannot test 2.5.70 since there's an oops
at the usb spuff on boot. I'm looking into this one.
Here's the logfile:

Jun  1 15:56:56 voyager kernel: irq 11: nobody cared!
Jun  1 15:56:56 voyager kernel: Call Trace: [handle_IRQ_event+148/232]
[do_IRQ+157/280]
+[default_idle+0/40]  [default_ idle+0/40]  [common_interrupt+24/32]
[default_idle+0/40]
+[default_idle+0/40]  [default_idle+35/40]  [cpu_idle+55/72]
[_stext+0/80]  [_stext+77/80]
+[start_kernel+295/304]
Jun  1 15:56:56 voyager kernel: handlers:
Jun  1 15:56:56 voyager kernel: [yenta_interrupt+0/68]
Jun  1 15:56:57 voyager cardmgr[184]: socket 1: 3Com 572/574 Fast
Ethernet
Jun  1 15:56:57 voyager kernel: cs: memory probe 0xa0000000-0xa0ffffff:
clean.
Jun  1 15:56:57 voyager kernel: eth0: 3C574-TX Fast EtherLink PC Card at
io 0x300, irq 4, hw_addr
+00:60:08:B6:42:88.
Jun  1 15:56:57 voyager kernel:   ASIC rev 1, 64K FIFO split 1:1 Rx:Tx,
autoselect MII interface.

If you need something more from me, tell me.


-- 
Regards,

Wiktor Wodecki
