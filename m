Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129149AbRBAIpF>; Thu, 1 Feb 2001 03:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbRBAIoz>; Thu, 1 Feb 2001 03:44:55 -0500
Received: from f204.law9.hotmail.com ([64.4.9.204]:57863 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129149AbRBAIoo>;
	Thu, 1 Feb 2001 03:44:44 -0500
X-Originating-IP: [128.2.152.56]
From: "William Knop" <w_knop@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Modules and DevFS
Date: Thu, 01 Feb 2001 03:44:38 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F204tAEHLB8TrBHxvZ900001de6@hotmail.com>
X-OriginalArrivalTime: 01 Feb 2001 08:44:38.0431 (UTC) FILETIME=[360762F0:01C08C2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>One thing that I've noticed with devfs is that all the old-style names are
>symlinks.

Hmm... I have no symlinks until the module loads. Therefore X sees no 
/dev/input/mouse, doesn't ask the kernel for it, the kernel doesn't load the 
module, and DevFS doesn't add the /dev entry. There's got to be an easy way 
around this. Perhaps it has already been implimented, but I haven't been 
able to get anything to work well (manual loading for me).

>Everything is modularized here, including ppp and such, and modprobe is
>loading everything quite nicely for me.  I don't like to run one big
>kernel, it wastes too much memory, and so I use pretty much *everything*
>that I can in modules (IDE I can't, because I boot from IDE, but I leave
>SCSI in a module, becuase I use ide-scsi to burn my CDs and it's not
>*reqired*).

Really? How can DevFS know which devices to add to /dev/scsi/... without 
loading the module and scanning the bus first? Or do you manually insert the 
scsi module when you need it?

Do you think if I add symlinks manually perhaps it will force DevFS to look 
for a module to add the needed entry? Or maybe module aliases? I think I am 
going to spend some time checking out the DevFS code and experimenting with 
module entries.

-Will
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
