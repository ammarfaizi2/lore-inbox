Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293348AbSCXOme>; Sun, 24 Mar 2002 09:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293357AbSCXOmY>; Sun, 24 Mar 2002 09:42:24 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:34476 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S293348AbSCXOmK>;
	Sun, 24 Mar 2002 09:42:10 -0500
Date: Sun, 24 Mar 2002 15:42:01 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203241442.PAA10726@harpo.it.uu.se>
To: bazooka@enclavenet.hu
Subject: Re: io-apic not working on i850mv(p4)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002 15:05:14 +0100, Banai Zoltan wrote:
>He said that CONFIG_X86_UP_IOAPIC=y means that if
>IO-APIC _is_ present on the motherboard then it will be used.
>
>But i pointed out that acording to intel's 
>i850MV board specification update:
>ftp://download.intel.com/design/motherbd/mv/A7258705.pdf (8-9 page)
>this motherboard supports 16 irq in PIC mode and 24 in APIC mode.
>
>So it seems to me that the problem is with kernel-bios communication.
>Maybe the kernel needs the bios to supply the SMP layout?
>Or ther is need to relocate the DMI scan to early boot stage?

My ASUS P4T-E is supposed to have an IO-APIC in its 850 chipset,
and the BIOS setup does allow me to specify apic delivery mode,
but I've never been able to get the kernel (SMP or UP_IOAPIC)
to detect the IO-APIC.

My guess is that Linux only finds the IO-APIC if it's listed in
the MP-table. Perhaps newer boxes publish the info via ACPI?

/Mikael
