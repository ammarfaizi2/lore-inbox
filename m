Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSFWTpb>; Sun, 23 Jun 2002 15:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSFWTpa>; Sun, 23 Jun 2002 15:45:30 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:9256 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S317091AbSFWTpa>; Sun, 23 Jun 2002 15:45:30 -0400
From: Marc Lefranc <lefranc.m@free.fr>
To: linux-kernel@vger.kernel.org
Subject: aha152x driver broken in 2.4.19-pre10
Date: 23 Jun 2002 21:21:17 +0200
Message-ID: <p6rznxlhkcy.fsf@free.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

it looks like the aha152x driver was broken between 2.4.19-pre8 and
2.4.19-pre10. Apparently there is a problem with a lost interrupt. I
am afraid I cannot do much to fix this problem, but I am willing to
perform any test that would help.

All the best,
Marc

P.S. As I'm not subscribed to the mailing list, thanks in advance for
cc'ing the comments to me.

Jun 23 20:48:38 socrate kernel: Linux version 2.4.19-pre10 (root@socrate.mon-domaine) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #5 Wed Jun 19 21:44:39 CEST 2002
[...]
Jun 23 20:49:17 socrate kernel: SCSI subsystem driver Revision: 1.00
Jun 23 20:49:18 socrate kernel: aha152x: BIOS test: passed, detected 1 controller(s)
Jun 23 20:49:18 socrate kernel: aha152x: resetting bus...
Jun 23 20:49:18 socrate kernel: aha152x0: vital data: rev=1, io=0x140 (0x140/0x140), irq=11, scsiid=7, reconnect=enabled, parity=enabled, synchronous=enabled, delay=1000, extended translation=disabled
Jun 23 20:49:18 socrate kernel: aha152x0: trying software interrupt, lost.
Jun 23 20:49:18 socrate kernel: aha152x0: IRQ 11 possibly wrong.  Please verify.Jun 23 20:49:18 socrate insmod: /lib/modules/2.4.19-pre10/kernel/drivers/scsi/aha152x.o: init_module: No such device
Jun 23 20:49:18 socrate insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
Jun 23 20:49:18 socrate insmod: /lib/modules/2.4.19-pre10/kernel/drivers/scsi/aha152x.o: insmod scsi_hostadapter failed

And going back to the kernel previously in use on this machine (-pre8
+ Andrea Arcangeli's vm 34 patch applied) :

Jun 23 21:02:41 socrate kernel: Linux version 2.4.19-pre8-vm34 (root@socrate.mon-domaine) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Sun May 5 22:37:18 CEST 2002
[...]
Jun 23 21:03:11 socrate kernel: SCSI subsystem driver Revision: 1.00
Jun 23 21:03:12 socrate kernel: aha152x: BIOS test: passed, detected 1 controller(s)
Jun 23 21:03:12 socrate kernel: aha152x: resetting bus...
Jun 23 21:03:12 socrate kernel: aha152x0: vital data: rev=1, io=0x140 (0x140/0x140), irq=11, scsiid=7, reconnect=enabled, parity=enabled, synchronous=enabled, delay=1000, extended translation=disabled
Jun 23 21:03:12 socrate kernel: aha152x0: trying software interrupt, ok.
Jun 23 21:03:12 socrate kernel: scsi0 : Adaptec 152x SCSI driver; $Revision: 2.4 $


