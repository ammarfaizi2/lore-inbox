Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUANSmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUANSmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:42:08 -0500
Received: from pop.gmx.net ([213.165.64.20]:60290 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263861AbUANSmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:42:03 -0500
X-Authenticated: #7370606
Message-ID: <40058D6E.3050409@gmx.at>
Date: Wed, 14 Jan 2004 19:41:50 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Leonard <ian@smallworld.cx>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Highpoint hpt370 raid and spanning of disks
References: <1dUvz-1JH-23@gated-at.bofh.it>
In-Reply-To: <1dUvz-1JH-23@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Leonard wrote:
> Greetings,
> 
> I have tried to get the htpraid.o module working with spanned raid  
> disks with a hpt370 chip (it is a slightly older version). I did this:
> 
> 1. Setup the raid in the hpt bios
> 2. loaded the hptraid.o module (kernel: 2.4.24)
> 3. fdisk /dev/ataraid/d0 and create /dev/ataraid/d0p1
> I note that fdisk shows one partition of 80GB (which is correct because  
> I         have 2x40GB disks).
> 4. mke2fs -j /dev/ataraid/d0p1
> 5. mount the partition and df shows 80GB.
> 6. run a test program that fills up the disk with many 1GB files. At  
> about the 32nd file I see errors from ext3 and also i/0 errors ide  
> controller. The error messages list the hdg device and indicate that  
> they can't find sectors in the second disk.
> 
> After a reboot, the raid bios marks the 2nd disk with 'broken span'.
> 
> I then tried a Promise FastTrak2000 card with very similar results. It  
> looks like once data is written to the second disk, something goes  
> wrong. Unlike the Highpoint (which produces large numbers of errors)  
> the Promise produces a few here and there.

this sounds like a broken disk or a bad cable. please try to delete the 
span array on the hpt370 controller and then recreate the volume by 
selecting the disks in reversed order. so that the second disk comes 
first. if it there are still errors at about the 32 file then send me 
the geometry data and the first 16 sectors of your disks.

> 
> I see from a previous posting that spanning is supported, so I maybe  
> missing something. Any help appreciated.
> 
> 
> (BTW, this is cross-posted from linux-ide, which doesn't seem to be  
> working for me).

bye,
wilfried
