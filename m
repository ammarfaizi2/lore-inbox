Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbRFVVTH>; Fri, 22 Jun 2001 17:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265524AbRFVVS6>; Fri, 22 Jun 2001 17:18:58 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:3786 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S265523AbRFVVSk>; Fri, 22 Jun 2001 17:18:40 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDEEA@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Roskin'" <proski@gnu.org>, linux-kernel@vger.kernel.org
Subject: RE: ACPI + Promise IDE = disk corruption :-(((
Date: Fri, 22 Jun 2001 14:18:25 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a note, in 2.4.6-pre5, the acpi=no-idle option goes away, but you
should no longer experience any corruption issues, either.

Regards -- Andy

PS sorry you experienced problems - glad you could recover.

> From: Pavel Roskin [mailto:proski@gnu.org]
> Hello!
> 
> It's just a word of warning for those who are trying ACPI 
> with the latest
> kernels.
> 
> I enabled ACPI in 2.4.5-ac17 (2.4.5-ac16 works fine with the 
> same config
> except ACPI). When I booted I saw a message
> 
> ACPI: If experiencing system slowness, try adding "acpi=no-idle" to
> cmdline
> 
> and after that ...
> 
> reiserfs: checking transaction log (device 21:04) ...
> 
> Normally it takes few seconds before the system goes further, but that
> time it tool much longer (one minute maybe), and the next message was
> something like "hde: DMA timeout"
> 
> I hit reset hoping to boot the system with "acpi=no-idle", but GRUB
> couldn't load stage2, which resides on the root partition (reiserfs).
> 
> I had to install Linux on another drive and run reiserfsck. 
> It found many
> errors, fixed them all, and now I'm happily running my old system.
> 
> I also checked the same kernel with "acpi=no-idle" - it 
> works. The ACPI
> messages are now:
> 
> ACPI: Core Subsystem version [20010208]
> ACPI: Subsystem enabled
> ACPI: System firmware supports: C2 C3
> ACPI: plvl2lat=10 plvl3lat=20
> ACPI: C2 enter=143 C2 exit=35
> ACPI: C3 enter=858 C3 exit=71
> ACPI: Not using ACPI idle
> ACPI: System firmware supports: S0 S1 S5
> 
> The config file is here: http://www.red-bean.com/~proski/linux/config
> dmesg output is here: http://www.red-bean.com/~proski/linux/dmesg
> 
> Possibly important data:
> 
> Kernel compiled with gcc-3.0
> Motherboard Micron SE440-BX2
> BIOS 4S4EB2X0.05A.0016.P15 (the latest)
> 1 Intel Pentium III 550MHz
> Root filesystem is reiserfs
> Root filesystem is on Promise PDC20267 ide controller
> Local APIC (but not IO-APIC) is used.
> 
> I can make more experiments (with other hard drives) if needed.
> 
> -- 
> Regards,
> Pavel Roskin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

