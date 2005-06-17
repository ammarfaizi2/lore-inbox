Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVFQImU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVFQImU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 04:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVFQImT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 04:42:19 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:52378 "EHLO smtp4.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261645AbVFQImP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 04:42:15 -0400
X-ME-UUID: 20050617084211587.8F78D1C00185@mwinf0408.wanadoo.fr
Subject: Re: 2.6.11: nforce3 250gb lockups
From: Xavier Bestel <xavier.bestel@free.fr>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1118904850.5709.15.camel@localhost.localdomain>
References: <1118904850.5709.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Fri, 17 Jun 2005 10:41:33 +0200
Message-Id: <1118997693.30207.119.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for replying to myself, but this may interest someone.

Le jeudi 16 juin 2005 à 08:54 +0200, Xavier Bestel a écrit :
> Hi,
> 
> I have a brand new computer, with an MSI K8N Neo (nforce3-based) which
> lockups quite easily. It seems it happens when I play audio for a while,
> or when accessing hd under load. With "nolapic", the boot stops when
> accessing hda, with something like "hda interrupt timeout" repeating on
> the screen. With "noapic nolapic", it boots normally but doesn't lockup
> less. The Ubuntu install CD lockups at boot even with "noapic nolapic".
> 
> The kernel is the stock debian/sid 2.6.11-9-amd64-k8, the userspace is
> i386 (32bits). lspci and dmesg at the bottom of this mail. The only
> advices I found by googling were to try nolapic (which I did without
> success) or the binary drivers (which I won't try).
> Is there anything I can do, short of trying to return it to my
> reseller ?

As suggested by Denis Vlasenko <vda@ilport.com.ua> I disabled DMA for
harddisks (because I have ATA hds) in the BIOS, and now it works
flawlessly. No need for "no(l)apic". For the record, the drives are:

hda: WDC WD400BB-32BSA0, ATA DISK drive
hdb: HITACHI DVD-ROM GD-7500, ATAPI CD/DVD-ROM drive
hdc: ST340824A, ATA DISK drive
hdd: DVDRW IDE 16X, ATAPI CD/DVD-ROM drive

and an unused barracuda 160G on sda.

	Xav


