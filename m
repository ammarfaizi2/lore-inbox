Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbTLEPSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 10:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTLEPSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 10:18:35 -0500
Received: from tag.witbe.net ([81.88.96.48]:22026 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264153AbTLEPS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 10:18:27 -0500
Message-Id: <200312051518.hB5FIQD29335@tag.witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: <linux-smp@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: "'Paul Rolland'" <rol@witbe.net>
Subject: WARNING: MP table in the EBDA can be UNSAFE
Date: Fri, 5 Dec 2003 16:18:26 +0100
Organization: Witbe.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcO7QwbsDD90uGgyQLG46fGDw5ycQg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Our Linux, running on an IBM X-Series 445, says :
(excerpt from dmesg) :

Linux version 2.4.20 (root@stg-02.ntr.witbe.francetelecom.fr) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #12 SMP
Fri Dec 5 11:08:40 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb7000 (usable)
 BIOS-e820: 000000007ffb7000 - 000000007ffbf800 (ACPI data)
 BIOS-e820: 000000007ffbf800 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009dd40
hm, page 0009d000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!
On node 0 totalpages: 524215
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294839 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00fdba0
RSD PTR  v0 [IBM   ]
__va_range(0x7ffbf780, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [IBM    SERVIGIL 0.4096]
__va_range(0x7ffbf700, 0x24): idx=8 mapped at ffff6000
__va_range(0x7ffbf700, 0x74): idx=8 mapped at ffff6000
ACPI table found: FACP v1 [IBM    SERVIGIL 0.4096]
__va_range(0x7ffbf640, 0x24): idx=8 mapped at ffff6000
__va_range(0x7ffbf640, 0x9a): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [IBM    SERVIGIL 0.4096]
__va_range(0x7ffbf640, 0x9a): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16
 
LAPIC (acpi_id[0x0001] id[0x12] enabled[1])
CPU 1 (0x1200) enabled<4>Processor #18 INVALID - (Max ID: 16).
LAPIC (acpi_id[0x0002] id[0x20] enabled[1])
CPU 1 (0x2000) enabled<4>Processor #32 INVALID - (Max ID: 16).
LAPIC (acpi_id[0x0003] id[0x32] enabled[1])
CPU 1 (0x3200) enabled<4>Processor #50 INVALID - (Max ID: 16).

Is there any known solution to re-enable the CPU 1, CPU 2 and CPU 3 ?

Is this an IBM bug ?

Please reply privately, I'm not subscribed to linux-smp.

Thanks in advance,
Paul

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Blessed are they who have nothing to say and cannot be persuaded to say it.

-James Russell Lowell
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Paul Rolland, rol@witbe.net
Witbe.net SA
Directeur Associe

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it"

