Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVJNSZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVJNSZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVJNSZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:25:33 -0400
Received: from smtp.preteco.com ([200.68.93.225]:33417 "EHLO smtp.preteco.com")
	by vger.kernel.org with ESMTP id S1750837AbVJNSZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:25:32 -0400
Message-ID: <434FF7CA.3060805@rhla.com>
Date: Fri, 14 Oct 2005 15:24:10 -0300
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@rhla.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       moliveira@latinsourcetech.com
Subject: Re: Problems in kernel migration from 2.4 to 2.6+
References: <434FBF3F.2040604@rhla.com> <Pine.LNX.4.58.0510141336430.23643@localhost.localdomain> <Pine.LNX.4.58.0510141043560.14243@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0510141043560.14243@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Fri, 14 Oct 2005, Steven Rostedt wrote:
>
>  
>
>>On Fri, 14 Oct 2005, Márcio Oliveira wrote:
>>
>>    
>>
>>>Hi there!
>>>
>>>  I am migrating my linux laptop from a kernel 2.4.27-2  to a 2.6.12.6
>>>one. Since I compiled the 2.6.12.6 kernel and booted my laptop, I am
>>>receiving the following message when chose the 2.6.12.6 entry in the
>>>grub menu:
>>>
>>>mount: mount point dev does not exist
>>>pivot_root: No such file or directory
>>>/sbin/init: 432: cannot open dev/console: No such file
>>>Kernel panic - not syncing: Attempted to kill init!
>>>
>>>   But when I chose the 2.4.27 entry in the grub meno, my laptop boots ok!
>>>
>>>   My laptop is running Debian Sarge 3.1a,  kernel 2.4.27-2 (that it is
>>>booting ok) and kernel 2.4.6.12.6 (kernel.org kernel).  I compiled the
>>>2.6.12.6 kernel with all needed modules (sata disk, ext3 ... including
>>>devfs support), maked a initrd image with the necessary modules to mount
>>>the / partition (sata modules, file system modules...) and changed the
>>>disks names in the /etc/fstab from hda to sda (as it is recognized at
>>>2.6.12.6 kernel bootup process). The laptop model is IBM Thinkpad T43.
>>>      
>>>
>>That hda to sda looks funny.  I didn't know the T43 has a SCSI (which I'm
>>pretty sure it doesn't).
>>    
>>
>
>It may have SATA, which would show up as sda.
>  
>

yeah, my laptop has SATA disks and it is recognized as  a sda disk...

>Do you have all of the necessary SATA drivers and sd.o (sd.ko
>if modules) present?
>  
>

I think I do.  The SATA controller is recognized at the boot time and 
the driver loaded is ata_piix, the boot process messages also shows the 
partiotion table.

All modules dependences are in the initrd file (scsi_mod, libata, 
sd_mod) and the initrd file has the /dev/console device. The laptop 
kernel doesn't have the "sd.ko" module, I think in my case the module sd 
is the sd_mod, right?

>  
>
>>>Any ideia? Anybody knows why it is happen?
>>>
>>>      
>>>
>>Are you sure the initrd was correctly made. That pivot_root seems to
>>suggest that it wasn't.  You're using Debian. When I went from 2.4 to 2.6
>>I just used aptitude (or apt-get) to get the 2.6 kernel first, and let the
>>package manager make all the necessary changes for me.  I also usually
>>don't use an initrd and just compile in the drivers for my ide and
>>filesystems.
>>    
>>

I got the sarge official kernel package with all dependences (via 
apt-get), installed it and the new kernel has the same problem that the 
manualy compiled one has!

Any ideias?



