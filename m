Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVAECnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVAECnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVAECnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:43:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12187 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262212AbVAECmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:42:47 -0500
Message-ID: <41DB5417.8020608@pobox.com>
Date: Tue, 04 Jan 2005 21:42:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Eric Mudama <edmudama@gmail.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Albert Lee <albertcc@tw.ibm.com>, IDE Linux <linux-ide@vger.kernel.org>,
       Doug Maxey <dwm@maxeymade.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: libata PATA support - work items?
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>	 <311601c9050101111929aef5ba@mail.gmail.com>  <41DB299C.3030405@pobox.com> <1104886199.17176.115.camel@localhost.localdomain>
In-Reply-To: <1104886199.17176.115.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> That means
> - Hotplug (controller and disk)

mostly either there, or easy to add

> - CHS

nod


> - "Not quite generic" IDE DMA (eg CS5520)
> - VDMA (eg CS5520)

existing hooks can handle these


> - IORDY timers (not handled well in drivers/ide but needed)

I think I know what this is.


> - Funky Maxtor "LBA48.. maybe" oddments

details?


> - Missing slave detection

Not missing, master/slave has been working for ages.  Needed for 
combined mode, where a SATA device can appear as a slave.


> - Controller errata hooks (modes, drives, timings, "dont touch during an
> I/O" etc)

Controller hooks for most situations already exist, for the most part. 
Device hooks are what is lacking.


> - Drive nIEN bugs

ditto above ("device hooks are lacking")


> - No nIEN cases

already handled in at least one case (AHCI)


> - Drives that don't do some DMA/modes right

easily doable with existing hooks


> - Crazy shit "Don't DMA from the page below 640K" (not handled by
> drivers/ide but an AMD errata
> 	fixed by using a PS/2 mouse)

heh, interesting


> - Serialize (RZ1000, CMD640, some 469, etc)

non-trivial but doable (and planned-for)


> - Bandwidth arbiter (not in drivers/ide but needed)

interesting


> - Non PCI shared IRQ mess 8(

details?

Thanks,

	Jeff

