Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315471AbSEQIpy>; Fri, 17 May 2002 04:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315478AbSEQIpx>; Fri, 17 May 2002 04:45:53 -0400
Received: from [213.235.52.105] ([213.235.52.105]:4480 "EHLO
	morpheus.streamgroup.co.uk") by vger.kernel.org with ESMTP
	id <S315471AbSEQIpv> convert rfc822-to-8bit; Fri, 17 May 2002 04:45:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mike <mikeh@notnowlewis.co.uk>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>,
        Erik Steffl <steffl@bigfoot.com>
Subject: Re: lost interrupt hell - Plea for Help
Date: Fri, 17 May 2002 09:49:48 +0100
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CDCD708.6000208@notnowlewis.co.uk> <3CDC3B90.AADE1835@bigfoot.com> <4.1.20020516224137.00914260@pop.cablewanadoo.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205170949.48426.mikeh@notnowlewis.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yeah, the spurious interrupt does seem to be an AMD apic problem, but the lost 
interrupt (on ripping audio) seems to be a VIA chipset problem, as people 
with KT266 chipsets are having boot problems / audio rip problems regardless 
of the processor type. Lucky me, I get both ;)

mike


On Thursday 16 May 2002 9:50 pm, Rudmer van Dijk wrote:
> Sorry for the delay...
>
> I build a 2.4.19-pre8-ac4 kernel without local apic and now after running
> for 4 hours I still did NOT get the message "spurious 8259A interrupt:
> IRQ7." while with apic enabled the message appears after ~3 min... so this
> is local apic related.
>
> This is an athlon on a SIS-chip mobo.
>
> I also found this in dmesg:
> PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router SIS [1039/0008] at 00:02.0
>
> and this from lspci:
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735
> (rev 01)
>
> also related??
>
> 	Rudmer
>
> At 10:38 11-5-02 +0200, Rudmer van Dijk wrote:
> >At 09:32 11-5-02 +0100, mikeH wrote:
> >>You can try compiling without VIA chipset support, but it makes no
> >>difference.
> >>Now, with the latest prepatches, -ac patches and ide patches, I am
> >>getting spurious  "8259A interrupt: IRQ7."
> >>all over the place too. Seems like the linux kernel does not play well
> >>with AMD Cpus + VIA chipsets, which
> >>is a real shame as thats what all my machines are :(
> >
> >It's not only with VIA chipsets, I have an Athlon system with a SIS
> > chipset and there I get the spurious  "8259A interrupt: IRQ7." as well...
> > luckily the message is only displayed once, but it always appears in the
> > first 15 min after startup.
> >
> >	Rudmer
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
