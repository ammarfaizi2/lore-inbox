Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbRGDARv>; Tue, 3 Jul 2001 20:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266074AbRGDARm>; Tue, 3 Jul 2001 20:17:42 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:33946 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S266069AbRGDARb>; Tue, 3 Jul 2001 20:17:31 -0400
Message-ID: <3B42610F.29D004FF@idcomm.com>
Date: Tue, 03 Jul 2001 18:19:27 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: page reserved twice
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious if there is any significance to this, which occurs at each
reboot on an SMP system running noapic (sometimes Netscape manages to
produce a hard lockup on the system, sometimes a core dump indicates NS
had signal 7, bus error, in cases where it doesn't lock the system),
2.4.6-pre1 with XFS patches:

 kernel: BIOS-provided physical RAM map:
 kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 kernel:  BIOS-e820: 0000000000100000 - 000000000ffe0000 (usable)
 kernel:  BIOS-e820: 000000000ffe0000 - 000000000fff8000 (ACPI data)
 kernel:  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 kernel: Scan SMP from c0000000 for 1024 bytes.
 kernel: Scan SMP from c009fc00 for 1024 bytes.
 kernel: Scan SMP from c00f0000 for 65536 bytes.
 kernel: found SMP MP-table at 000faf50
 kernel: hm, page 000fa000 reserved twice.
 kernel: hm, page 000fb000 reserved twice.
 kernel: hm, page 000f4000 reserved twice.
 thanteros kernel: hm, page 000f5000 reserved twice.
 thanteros kernel: On node 0 totalpages: 65504
 thanteros kernel: zone(0): 4096 pages.
 kernel: zone(1): 61408 pages.
 kernel: zone(2): 0 pages.
 kernel: Intel MultiProcessor Specification v1.1
 kernel:     Virtual Wire compatibility mode.
 kernel: OEM ID: _AMI_    Product ID: 840_CARMEL__ APIC at: 0xFEE00000


Very similar messages seem to occur on a different machine with RH's
2.4.2 kernel, BX chipset, and IO-APIC enabled. The machine this is from
has had this message on earlier kernels as well, none of which had XFS
patches. What is the significance (or consequence) of pages reserved
twice?

D. Stimits, stimits@idcomm.com
