Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265556AbTFRV7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265561AbTFRV7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:59:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:21405 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265556AbTFRV7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:59:07 -0400
Date: Wed, 18 Jun 2003 15:01:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 829] New: Problem with ide-scsi 
Message-ID: <174040000.1055973707@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=829

           Summary: Problem with ide-scsi
    Kernel Version: 2.5.72
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: dvornheder@t-online.de


Distribution: SuSE 8.2Prof.
Hardware Environment:Athlon 2000XP+, IDE DVD Teac DV-W50E,
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:09.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
00:09.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 03)
00:09.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port
00:0b.0 SCSI storage controller: Adaptec AHA-2940/2940W / AIC-7871
00:0c.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master
IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200]
(rev a3)
Software Environment:KDE 3.1.2, XFree 4.3.0, gcc 3.3
Problem Description:

With kernel 2.4.21(ac1) my computer hangs most times if i try burn a

CD or DVD with xcdroast 0.98alpha14, cdbakeoven 2.0beta2 or cdrecord-ProDVD.

In /var/adm/messages i get

Jun 18 21:22:08 PCNEU kernel: scsi : aborting command due to timeout : pid
80024, scsi1, channel 0, id 0, lun 0 0x43 00 00 00 00 00 00 00 0c 00

as last message before the computer hangs.

With kernel 2.5.72 the computer never hangs if i burn a cd or dvd but i get

everytime the following errors:

Blanking CDRW with cdbakeoven:

Jun 18 00:48:27 PCNEU kernel: ide-scsi: abort called for 656
Jun 18 00:48:27 PCNEU kernel: Debug: sleeping function called from illegal
context at include/asm/semaphore.h:119
Jun 18 00:48:27 PCNEU kernel: Call Trace:
Jun 18 00:48:27 PCNEU kernel:  [__might_sleep+92/128] __might_sleep+0x5c/0x80
Jun 18 00:48:27 PCNEU kernel:  [<c011981c>] __might_sleep+0x5c/0x80
Jun 18 00:48:27 PCNEU kernel:  [scsi_sleep+104/144] scsi_sleep+0x68/0x90
Jun 18 00:48:27 PCNEU kernel:  [<c0248e78>] scsi_sleep+0x68/0x90
Jun 18 00:48:27 PCNEU kernel:  [scsi_sleep_done+0/32] scsi_sleep_done+0x0/0x20
Jun 18 00:48:27 PCNEU kernel:  [<c0248df0>] scsi_sleep_done+0x0/0x20
Jun 18 00:48:27 PCNEU kernel:  [_end+947301920/1069589724]
idescsi_abort+0xa4/0xb0 [ide_scsi]
Jun 18 00:48:27 PCNEU kernel:  [<f8b5e944>] idescsi_abort+0xa4/0xb0 [ide_scsi]
Jun 18 00:48:27 PCNEU kernel:  [scsi_try_to_abort_cmd+76/80]
scsi_try_to_abort_cmd+0x4c/0x50
Jun 18 00:48:27 PCNEU kernel:  [<c02487ac>] scsi_try_to_abort_cmd+0x4c/0x50
Jun 18 00:48:27 PCNEU kernel:  [scsi_eh_abort_cmds+64/128]
scsi_eh_abort_cmds+0x40/0x80
Jun 18 00:48:27 PCNEU kernel:  [<c02488c0>] scsi_eh_abort_cmds+0x40/0x80
Jun 18 00:48:27 PCNEU kernel:  [scsi_unjam_host+135/176] scsi_unjam_host+0x87/0xb0
Jun 18 00:48:27 PCNEU kernel:  [<c0249287>] scsi_unjam_host+0x87/0xb0
Jun 18 00:48:27 PCNEU kernel:  [scsi_error_handler+180/240]
scsi_error_handler+0xb4/0xf0
Jun 18 00:48:27 PCNEU kernel:  [<c0249364>] scsi_error_handler+0xb4/0xf0
Jun 18 00:48:27 PCNEU kernel:  [scsi_error_handler+0/240]
scsi_error_handler+0x0/0xf0
Jun 18 00:48:27 PCNEU kernel:  [<c02492b0>] scsi_error_handler+0x0/0xf0
Jun 18 00:48:27 PCNEU kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
Jun 18 00:48:27 PCNEU kernel:  [<c01071cd>] kernel_thread_helper+0x5/0x18


Writing data to a cdrw with cdbakeoven:

Jun 18 00:53:26 PCNEU kernel: ide-scsi: abort called for 3970
Jun 18 00:53:26 PCNEU kernel: Debug: sleeping function called from illegal
context at include/asm/semaphore.h:119
Jun 18 00:53:26 PCNEU kernel: Call Trace:
Jun 18 00:53:26 PCNEU kernel:  [__might_sleep+92/128] __might_sleep+0x5c/0x80
Jun 18 00:53:26 PCNEU kernel:  [<c011981c>] __might_sleep+0x5c/0x80
Jun 18 00:53:26 PCNEU kernel:  [scsi_sleep+104/144] scsi_sleep+0x68/0x90
Jun 18 00:53:26 PCNEU kernel:  [<c0248e78>] scsi_sleep+0x68/0x90
Jun 18 00:53:26 PCNEU kernel:  [scsi_sleep_done+0/32] scsi_sleep_done+0x0/0x20
Jun 18 00:53:26 PCNEU kernel:  [<c0248df0>] scsi_sleep_done+0x0/0x20
Jun 18 00:53:26 PCNEU kernel:  [_end+947301920/1069589724]
idescsi_abort+0xa4/0xb0 [ide_scsi]
Jun 18 00:53:26 PCNEU kernel:  [<f8b5e944>] idescsi_abort+0xa4/0xb0 [ide_scsi]
Jun 18 00:53:26 PCNEU kernel:  [scsi_try_to_abort_cmd+76/80]
scsi_try_to_abort_cmd+0x4c/0x50
Jun 18 00:53:26 PCNEU kernel:  [<c02487ac>] scsi_try_to_abort_cmd+0x4c/0x50
Jun 18 00:53:26 PCNEU kernel:  [scsi_eh_abort_cmds+64/128]
scsi_eh_abort_cmds+0x40/0x80
Jun 18 00:53:26 PCNEU kernel:  [<c02488c0>] scsi_eh_abort_cmds+0x40/0x80
Jun 18 00:53:26 PCNEU kernel:  [scsi_unjam_host+135/176] scsi_unjam_host+0x87/0xb0
Jun 18 00:53:26 PCNEU kernel:  [<c0249287>] scsi_unjam_host+0x87/0xb0
Jun 18 00:53:26 PCNEU kernel:  [scsi_error_handler+180/240]
scsi_error_handler+0xb4/0xf0
Jun 18 00:53:26 PCNEU kernel:  [<c0249364>] scsi_error_handler+0xb4/0xf0
Jun 18 00:53:26 PCNEU kernel:  [scsi_error_handler+0/240]
scsi_error_handler+0x0/0xf0
Jun 18 00:53:26 PCNEU kernel:  [<c02492b0>] scsi_error_handler+0x0/0xf0
Jun 18 00:53:26 PCNEU kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
Jun 18 00:53:26 PCNEU kernel:  [<c01071cd>] kernel_thread_helper+0x5/0x18
Jun 18 00:53:26 PCNEU kernel:
Jun 18 00:53:26 PCNEU kernel: hdd: irq timeout: status=0xd0 { Busy }
Jun 18 00:53:26 PCNEU kernel: hdd: DMA disabled
Jun 18 00:53:26 PCNEU kernel: hdd: ATAPI reset complete

Blanking DVD-RW medium with xcdroast:

Jun 18 00:59:41 PCNEU kernel: ide-scsi: abort called for 5032
Jun 18 00:59:41 PCNEU kernel: Debug: sleeping function called from illegal
context at include/asm/semaphore.h:119
Jun 18 00:59:41 PCNEU kernel: Call Trace:
Jun 18 00:59:41 PCNEU kernel:  [__might_sleep+92/128] __might_sleep+0x5c/0x80
Jun 18 00:59:41 PCNEU kernel:  [<c011981c>] __might_sleep+0x5c/0x80
Jun 18 00:59:41 PCNEU kernel:  [scsi_sleep+104/144] scsi_sleep+0x68/0x90
Jun 18 00:59:41 PCNEU kernel:  [<c0248e78>] scsi_sleep+0x68/0x90
Jun 18 00:59:41 PCNEU kernel:  [scsi_sleep_done+0/32] scsi_sleep_done+0x0/0x20
Jun 18 00:59:41 PCNEU kernel:  [<c0248df0>] scsi_sleep_done+0x0/0x20
Jun 18 00:59:41 PCNEU kernel:  [_end+947301920/1069589724]
idescsi_abort+0xa4/0xb0 [ide_scsi]
Jun 18 00:59:41 PCNEU kernel:  [<f8b5e944>] idescsi_abort+0xa4/0xb0 [ide_scsi]
Jun 18 00:59:41 PCNEU kernel:  [scsi_try_to_abort_cmd+76/80]
scsi_try_to_abort_cmd+0x4c/0x50
Jun 18 00:59:41 PCNEU kernel:  [<c02487ac>] scsi_try_to_abort_cmd+0x4c/0x50
Jun 18 00:59:41 PCNEU kernel:  [scsi_eh_abort_cmds+64/128]
scsi_eh_abort_cmds+0x40/0x80
Jun 18 00:59:41 PCNEU kernel:  [<c02488c0>] scsi_eh_abort_cmds+0x40/0x80
Jun 18 00:59:41 PCNEU kernel:  [scsi_unjam_host+135/176] scsi_unjam_host+0x87/0xb0
Jun 18 00:59:41 PCNEU kernel:  [<c0249287>] scsi_unjam_host+0x87/0xb0
Jun 18 00:59:41 PCNEU kernel:  [scsi_error_handler+180/240]
scsi_error_handler+0xb4/0xf0
Jun 18 00:59:41 PCNEU kernel:  [<c0249364>] scsi_error_handler+0xb4/0xf0
Jun 18 00:59:41 PCNEU kernel:  [scsi_error_handler+0/240]
scsi_error_handler+0x0/0xf0
Jun 18 00:59:41 PCNEU kernel:  [<c02492b0>] scsi_error_handler+0x0/0xf0
Jun 18 00:59:41 PCNEU kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
Jun 18 00:59:41 PCNEU kernel:  [<c01071cd>] kernel_thread_helper+0x5/0x18

Steps to reproduce:

see above.

Dirk


