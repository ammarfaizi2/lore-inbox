Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTFDAkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTFDAj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:39:59 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18958
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262185AbTFDAj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:39:58 -0400
Date: Tue, 3 Jun 2003 17:42:14 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: schmurtz@netcourrier.com
cc: linux-kernel@vger.kernel.org
Subject: Re: hd?: lost interrupt; at least since 2.4.21-pre7
In-Reply-To: <wazza.87d6hvij01.fsf@message.id>
Message-ID: <Pine.LNX.4.10.10306031740390.27756-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Basically somewhere a patch fouled the state machine.

The expiry tripped just as an interrupt happens to be reported from the
drive.

I will need to look at the series of innerdiffs when I get time.

On Tue, 3 Jun 2003 schmurtz@netcourrier.com wrote:

> 
> Hi there
> 
> hda: dma_timer_expiry: dma status == 0x64
> hda: lost interrupt
> hda: dma_intr: bad DMA status (dma_stat=70)
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> 
> I've read a lot of people do suffer from that kind of errors.
> Especially people using VIA IDE chipset.
> When using 2.4.21-pre4-aa1 everthing is ok but when I was using .21-pre7 I had to wait
> a few days before starting to see those errors.
> I've just tried 2.4.21-pre6. Errors still happen and that a lot faster.
> 2.4.21-rc2-ac1 was subjected to that kind of errors too.
> 
> A few weeks ago, I read people complaining about similar issues.
> Especially people using Local or IO APIC support on uniprocessors and VIA IDE chipsets.
> I'm using both local and IO APIC on uniprocessors.
> 
> Is there any patch or solution ? I heard disabling acpi may help.
> 
> .config /proc/pci et /proc/dmesg are attached to this mail.
> 
> My two harddrives are subjected to those errors. Using 2.4.21-pre4-aa1 there is no error.
> I'm available to do tests.
> 
> 
> 
> 

Andre Hedrick
LAD Storage Consulting Group

