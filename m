Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266183AbSL1JtL>; Sat, 28 Dec 2002 04:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbSL1JtL>; Sat, 28 Dec 2002 04:49:11 -0500
Received: from durendal.skynet.be ([195.238.3.91]:46811 "EHLO
	durendal.skynet.be") by vger.kernel.org with ESMTP
	id <S266183AbSL1JtK> convert rfc822-to-8bit; Sat, 28 Dec 2002 04:49:10 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Hans Lambrechts <hans.lambrechts@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre2: CPU0 handles all interrupts
Date: Sat, 28 Dec 2002 10:56:58 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212281056.58419.hans.lambrechts@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

with kernel 2.4.21-pre2:

pc:~ # cat /proc/interrupts
           CPU0       CPU1
  0:      29372          0    IO-APIC-edge  timer
  1:        504          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          2          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 12:       8078          0    IO-APIC-edge  PS/2 Mouse
 14:          7          0    IO-APIC-edge  ide0
 16:       8690          0   IO-APIC-level  aic7xxx
 18:        241          0   IO-APIC-level  eth0
NMI:          0          0
LOC:      29276      29275
ERR:          0
MIS:          0

Booting with "noapic" or "acpi=off" doesn't make a difference.
With kernel 2.4.20 both CPU's handled the same amount of interrupts.
I haven't checked this with 2.4.21-pre1.

The CPU's are PIII@500

pc:~ # lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 
03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0b.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
00:11.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 
1X/2X (rev 5c)

please cc me because I'm not on the list
