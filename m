Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUAJPnc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUAJPnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:43:32 -0500
Received: from [216.127.68.117] ([216.127.68.117]:48785 "HELO 216.127.68.117")
	by vger.kernel.org with SMTP id S265210AbUAJPn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:43:29 -0500
Message-ID: <40001D91.40702@meerkatsoft.com>
Date: Sun, 11 Jan 2004 00:43:13 +0900
From: Alex <alex@meerkatsoft.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Christian Kivalo <valo@valo.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cannot boot after new Kernel Build
References: <NMEHJKFGFEGJPIPOLFFECEBBDEAA.valo@valo.at>
In-Reply-To: <NMEHJKFGFEGJPIPOLFFECEBBDEAA.valo@valo.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I tried changing the fstab, removing the LABLE from the grub.conf, 
removing initrd from it and also tried to boot with /dev/hda3.  Nothing 
works, still the same problem.

Alex

Christian Kivalo wrote:

>>Hi,
>>I am trying to build a new kernel but what ever version 2.4.24, 2.6.0,
>>2.6.1 i am trying to build I come across the same problem.
>>
>>when doing a "make install" i get the following error.
>>
>>/dev/mapper/control: open failed: No such file or directlry
>>Is device-mapper driver missing from kernel?
>>Comman failed.
>>
>>I have installed the lates packages
>>device mapper 1.00.07
>>initscripts 7.28.1
>>modutils, lvm2.2.00.08
>>mkinitrd-3.5.15.1-2
>>
>>If I just ignore the message and try to boot the machine with the new
>>kernel then I get a Kernel Panic.
>>
>>VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
>>Please append a correct "root=" boot option
>>Kernel panic: VFS: Unapble to mount root fs on unknown-block(0,0).
>>
>>The boot command in grub is
>>root (hd0,0)
>>kernel /vmlinuz-2.6.1 ro root=LABEL=/ hdc=ide-scsi
>>initrd /initrd-2.6.1.img
>>
>>It is basically the same (except the version) as I use for
>>2.4.20-28 so
>>I assume the label is correct.
>>
>>I saw quite a few messages of similar type but no real answer to the
>>problem. Any Ideas what it could be ?  I am using RH9.0
>>    
>>
>
>hi!
>
>as mentioned in this thread
>(http://marc.theaimsgroup.com/?l=linux-kernel&m=107330398724534&w=2) a
>few days ago, christophe saout wrote: "LABEL= is a RedHat extension.
>Please use the normal root options that is described in the Grub or
>kernel documentation."
>rik van riel mentioned: "It's not even a Red Hat extension.  The LABEL=
>stuff is done entirely in userspace, on the initrd.
>
>If you do not want to use an initrd, you need to use the normal root
>options instead, something like root=/dev/hda3" that thread also offers
>some information to the problem."
>
>have you created an initrd? if not, comment that line out of your grub
>config.
>
>you can leave your fstab like it is, using labels in fstab is ok.
>
>hth
>christian
>
>  
>
>>Thanks
>>Alex
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


