Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267211AbUHDCVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267211AbUHDCVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267231AbUHDCVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:21:34 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:10972 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267211AbUHDCUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:20:31 -0400
References: <1091570098.1612.27.camel@localhost>
Message-ID: <cone.1091586026.382136.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: jacquesf@wciatl.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting 2.6.x slows to almost to a halt when detecting hard
         drives on Dell Inspiron 5150
Date: Wed, 04 Aug 2004 12:20:26 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacques Fortier writes:

> Hi,
> 
> I've had issues getting 2.6 kernels to boot. It seems to be an issue
> either with my Intel ICH4 IDE controller or my Hitachi Travelstar 60GB
> disk.
> 
> I'm trying to get 2.6 working on a Dell Inspiron 5150. I've been running
> 2.4 for a while without any problems. I've witnessed this problem in the
> Debian 2.6.7 and 2.6.6 kernel packages, 2.6.7 compiled from the Debian
> source code, and 2.6.7 compiled from the vanilla kernel.org source.
> 
> Everything seems to work fine until the hard drive detection starts.
> Since I'm not sure how much of this stuff if relelvant, I've
> painstakingly transcribed a bunch of the output
> 
> ICH4: IDE controller at PCI slot 0000:00:1f.1
> PCI: enabling device 0000:00:1f.1 (0005 -> 0007)
> ICH4: chipset revision 1
> ICH4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA hdb:pio
>     ide1: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA hdb:pio
> hda: SAMSUNG CDRW/DVD SN-324F, ATAPI CD/DVD-ROM drive
> Using anticipatory io scheduler
> ide0 at 0x1f0-0x1f7 0x3f6 on irq 14
> hdc HTS548060M9AT00, ATA DISK drive
> ide1 at 0x170-0x177 0x376 on irq 15
> hdc: max request size: 1024KiB
> hdc: lost interrupt
> hdc: lost interrupt
> hdc: lost interrupt

Have you tried booting with various apic and acpi options? Try 
noapic 
and / or
acpi=off

see if that helps.

Cheers,
Con

