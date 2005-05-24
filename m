Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVEXSA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVEXSA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVEXSA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:00:27 -0400
Received: from w002.z065106067.sjc-ca.dsl.cnc.net ([65.106.67.2]:24005 "EHLO
	smtp.mail-test.us") by vger.kernel.org with ESMTP id S261369AbVEXSAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:00:12 -0400
Message-ID: <42936BB8.3070903@mail-test.us>
Date: Tue, 24 May 2005 11:00:24 -0700
From: Chris Haumesser <chris@mail-test.us>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050328)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kallol@nucleodyne.com
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: promise sx8 sata driver
References: <42924E38.7070003@mail-test.us>  <42925F7F.2000809@pobox.com> <1116909972.15027.3.camel@driver>
In-Reply-To: <1116909972.15027.3.camel@driver>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand either.  The Promise driver (I think this is carmel?)
found at
http://www.promise.com/support/download/download2_eng.asp?productID=125&category=all&os=100#
seems to be GPL.  I haven't tested it extensively yet, but it appears to
provide scsi device nodes that grub recognizes readily.

Why are there two GPL driver projects for this card, and what is the
difference?  Is there something wrong with promise's driver, or
inherently superior in the kernel driver?  How is one supposed to
choose?  There is very little documentation for either driver, so it is
quite unclear which is appropriate for a given application.


-C-


Kallol Biswas wrote:

>How good is 2.6.6 carmel.c driver for sx8 adapters? Does it support
>the promise adapter? Why have you developed sx8.c?
> 
>
>On Mon, 2005-05-23 at 15:55, Jeff Garzik wrote:
>  
>
>>Chris Haumesser wrote:
>>    
>>
>>>The sx8 driver does not use libata, and it is a separate block device,
>>>outside of the scsi and ata hierarchies.  If I compile the driver into
>>>my kernel, I end up with /dev/sx8/0 and /dev/sx8/0p1, etc.  However, no
>>>scsi disk devices are created, and grub does not recognize that
>>>/dev/sx8/ devices are disks.  There's no indication in /proc/scsi/ that
>>>they are being registered with the scsi subsystem; this is clearly
>>>different from every other sata controller I've used.  I've been
>>>googling this for days, with no real luck.  I have found changelogs for
>>>grub that suggest that my version (0.95) should support booting from the
>>>sx8.
>>>      
>>>
>>sx8 is a separate block driver, and has nothing whatsoever to do with scsi.
>>
>>
>>    
>>
>>>So my question is, how does one use this driver for sata disks?  Is my
>>>problem a grub problem, or does it have something to do with the fact
>>>      
>>>
>>a grub problem
>>
>>
>>    
>>
>>>What is the relationship between the promise driver and the one included
>>>in the kernel?  Why does one work differently from the other?  Is there
>>>      
>>>
>>Promise SX8 provides neither an ATA nor SCSI interface to the developer, 
>>so its not written as an ATA or SCSI driver.
>>
>>	Jeff
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>  
>
