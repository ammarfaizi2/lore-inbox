Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWHWPpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWHWPpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWHWPpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:45:52 -0400
Received: from lucidpixels.com ([66.45.37.187]:2176 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S964990AbWHWPpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:45:52 -0400
Date: Wed, 23 Aug 2006 11:45:51 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Johan Groth <johan.groth@linux-grotto.org.uk>
cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
In-Reply-To: <44EC775C.7040003@linux-grotto.org.uk>
Message-ID: <Pine.LNX.4.64.0608231145290.15031@p34.internal.lan>
References: <44EB1875.3020403@linux-grotto.org.uk> <44EC73D2.9090302@rtr.ca>
 <44EC775C.7040003@linux-grotto.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Aug 2006, Johan Groth wrote:

> Mark Lord wrote:
>> Johan Groth wrote:
>
> [snip]
>
>> Basically, given an I/O request for 200 sectors, with a bad sector
>> in the middle at number 100, what SCSI will often do is fail sectors
>> number 1 through 100, one at a time, retrying the entire remainder of
>> the request after each attempt.  This takes hours, and results in no
>> data for the first 99 good sectors.
>
> So what you are saying is that after the move to a new box and a new mobo a 
> sector has gone bad on that raid slice? Weird, as I was very careful this 
> those drives when I moved them.
>
> I mean, the raid controller is the same, the cpus are the same, just more of 
> them, the pci-x bus the same so I didn't expect any problems at all.
>
> I was also under the impression that SATA raid controllers work like SCSI 
> raid controllers in the way that if a bad sector is encountered the 
> controller moves what it can and the mark the sector as bad. I might be very 
> wrong about that, though.
>
> However, if I have a bad sector I would like to have that one marked as bad 
> so the kernel never tries to read it again. Any suggestions how I do that. I 
> assume I have to boot something like Knoppix as sda is my system disk.
>
> Regards,
> Johan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Run badblocks in r+w mode on the bad disk and it will force the disk to 
re-allocate the bad sector if it can.

Justin.
