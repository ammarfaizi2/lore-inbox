Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317368AbSFCLLP>; Mon, 3 Jun 2002 07:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSFCLLO>; Mon, 3 Jun 2002 07:11:14 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:23680 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S317368AbSFCLLM>; Mon, 3 Jun 2002 07:11:12 -0400
Message-ID: <3CFB4DDC.30704@oracle.com>
Date: Mon, 03 Jun 2002 13:07:08 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020516
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Peter Osterlund <petero2@telia.com>, mochel <mochel@osdl.org>
Subject: 2.5.20 - Xircom PCI Cardbus doesn't work
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.19 I got an oops on boot (kindly fixed by Peter's patch),
  in 2.5.20 no oopsen but eth0 isn't seen anymore by the kernel:

[...]
Jun  3 12:50:38 dolphin kernel: PCI: Probing PCI hardware
Jun  3 12:50:38 dolphin kernel: PCI: Probing PCI hardware (bus 00)
Jun  3 12:50:38 dolphin kernel: PCI: Address space collision on region 7 of device Intel Corp. 82371AB PIIX4 ACPI [800:83f]
Jun  3 12:50:38 dolphin kernel: PCI: Address space collision on region 8 of device Intel Corp. 82371AB PIIX4 ACPI [840:85f]
Jun  3 12:50:38 dolphin kernel: Unknown bridge resource 2: assuming transparent
Jun  3 12:50:38 dolphin kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
[...]
Jun  3 12:50:39 dolphin kernel: Linux Kernel Card Services 3.1.22
Jun  3 12:50:39 dolphin kernel:   options:  [pci] [cardbus] [pm]
Jun  3 12:50:39 dolphin kernel: PCI: Found IRQ 11 for device 00:03.0
Jun  3 12:50:39 dolphin kernel: PCI: Sharing IRQ 11 with 00:03.1
Jun  3 12:50:39 dolphin kernel: PCI: Sharing IRQ 11 with 00:07.2
Jun  3 12:50:39 dolphin keytable: Loading keymap:  succeeded
Jun  3 12:50:39 dolphin kernel: PCI: Found IRQ 11 for device 00:03.1
Jun  3 12:50:39 dolphin kernel: PCI: Sharing IRQ 11 with 00:03.0
Jun  3 12:50:39 dolphin kernel: PCI: Sharing IRQ 11 with 00:07.2
Jun  3 12:50:39 dolphin kernel: Yenta IRQ list 06d8, PCI irq11
Jun  3 12:50:39 dolphin kernel: Socket status: 30000020
Jun  3 12:50:39 dolphin kernel: Yenta IRQ list 06d8, PCI irq11
Jun  3 12:50:39 dolphin kernel: Socket status: 30000006
[...]
Jun  3 12:50:39 dolphin kernel: cs: cb_alloc(bus 2): vendor 0x115d, device 0x0003
Jun  3 12:50:39 dolphin kernel: PCI: Enabling device 02:00.0 (0000 -> 0003)
Jun  3 12:50:39 dolphin kernel: PCI: Enabling device 02:00.1 (0000 -> 0003)
[...]
Jun  3 12:50:40 dolphin kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x290-0x297 0x378-0x37f 0x4d0-0x4d7
Jun  3 12:50:40 dolphin cardmgr[597]: socket 0: Xircom CBEM56G-100 CardBus 10/100 Ethernet + 56K Modem
Jun  3 12:50:40 dolphin sshd: Starting sshd:
Jun  3 12:50:37 dolphin network: Bringing up interface eth0:  succeeded
Jun  3 12:50:40 dolphin kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jun  3 12:50:41 dolphin cardmgr[597]: executing: 'modprobe cb_enabler'
Jun  3 12:50:41 dolphin apmd[572]: Battery: * * * (100% 4:15)
Jun  3 12:50:41 dolphin cardmgr[597]: executing: 'modprobe xircom_cb'
Jun  3 12:50:41 dolphin sshd:  succeeded
Jun  3 12:50:41 dolphin sshd:
Jun  3 12:50:42 dolphin rc: Starting sshd:  succeeded
Jun  3 12:50:42 dolphin cardmgr[597]: get dev info on socket 0 failed: Resource temporarily unavailable

Note that cb_enabler and xircom_cb are aliased to 'off' in
  /etc/modules.conf since both are actually built in-kernel.

...back to 2.5.18 for the moment.


Thanks & ciao,

--alessandro

  "the hands that build / can also pull down
    even the hands of love"
                             (U2, "Exit")

