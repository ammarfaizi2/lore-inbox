Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272465AbRH3VHP>; Thu, 30 Aug 2001 17:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272463AbRH3VHF>; Thu, 30 Aug 2001 17:07:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13316 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272465AbRH3VGx>; Thu, 30 Aug 2001 17:06:53 -0400
Subject: Re: Messages "ACPI attempting to access kernel owned memory"?
To: afranck@gmx.de (Andreas Franck)
Date: Thu, 30 Aug 2001 22:10:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01083022542904.00841@dg1kfa> from "Andreas Franck" at Aug 30, 2001 10:54:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cZ5F-0001qR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> since a few releases of 2.4.x-ac? I get the following error message before 
> ACPI is initialized:
> 
> 	ACPI attempting to access kernel owned memory at 040FDC09.
> 	ACPI attempting to access kernel owned memory at 040FDC09.
> 	ACPI attempting to access kernel owned memory at 040FF78C.
> 	ACPI attempting to access kernel owned memory at 040FF78C.
> 	ACPI attempting to access kernel owned memory at 040FFBC0.
> 	ACPI attempting to access kernel owned memory at 040FDC31.
> 	ACPI attempting to access kernel owned memory at 040FDC31.
> 	ACPI: Core Subsystem version [20010615]
> 	ACPI: Subsystem enabled
> 	ACPI: System firmware supports S0 S1 S5
> 	Processor[0]: C0 C1 C2
> 	Power Button: found
> 
> My mainboard is an Intel AL440LX with (440LX Chipset), a bit old, but ACPI 
> works (at least, it cleanly shutd down my computer when I push the power 
> button, which seems the only thing it really does, so far).

Thanks for the traces.

> 	 BIOS-e820: 00000000040fdc00 - 00000000040ff800 (ACPI data)
> 	 BIOS-e820: 00000000040ff800 - 00000000040ffc00 (ACPI NVS)

Ok the code I use for debug checks assumes that the memory in question is
has been marked as reserved. I need to review the code since that seems
not to have happened in this case.

I'll investigate - seems the trap is buggy 8)
