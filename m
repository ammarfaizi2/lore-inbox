Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314682AbSEPUz5>; Thu, 16 May 2002 16:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314686AbSEPUz4>; Thu, 16 May 2002 16:55:56 -0400
Received: from smtp2.wanadoo.nl ([194.134.35.138]:23537 "EHLO smtp2.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S314682AbSEPUzz>;
	Thu, 16 May 2002 16:55:55 -0400
Message-Id: <4.1.20020516224137.00914260@pop.cablewanadoo.nl>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1
Date: Thu, 16 May 2002 22:50:25 +0200
To: mikeH <mikeH@notnowlewis.co.uk>, Erik Steffl <steffl@bigfoot.com>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: lost interrupt hell - Plea for Help
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.1.20020511103241.00914250@pop.cablewanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay...

I build a 2.4.19-pre8-ac4 kernel without local apic and now after running
for 4 hours I still did NOT get the message "spurious 8259A interrupt:
IRQ7." while with apic enabled the message appears after ~3 min... so this
is local apic related.

This is an athlon on a SIS-chip mobo.

I also found this in dmesg:
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router SIS [1039/0008] at 00:02.0

and this from lspci:
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735
(rev 01)

also related??

	Rudmer


At 10:38 11-5-02 +0200, Rudmer van Dijk wrote:
>At 09:32 11-5-02 +0100, mikeH wrote:
>>
>>You can try compiling without VIA chipset support, but it makes no 
>>difference.
>>Now, with the latest prepatches, -ac patches and ide patches, I am 
>>getting spurious  "8259A interrupt: IRQ7."
>>all over the place too. Seems like the linux kernel does not play well 
>>with AMD Cpus + VIA chipsets, which
>>is a real shame as thats what all my machines are :(
>
>It's not only with VIA chipsets, I have an Athlon system with a SIS chipset
>and there I get the spurious  "8259A interrupt: IRQ7." as well...
>luckily the message is only displayed once, but it always appears in the
>first 15 min after startup.
>
>	Rudmer
>

