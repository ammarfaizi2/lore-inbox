Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbULCPdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbULCPdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 10:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbULCPdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 10:33:44 -0500
Received: from smtp06.web.de ([217.72.192.224]:47518 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S262268AbULCPdl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 10:33:41 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.9] irq 19: nobody cared
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Date: Fri, 3 Dec 2004 16:33:38 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412031633.38900.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I already got this several times, any ideas whats causing it? I have disabled 
apic for now in the bios, which makes usb and sound to share the interrupt:

11:      11507          XT-PIC  Ensoniq AudioPCI, uhci_hcd, uhci_hcd

As far as I remember, with enabled apic irq 19 is only used by the soundcard, 
if this might be interesting, I can look this up later on.

Here the oops with enabled APIC:

Dec  3 14:30:44 bathl kernel: irq 19: nobody cared!
Dec  3 14:30:44 bathl kernel:  [<c0106b4a>] __report_bad_irq+0x2a/0x90
Dec  3 14:30:44 bathl kernel:  [<c0106c3c>] note_interrupt+0x6c/0xa0
Dec  3 14:30:44 bathl kernel:  [<c0106f11>] do_IRQ+0x121/0x130
Dec  3 14:30:44 bathl kernel:  [<c0104c28>] common_interrupt+0x18/0x20
Dec  3 14:30:44 bathl kernel:  [<e0caf6ed>] uhci_free_pending_qhs+0x4d/0x60 
[uhci_hcd]
Dec  3 14:30:44 bathl kernel:  [<e0caf974>] uhci_irq+0xf4/0x1e0 [uhci_hcd]
Dec  3 14:30:44 bathl kernel:  [<c01245eb>] update_wall_time+0xb/0x40
Dec  3 14:30:44 bathl kernel:  [<c02d35d6>] usb_hcd_irq+0x36/0x70
Dec  3 14:30:44 bathl kernel:  [<c0106ae4>] handle_IRQ_event+0x34/0x70
Dec  3 14:30:44 bathl kernel:  [<c0106e81>] do_IRQ+0x91/0x130
Dec  3 14:30:44 bathl kernel:  [<c0104c28>] common_interrupt+0x18/0x20
Dec  3 14:30:44 bathl kernel:  [<c0102030>] default_idle+0x0/0x30
Dec  3 14:30:44 bathl kernel:  [<c0102053>] default_idle+0x23/0x30
Dec  3 14:30:44 bathl kernel:  [<c01020ca>] cpu_idle+0x3a/0x60
Dec  3 14:30:44 bathl kernel:  [<c048a784>] start_kernel+0x154/0x170
Dec  3 14:30:44 bathl kernel:  [<c048a3b0>] unknown_bootoption+0x0/0x160
Dec  3 14:30:44 bathl kernel: handlers:
Dec  3 14:30:44 bathl kernel: [<e09884c0>] (snd_audiopci_interrupt+0x0/0x100 
[snd_ens1371])
Dec  3 14:30:44 bathl kernel: Disabling IRQ #19


Board is an 7DXE with AMD-761 Northbridge.


Thanks,
 Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
