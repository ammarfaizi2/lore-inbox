Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267300AbUBSOtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267217AbUBSOtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:49:33 -0500
Received: from plim.fujitsu-siemens.com ([217.115.66.8]:63033 "EHLO
	plim.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S267298AbUBSOta convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:49:30 -0500
Message-ID: <4034CD79.CF97B0FB@fujitsu-siemens.com>
Date: Thu, 19 Feb 2004 15:51:37 +0100
From: Josef =?iso-8859-1?Q?M=F6llers?= 
	<josef.moellers@fujitsu-siemens.com>
Organization: Changes ever so often!
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@redhat.com
CC: josef.moellers@fujitsu-siemens.com
Subject: IO-APIC + timer
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 19 Feb 2004 14:49:16.0657 (UTC) FILETIME=[8C3B7E10:01C3F6F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

Can you help? I've tried reaching bugzilla.redhat.com, but didn't
connect.

We have a problem with a IO-APIC + timer on a RedHat Linux 2.4.21
kernel:
 
    ESR value after enabling vector: 00000000
    Calibrating delay loop... 6107.95 BogoMIPS
    CPU: Trace cache: 12K uops, L1 D cache: 8K
    CPU: L2 cache: 512K
    CPU: Hyper-Threading is disabled
    Intel machine check reporting enabled on CPU#1.
    CPU1: Intel(R) Xeon(TM) CPU 3.06GHz stepping 09
    Total of 2 processors activated (6945.17 BogoMIPS).
    ENABLING IO-APIC IRQs
    Setting 7 in the phys_id_present_map
    ...changing IO-APIC physical APIC ID to 7 ... ok.
    Setting 8 in the phys_id_present_map
    ...changing IO-APIC physical APIC ID to 8 ... ok.
    Setting 9 in the phys_id_present_map
    ...changing IO-APIC physical APIC ID to 9 ... ok.
    ..TIMER: vector=0x31 pin1=2 pin2=0
    ..MP-BIOS bug: 8254 timer not connected to IO-APIC
    ...trying to set up timer (IRQ0) through the 8259A ...
    ..... (found pin 0) ... failed.
    timer doesn't work through the IO-APIC - disabling NMI Watchdog!
    ...trying to set up timer as Virtual Wire IRQ... failed.
    ...trying to set up timer as ExtINT IRQ... failed :(.
    Kernel panic: IO-APIC + timer doesn't work! pester mingo@redhat.com
    In idle task - not syncing
 
The hardware is
 
    Northbridge:    Intel E7505 Chipset, Plumas
    Southbridge:    Intel ICH3S
    Super-I/O:              NS PC87366/VLA
    FWH:                    SST 49LF004A
    Giga-LAN:               Intel 82546EB
    SCSI:                   Adaptec 7902
    Processors:             2 X Prestonia processors, 533 MHz FSB, 2.8
GHz -
    3.2 GHz
    Memory:         1 - 6 registered DIMMs, PC2100R, DDR 266
    Video:          ATI Rage XL

Thanks in advance,

Josef
-- 
Josef Möllers (Pinguinpfleger bei FSC)
	If failure had no penalty success would not be a prize
						-- T.  Pratchett
