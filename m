Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTAHAjR>; Tue, 7 Jan 2003 19:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbTAHAjR>; Tue, 7 Jan 2003 19:39:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10889
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267612AbTAHAjQ>; Tue, 7 Jan 2003 19:39:16 -0500
Subject: Re: Oops on dual P5 (mp_bus_id_to_pci_bus==NULL)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030107151144.A1904@devserv.devel.redhat.com>
References: <20030107151144.A1904@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041989504.22457.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 08 Jan 2003 01:31:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 20:11, Pete Zaitcev wrote:
> Greg, the attached patch is broken. What do you think happens
> if (mpf->mpf_feature1 != 0) in get_smp_config()?
> In my case, it looks like this:
> 
> Intel MultiProcessor Specification v1.1
>     Virtual Wire compatibility mode.
> Default MP configuration #6
> Processor #0 Pentium(tm) APIC version 16
> Processor #1 Pentium(tm) APIC version 16
> I/O APIC #2 Version 16 at 0xFEC00000.
> Processors: 2
> ............... blah blah blah
> PCI: PCI BIOS revision 2.00 entry at 0xfcad0, last bus=0
> PCI: Using configuration type 2
> PCI: Probing PCI hardware
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  <--- IO_APIC_get_PCI_irq_vector dies in if (mp_bus_id_to_pci_bus[bus] == -1)
> 
> I hope you have the time to fix this for -pre4.

I already sent Marcelo the fix.

