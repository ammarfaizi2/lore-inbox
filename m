Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUJVVwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUJVVwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUJVVwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:52:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:64149 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268042AbUJVVkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:40:16 -0400
Message-ID: <4658.192.168.201.7.1098481211.squirrel@192.168.201.7>
Date: Fri, 22 Oct 2004 14:40:11 -0700 (PDT)
Subject: sym53c810a M_REJECT messages by the truckload on 2.6.8
From: "Rob Emanuele" <rje@shoreis.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-0.f1.1
X-Mailer: SquirrelMail/1.4.3a-0.f1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some problems with a Symbios (NCR) 810a SCSI adapter and was
wondering if someone here could help me out with it.  I'm hoping I just
need a module setting but none that I've read seem to fit the bill.  Its a
little sluggish at times and it is creating volumes of log messages as
shown below.  Its an onboard SCSI adapter that is part of a Dell.  I'm
using the 2.6.8 kernel and the sym53c8xx(_2) driver.

Thank you for any help,
Rob

/var/log/messages :

Oct 22 14:17:01 wormhole last message repeated 745 times
Oct 22 14:18:07 wormhole last message repeated 520 times
Oct 22 14:18:11 wormhole last message repeated 62 times
Oct 22 14:18:11 wormhole kernel: sym0:0:0:M_REJECT to send for : 1-2-3-1.
Oct 22 14:18:44 wormhole last message repeated 43 times
Oct 22 14:19:55 wormhole last message repeated 5 times
Oct 22 14:20:34 wormhole last message repeated 58 times
Oct 22 14:20:34 wormhole kernel: sym0:0:0:M_REJECT to send for : 1-2-3-1.


/var/log/dmesg :

SCSI subsystem initialized
sym0: <810a> rev 0x12 at pci 0000:00:0f.0 irq 11
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j


/proc/scsi/scsi :

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST15230W SUN4.2G Rev: 0738
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: MATSHITA Model: CD-ROM CR-8005A  Rev: 4.0i
  Type:   CD-ROM                           ANSI SCSI revision: 02


/proc/scsi/sym53c8xx/0 :

Chip sym53c810a, device id 0x1, revision id 0x12
At PCI address 0000:00:0f.0, IRQ 11
Min. period factor 25, Narrow SCSI BUS
Max. started commands 448, max. commands per LUN 64


