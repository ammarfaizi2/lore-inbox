Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbTAKC1d>; Fri, 10 Jan 2003 21:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267117AbTAKC1d>; Fri, 10 Jan 2003 21:27:33 -0500
Received: from havoc.daloft.com ([64.213.145.173]:46294 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267115AbTAKC1c>;
	Fri, 10 Jan 2003 21:27:32 -0500
Date: Fri, 10 Jan 2003 21:36:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Adriano Carvalho <ch0wn_@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet card doesnt work in 2.4.20
Message-ID: <20030111023613.GA30131@gtf.org>
References: <F166UKfLDeyZEjpzRsf00017394@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F166UKfLDeyZEjpzRsf00017394@hotmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 12:24:37AM -0200, Adriano Carvalho wrote:
> --
> I have a Compaq Laptop 1400 14xl244, with Modem HCF conexant , and ethernet 
> card Conexant LANfinity. They are COMBO, and they use IRQ 11. When I 
> startup module (tulip) for my ethernet card, its ok. But when I try send or 
> receive anything, I dont get. PCMCIA card uses IRQ 11 too, so I get it out 
> from kernel, but it doesnt solve. Here is my /proc/interrupts :
> 
> 11: 20 XT-PIC hcf, eth0 this was after a time of try ping, and the number 
> "20" after stays 1691, after 2000... Donald Becker (tulip developer) told 
> me to send these lines : Compaq 12XL125 machine detected. Enabling 
> interrupts during APM calls. ... Local APIC disabled by BIOS -- reenabling. 
> Found and enabled local APIC! .. PCI: Using IRQ router VIA [1106/0686] at 
> 00:07.0 PCI: Found IRQ 11 for device 00:0a.0 PCI: Sharing IRQ 11 with 
> 00:09.0 PCI: Sharing IRQ 11 with 00:09.1 PCI: Disabling Via external APIC 
> routing

There are two clues here that are interesting...

First, I am worried about the APIC bits.  Can you try (a) compiling a
kernel without local APIC, and (b) boot with "noapic" on the kernel
command line [set in lilo/grub]?

Second, the Conexant LANfinity is tough for me to find, as it only
exists on laptops AFAIK, and I don't have access.  It is poorly
supported in the current kernel tulip driver.  I was recently given
access to documentation (finally!), so maybe we can resolve some of
these tulip issues too, if you are willing.  But first, tackle the
interrupt delivery problem.  Interrupt delivery is quite often a source
of bogus nic driver bug reports, unfortunatley.

	Jeff


P.S. Anyone with a source of Compaq Laptop 1400 laptops, or laptops with
a LANfinity NIC on them, please contact me off-list....

