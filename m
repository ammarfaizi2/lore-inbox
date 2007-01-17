Return-Path: <linux-kernel-owner+w=401wt.eu-S1751611AbXAQVKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbXAQVKO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbXAQVKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:10:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:42769 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbXAQVKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:10:03 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MgxwIczpy9ak4jrwdQy9n0nCHfe3VNaEW4ldzITu0XluanXsT/XrivsprodSCZEyyU/z9zPlJOg3ZI3mxzM53mGWwU5MCWQXRd41nwE94qk8iMC1b61IRMaLGM2u2CVLTPou8ytVMhVU1lTnVRxDXh71dmJ2vJvfMSPcIJSI0V0=
Message-ID: <305c16960701171310v727963aevd4f29eba34316ed9@mail.gmail.com>
Date: Wed, 17 Jan 2007 19:10:01 -0200
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Len Brown" <lenb@kernel.org>
Subject: Re: BUG: linux 2.6.19 unable to enable acpi
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Luming Yu" <luming.yu@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200701170408.54220.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <305c16960701162001j5ec23332hcd398cbe944916e1@mail.gmail.com>
	 <305c16960701162335x3a84bbe5y87ee8c0608b2eea6@mail.gmail.com>
	 <305c16960701162342u69526f5dn208c6531f6b9fc8e@mail.gmail.com>
	 <200701170408.54220.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/07, Len Brown <lenb@kernel.org> wrote:
> The code that enables ACPI mode hasn't really changed since before 2.6.12 --
> unless udelay() has changed beneath us...
> So if you are going to test an old version of Linux, you should start before then.
>
> Perhaps you can try this debug patch on top of 2.6.19 and send along the dmesg?
> (also, please include CONFIG_ACPI_DEBUG=y)
>
> thanks,
> -Len

Tried that, dmesg output below:

DMI 2.2 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fb080
ACPI: RSDT (v001 AMIINT          0x00000000 MSFT 0x00000097) @ 0x0fdf0000
ACPI: FADT (v001 AMIINT          0x00000000 MSFT 0x00000097) @ 0x0fdf0030
ACPI: DSDT (v001    SiS      620 0x00001000 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 10000000 (gap: 0fe00000:f00f0000)
Detected 300.683 MHz processor.
Built 1 zonelists.  Total pages: 64501
Kernel command line: root=/dev/sda3
Initializing CPU#0
CPU 0 irqstacks, hard=c038f000 soft=c038e000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 254268k/260032k available (1818k kernel code, 5268k reserved,
611k data, 160k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffff8000 - 0xfffff000   (  28 kB)
    vmalloc : 0xd0800000 - 0xffff6000   ( 759 MB)
    lowmem  : 0xc0000000 - 0xcfdf0000   ( 253 MB)
      .init : 0xc0361000 - 0xc0389000   ( 160 kB)
      .data : 0xc02c6be6 - 0xc035fa28   ( 611 kB)
      .text : 0xc0100000 - 0xc02c6be6   (1818 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 602.00 BogoMIPS (lpj=3010033)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0080f9ff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0080f9ff 00000000 00000000 00000040
00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Klamath) stepping 03
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0005) - 259 Objects with 25 Devices 99 Methods 13 Regions
ACPI Namespace successfully loaded at root c03a49f0
ACPI: setting ELCR to 8000 (from 1c00)
ACPI: FADT.acpi_enable 225
ACPI: FADT.acpi_disable 30
ACPI: smi_cmd 0x435, acpi_enable 0xe1
ACPI: retry 142
ACPI Error (hwacpi-0185): Hardware did not change modes [20060707]
ACPI Error (evxfevnt-0084): Could not transition to ACPI mode [20060707]
ACPI Warning (utxface-0154): AcpiEnable failed [20060707]
ACPI: Unable to enable ACPI
