Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbUA1MPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 07:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUA1MPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 07:15:49 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:55050 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S265918AbUA1MPo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 07:15:44 -0500
Date: Wed, 28 Jan 2004 13:15:37 +0100
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-rc1-mm3 lots of Call Trace (IDE)
Message-ID: <20040128121537.GA23385@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I boots 2.6.2-rc1-mm3 I got this (before this kernel I used 2.6.1-mm5
without those):

Jan 28 13:01:32 greg kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan 28 13:01:32 greg kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 28 13:01:32 greg kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Jan 28 13:01:32 greg kernel: ICH4: chipset revision 1
Jan 28 13:01:32 greg kernel: ICH4: not 100%% native mode: will probe irqs later
Jan 28 13:01:32 greg kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
Jan 28 13:01:32 greg kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Jan 28 13:01:32 greg kernel: hda: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Jan 28 13:01:32 greg kernel: Using anticipatory io scheduler
Jan 28 13:01:32 greg kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 28 13:01:32 greg kernel: hdc: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
Jan 28 13:01:32 greg kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan 28 13:01:32 greg kernel: PDC20276: IDE controller at PCI slot 0000:03:0e.0
Jan 28 13:01:32 greg kernel: PDC20276: chipset revision 1
Jan 28 13:01:32 greg kernel: PDC20276: 100%% native mode on irq 22
Jan 28 13:01:32 greg kernel:     ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:pio, hdf:pio
Jan 28 13:01:32 greg kernel:     ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:pio, hdh:pio
Jan 28 13:01:32 greg kernel: hdg: IC35L120AVVA07-0, ATA DISK drive
Jan 28 13:01:32 greg kernel: ide3 at 0xc000-0xc007,0xbc02 on irq 22
Jan 28 13:01:32 greg kernel: hdg: max request size: 128KiB
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: hdg: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
Jan 28 13:01:32 greg kernel:  hdg: hdg1 hdg2 hdg3 hdg4
Jan 28 13:01:32 greg kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Jan 28 13:01:32 greg kernel:         <Adaptec 29160B Ultra160 SCSI adapter>
Jan 28 13:01:32 greg kernel:         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb
Jan 28 13:01:32 greg kernel: 
Jan 28 13:01:32 greg kernel: Badness in interruptible_sleep_on at kernel/sched.c:2242
Jan 28 13:01:32 greg kernel: Call Trace:
Jan 28 13:01:32 greg kernel:  [<c011b824>] interruptible_sleep_on+0xeb/0x118
Jan 28 13:01:32 greg kernel:  [<c011b1f9>] default_wake_function+0x0/0x15
Jan 28 13:01:32 greg kernel:  [<c01fa9c9>] pagebuf_daemon+0x189/0x272
Jan 28 13:01:32 greg kernel:  [<c03a162e>] ret_from_fork+0x6/0x14
Jan 28 13:01:32 greg kernel:  [<c01f9962>] pagebuf_daemon_wakeup+0x0/0x2a
Jan 28 13:01:32 greg kernel:  [<c01fa840>] pagebuf_daemon+0x0/0x272
Jan 28 13:01:32 greg kernel:  [<c0107b65>] kernel_thread_helper+0x5/0xb

I have an MSI-Max2-BLR motherboard and would be happy to provide any other
info when needed (please CC to me as I am not on this ml) ;-)

	Grégoire
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
