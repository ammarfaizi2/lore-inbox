Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWIENaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWIENaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWIENaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:30:15 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:40117 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964993AbWIENaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:30:13 -0400
Message-ID: <44FD7B1E.7020102@aitel.hist.no>
Date: Tue, 05 Sep 2006 15:26:54 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Grant Coady <gcoady.lk@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com> <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>> I just pulled the "pata-drivers" branch of libata-dev.git into the 
>>> "upstream" branch, which means that Alan's libata PATA driver collection 
>>> is now queued for 2.6.19.
>>>
>>> Testing-wise, these PATA drivers have been Andrew Morton's -mm tree for 
>>> many months.  Community-wise, no one posted objections to the PATA 
>>> driver merge plan, when Alan posted it on LKML and linux-ide.
>>>       
>> Too friggin' hard to test Alan's stuff for older IDE here, therefore 
>> ignored so far :(   I have some old hardware that Alan is addressing, 
>> even an old IBM 260MB PCMCIA HDD.
>>
>> I can't see an easy way to arrange multi-boot with different /etc/fstab 
>> depending if I'm trying /dev/hdaX or /dev/sdaX.  Parallel '/' partitions?
>>     
>
> Got udev?
>
> /dev/disk/by-id/ata-ST3802110A_5LR13RN7-partX could be your friend.
>   
Udev fixes this for most filesystems - except / which is cruical.
With / on raid-1 this is not a problem, as md autodetect will
assemble the arrays whether they are on ide or scsi.
But anyone with / on a partition can't easily switch
between sda/hda unless they also use an initrd.  The kernel
itself does not seem to support partition by label. :-(

Helge Hafting

