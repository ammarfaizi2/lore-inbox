Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVFQJAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVFQJAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 05:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVFQJAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 05:00:51 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13255 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261924AbVFQI7V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 04:59:21 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: nforce3 250gb lockups
Date: Fri, 17 Jun 2005 11:59:02 +0300
User-Agent: KMail/1.5.4
References: <1118904850.5709.15.camel@localhost.localdomain> <1118997693.30207.119.camel@gonzales>
In-Reply-To: <1118997693.30207.119.camel@gonzales>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506171159.02128.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 June 2005 11:41, Xavier Bestel wrote:
> Sorry for replying to myself, but this may interest someone.
> 
> Le jeudi 16 juin 2005 à 08:54 +0200, Xavier Bestel a écrit :
> > Hi,
> > 
> > I have a brand new computer, with an MSI K8N Neo (nforce3-based) which
> > lockups quite easily. It seems it happens when I play audio for a while,
> > or when accessing hd under load. With "nolapic", the boot stops when
> > accessing hda, with something like "hda interrupt timeout" repeating on
> > the screen. With "noapic nolapic", it boots normally but doesn't lockup
> > less. The Ubuntu install CD lockups at boot even with "noapic nolapic".
> > 
> > The kernel is the stock debian/sid 2.6.11-9-amd64-k8, the userspace is
> > i386 (32bits). lspci and dmesg at the bottom of this mail. The only
> > advices I found by googling were to try nolapic (which I did without
> > success) or the binary drivers (which I won't try).
> > Is there anything I can do, short of trying to return it to my
> > reseller ?
> 
> As suggested by Denis Vlasenko <vda@ilport.com.ua> I disabled DMA for
> harddisks (because I have ATA hds) in the BIOS, and now it works
> flawlessly. No need for "no(l)apic". For the record, the drives are:
> 
> hda: WDC WD400BB-32BSA0, ATA DISK drive
> hdb: HITACHI DVD-ROM GD-7500, ATAPI CD/DVD-ROM drive
> hdc: ST340824A, ATA DISK drive
> hdd: DVDRW IDE 16X, ATAPI CD/DVD-ROM drive
> 
> and an unused barracuda 160G on sda.

Did you disabled DMA completely? That would make your disks very slow
and CPU hungry :(

I was thinking more of using hdparm to downgrade DMA to lower speeds,
not disabling it altogether.

If you will find that lower DMA mode works for a particular hdd
(or particular mobo chipset), a quirk fix may be added to kernel
so that it works for other folks, too.
--
vda

