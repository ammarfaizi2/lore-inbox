Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSIEVyS>; Thu, 5 Sep 2002 17:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318213AbSIEVxs>; Thu, 5 Sep 2002 17:53:48 -0400
Received: from postal2.lbl.gov ([131.243.248.26]:48313 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S318169AbSIEVv6>;
	Thu, 5 Sep 2002 17:51:58 -0400
Message-ID: <3D77D311.BC1D94EC@lbl.gov>
Date: Thu, 05 Sep 2002 14:56:33 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac3
References: <200209051544.g85Fi6i09215@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with ide_cs..

The system locks, with no oops or anything a pcmcia CDROM drive is
inserted

Sep  5 12:10:40 localhost kernel: Linux Kernel Card Services 3.1.22
Sep  5 12:10:40 localhost kernel:   options:  [pci] [cardbus] [pm]
Sep  5 12:10:40 localhost kernel: Intel PCIC probe: not found.
Sep  5 12:10:40 localhost kernel: yenta 01:02.0: no resource of type 100
available, trying to continue...
Sep  5 12:10:40 localhost kernel: yenta 01:02.0: no resource of type 100
available, trying to continue...
Sep  5 12:10:40 localhost kernel: Yenta IRQ list 0cb8, PCI irq9
Sep  5 12:10:40 localhost kernel: Socket status: 30000006
Sep  5 12:10:40 localhost kernel: cs: IO port probe 0x0c00-0x0cff:
clean.
Sep  5 12:10:40 localhost kernel: cs: IO port probe 0x0100-0x04ff:
excluding 0x170-0x177 0x370-0x37f 0x4d0-0x4d7
Sep  5 12:10:40 localhost kernel: cs: IO port probe 0x0a00-0x0aff:
clean.

Sep  5 12:11:17 localhost cardmgr[854]: socket 0: Ninja ATA
Sep  5 12:11:17 localhost kernel: cs: memory probe
0xa0000000-0xa0ffffff: clean.
Sep  5 12:11:17 localhost cardmgr[854]: executing: 'modprobe ide-cs'
Sep  5 12:11:21 localhost kernel: hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI
CD/DVD-ROM drive
Sep  5 12:11:21 localhost kernel: ide2 at 0x180-0x187,0x386 on irq 3
Sep  5 12:11:21 localhost kernel: ide_cs: hde: Vcc = 5.0, Vpp = 0.0
Sep  5 12:11:21 localhost cardmgr[854]: executing: './ide start hde'
Sep  5 12:11:21 localhost kernel: hde: bad special flag: 0x03

[locked tight]

Sep  5 12:44:35 localhost syslogd 1.4.1: restart.


this is a on a laptop, running kernel pcmcia, patched with iee1394-567,
and acpi-20020829.

there's no oops, I've got morse turned on .  :)

suggestions?
