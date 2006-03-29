Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWC2Xej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWC2Xej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWC2Xej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:34:39 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:61626 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751271AbWC2Xei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:34:38 -0500
Date: Wed, 29 Mar 2006 17:34:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Schedule for adding pata to kernel?
In-reply-to: <m3acb8eveg.fsf@lugabout.jhcloos.org>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <442B1981.1050201@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5SuEq-6ut-39@gated-at.bofh.it> <5TDme-22E-27@gated-at.bofh.it>
 <5UAcC-3bd-3@gated-at.bofh.it> <5UH4o-4RJ-27@gated-at.bofh.it>
 <5UTfA-5uK-17@gated-at.bofh.it> <442A9A1C.1020004@shaw.ca>
 <m3acb8eveg.fsf@lugabout.jhcloos.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



James Cloos wrote:
>>>>>> "Robert" == Robert Hancock <hancockr@shaw.ca> writes:
> 
> JimC> but [I] never managed to determine the CONFIG that used ata_piix rather
> JimC> than the old ide drivers.  Each attempt left me with a kernel which
> JimC> could not mount its root....
> 
> Robert> If you build them into the kernel, it should just work..
> 
> Agreed.  It should.
> 
> But if I leave in CONFIG_IDE=y, CONFIG_BLK_DEV_PIIX=y I get root on
> 0x0302 rather than 0x0802 even when I also have CONFIG_SCSI_SATA=y
> and CONFIG_SCSI_ATA_PIIX=y.
> 
> If the first two are not set then the kernel cannot find anything.
> 
> My understanding is that with Alan's patch everything should be
> using major 8, and that CONFIG_IDE is no longer required, yes?

You should be able to set CONFIG_IDE=n and have it work. That PCI ID is 
listed in the ata_piix device table so I should think it would work.. 
can you post the output?
