Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbSLEDQU>; Wed, 4 Dec 2002 22:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbSLEDQU>; Wed, 4 Dec 2002 22:16:20 -0500
Received: from mail.michigannet.com ([208.49.116.30]:37132 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S267199AbSLEDQT>; Wed, 4 Dec 2002 22:16:19 -0500
Date: Wed, 4 Dec 2002 22:23:50 -0500
From: Paul <set@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50 NCR5380/PAS16] bad: scheduling while atomic!
Message-ID: <20021205032350.GX1432@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021203013938.GO1432@squish.home.loc> <1038932271.11439.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038932271.11439.22.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>, on Tue Dec 03, 2002 [04:17:51 PM] said:
> 
> Im using generic 5380 on 2.5.x but not 2.5.50 yet. Can you turn on all
> the NCR5380 debugging and see where it errors from (the trace doesnt
> give an answer as gcc has been smartly inlining functions used in one
> place only I suspect)
> 
	Hi;

Paul
set@pobox.com

SCSI subsystem driver Revision: 1.00
scsi-pas16 : probing io_port 0388
scsi-pas16 : detected board.
scsi-pas16 : io_port = 0388
scsi : NCR5380_all_init()
scsi0 : irq = 10
scsi0 : at 0x0388 irq 10 options CAN_QUEUE=32  CMD_PER_LUN=2 release=3 generic options AUTOPROBE_IRQ AUTOSENSE PSEUDO DMA UNSAFE  USLEEP, USLEEP_POLL=200 USLEEP_SLEEP=20 generic release=7
scsi-pas16 : probing io_port 0384
scsi-pas16 : probing io_port 038c
scsi-pas16 : probing io_port 0288
scsi-pas16 : io_port = 0000
scsi0 : Pro Audio Spectrum-16 SCSI
LINE:1160   Adding c3f34200 to 00000000
scsi0 : command added to tail of queue
scsi0 : not connected
MAIN tmp=c3f34200   target=0   busy=0 lun=0
LINE:1232   Removing: ffffffff->c3f34200  c3f34200->00000000 
scsi0 : main() : command for target 0 lun 0 removed from issue_queue
scsi0 : starting arbitration, id = 7
scsi0 : arbitration complete
scsi0 : won arbitration
scsi0 : selecting target 0
bad: scheduling while atomic!
Call Trace:
 [<c0112a85>] schedule+0x3d/0x2c0
 [<c012045c>] worker_thread+0x144/0x2cc
 [<c0120318>] worker_thread+0x0/0x2cc
 [<c025caac>] NCR5380_main+0x0/0x2dc
 [<c0112d48>] default_wake_function+0x0/0x2c
 [<c0112d48>] default_wake_function+0x0/0x2c
 [<c0108935>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0112a85>] schedule+0x3d/0x2c0
 [<c012045c>] worker_thread+0x144/0x2cc
 [<c0120318>] worker_thread+0x0/0x2cc
 [<c025caac>] NCR5380_main+0x0/0x2dc
 [<c0112d48>] default_wake_function+0x0/0x2c
 [<c0112d48>] default_wake_function+0x0/0x2c
 [<c0108935>] kernel_thread_helper+0x5/0xc

......
