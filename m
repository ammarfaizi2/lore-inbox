Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbSLCBdz>; Mon, 2 Dec 2002 20:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSLCBdz>; Mon, 2 Dec 2002 20:33:55 -0500
Received: from mail.michigannet.com ([208.49.116.30]:61451 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S265828AbSLCBdz>; Mon, 2 Dec 2002 20:33:55 -0500
Date: Mon, 2 Dec 2002 20:39:39 -0500
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [2.5.50 NCR5380/PAS16] bad: scheduling while atomic!
Message-ID: <20021203013938.GO1432@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi;

	This happens just before the scsi cdrom would be detected
during boot. The bad: part and the call trace are endlessly
emited (exact same trace) and its pretty much game over.
(fortunately I had a serial console machine handy.)
	The driver is compiled into the kernel, not a module.
	The card (pas16) works under 2.4. I can test things
or supply more information/debugging if anyone wants.

Thanks;
Paul
set@pobox.com

SCSI subsystem driver Revision: 1.00
scsi-pas16 : probing io_port 0388
scsi-pas16 : detected board.
scsi-pas16 : io_port = 0388
scsi0 : irq = 10
scsi0 : at 0x0388 irq 10 options CAN_QUEUE=32  CMD_PER_LUN=2 release=3 generic options AUTOPROBE_IRQ AUTOSENSE PSEUDO DMA UNSAFE  USLEEP, USLEEP_POLL=200 USLEEP_SLEEP=20 generic release=7
scsi-pas16 : probing io_port 0384
scsi-pas16 : probing io_port 038c
scsi-pas16 : probing io_port 0288
scsi-pas16 : io_port = 0000
scsi0 : Pro Audio Spectrum-16 SCSI
bad: scheduling while atomic!
Call Trace:
 [<c0112a85>] schedule+0x3d/0x2c0
 [<c012045c>] worker_thread+0x144/0x2cc
 [<c0120318>] worker_thread+0x0/0x2cc
 [<c025c790>] NCR5380_main+0x0/0x178
 [<c0112d48>] default_wake_function+0x0/0x2c
 [<c0112d48>] default_wake_function+0x0/0x2c
 [<c0108935>] kernel_thread_helper+0x5/0xc


