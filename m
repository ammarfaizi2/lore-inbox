Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759826AbWLCW24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759826AbWLCW24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759828AbWLCW24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:28:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55494 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1759823AbWLCW2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:28:55 -0500
Date: Sun, 3 Dec 2006 22:36:08 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Alessandro Suardi" <alessandro.suardi@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related
Message-ID: <20061203223608.037a6d58@localhost.localdomain>
In-Reply-To: <5a4c581d0612031331v478f7a21paf29665130282b1f@mail.gmail.com>
References: <5a4c581d0612031056r1eca228fp872276f3df7a07a2@mail.gmail.com>
	<5a4c581d0612031331v478f7a21paf29665130282b1f@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ5
> > PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> > ata_piix: probe of 0000:00:1f.2 failed with error -16
> > [snip]
> > mount: could not find filesystem '/dev/root'
> 
> Same failure is also in 2.6.19-git4...

Thats the PCI updates - you need the matching fix to libata-sff where it
tries to reserve stuff it shouldn't.

Alan
