Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbUL0VXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbUL0VXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 16:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUL0VXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 16:23:51 -0500
Received: from mail.netshadow.at ([217.116.182.106]:42932 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S261986AbUL0VXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 16:23:48 -0500
Message-ID: <41D07D56.7020702@netshadow.at>
Date: Mon, 27 Dec 2004 22:23:34 +0100
From: Andreas Unterkircher <unki@netshadow.at>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Trent Lloyd <lathiat@bur.st>, William Park <opengeometry@yahoo.ca>
Subject: Re: waiting 10s before mounting root filesystem?
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st>
In-Reply-To: <20041227201015.GB18911@sweep.bur.st>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or you could try a patch from Randy Dunlap & Eric Lammerts [1] which 
loops around in do_mounts.c
until the root filesystem can be mounted.... not that beautiful - but it 
works :)

[1] http://www.xenotime.net/linux/usb/usbboot-2422.patch

Cheers,
Andreas

PS: In the same manner you can do it with 2.6

Trent Lloyd wrote:

>This is really suited to the task of an initrd, then you can spin until
>the usb storage device comes up in a bash script or something similar.
>
>Cheers,
>Trent
>
>  
>
>>How do I make the kernel to wait about 10s before attempting to mount
>>root filesystem?  Is there obscure kernel parameter?
>>
>>I can load the kernel from /dev/fd0, then mount /dev/hda2 as root
>>filesystem.  But, I can't seem to mount /dev/sda1 (USB key drive) as
>>root filesystem.  All relevant USB and SCSI modules are compiled into
>>the kernel.  I think kernel is too fast in panicking.  I would like the
>>kernel to wait about 10s until 'usb-storage' and 'sd_mod' work out all
>>the details.
>>
>>-- 
>>William Park <opengeometry@yahoo.ca>
>>Open Geometry Consulting, Toronto, Canada
>>Linux solution for data processing. 
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
