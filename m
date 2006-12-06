Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936501AbWLFQvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936501AbWLFQvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936499AbWLFQvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:51:36 -0500
Received: from mailserver.omnibit.it ([151.1.140.19]:38970 "EHLO
	mailserver.omnibit.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936501AbWLFQvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:51:35 -0500
Message-ID: <3193.213.203.144.13.1165423892.squirrel@mailserver.omnibit.it>
Date: Wed, 6 Dec 2006 17:51:32 +0100 (CET)
Subject: Areca driver 2.6.19 on x86_64
From: filip@euroweb97.com
To: support@areca.com.tw
Cc: linux-kernel@vger.kernel.org, erich@areca.com.tw
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We have a problem with the new areca driver included
in kernel tree 2.6.19.
 
During the boot sequence we get this
output:
 
........................
Loading arcmsr.ko module
ACPI: PCI Interrupt 0000:05:0e.0[A] -> Link
[LINKC] -> GSI 5 (level, low) -> IRQ 5
ARECA RAID ADAPTER0: FIRMWARE VERSION V1.41
2006-5-24
scsi0:  Areca SATA Host Adapter RAID
Controller
           
Driver Version 1.20.00.13
arcmsr0: abort device command of scsi id=0
lun=0
arcmsr0: scsi id=0 lun=0 ccb='0xffff810037f00000'
poll command abort successfully
arcmsr0: abort device command of scsi id=1
lun=0
arcmsr0: scsi id=0 lun=0 ccb='0xffff810037f00000'
poll command abort successfully
arcmsr0: abort device command of scsi id=2
lun=0
arcmsr0: scsi id=0 lun=0 ccb='0xffff810037f00000'
poll command abort successfully
scsi 0:0:0:0: scsi: Device offlined - not ready after
error recovery
........................
and keeps looping through all luns with different
values of ccd at each loop.
Till kernel panics because of the lack of root
device.
 
Here is our specs:
HW used:
ARC1220
ARC1110
on Supermicro X6DH8-XG2, Dual Xeon
3.0GHz
 
OS distro used:
CentOS 4.4 x86_64
Kernel 2.6.19 with hand-crafted config, that we are
able to use successfully with kernel 2.6.16.20.
 

Have you any suggestions to resolve this issue ?
 

Thanks in advance,
Filip Majewski


