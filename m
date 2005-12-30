Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVL3M4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVL3M4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 07:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVL3M4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 07:56:44 -0500
Received: from guri.is.scarlet.be ([193.74.71.22]:38560 "EHLO
	guri.is.scarlet.be") by vger.kernel.org with ESMTP id S1751253AbVL3M4o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 07:56:44 -0500
Message-ID: <43B52F27.20903@kefren.be>
Date: Fri, 30 Dec 2005 13:59:19 +0100
From: Ochal Christophe <ochal@kefren.be>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cannot boot 2.6.15-rc6 on Opteron machine
References: <43B3CA9E.7000804@voltaire.com>	 <Pine.LNX.4.63.0512300725300.5860@dad.localdomain> <1135946670.2941.21.camel@laptopd505.fenrus.org>
In-Reply-To: <1135946670.2941.21.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Fri, 2005-12-30 at 07:31 -0500, Thomas Molina wrote:
>  
>
>>On Thu, 29 Dec 2005, Erez Zilber wrote:
>>
>>    
>>
>>>Hi,
>>>
>>>I've downloaded kernel 2.6.15-rc6 (had the same problem with rc7) and built it
>>>on RHAS 4:
>>>
>>>When I did that on an Opteron machine, after rebooting and selecting the
>>>2.6.15-rc6 entry in the grub menu, I get the following:
>>>
>>>Uncompressing Linux... Ok, booting the kernel.
>>>Kernel panic - not syncing: VFS: unable to mount root fs on unknown-block(0,0)
>>>
>>>I made sure that ext2 is compiled with the kernel (not as a module).
>>>
>>>When I do the same on an emt64 machine, everything works ok. Any idea?
>>>      
>>>
>>Check on your /boot/grub.config.  The above error message is typically 
>>seen when the root= parameter points to a symbolic disk label instead of a 
>>specific disk such as /dev/hda1.  I'm not sure what the procedure for 
>>updating where the label points (possibly a mkinitrd) because I normally 
>>change the grub.conf to point to a specific disk.
>>    
>>
>
>there is no such procedure, because the disk labels are... ON THE DISK.
>And the initrd reads them from all the disks at boot time to find the
>one needed. This means that if your disk changes name (for example
>because of a scsi bus order change or because of a different order you
>load the device drivers... or even if you forget to compile the sata
>drivers and suddenly the disk goes from /dev/sda to /dev/hda).... things
>just remain working
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
Compile the kernel with support for your hardware built in, i'm assuming 
you eighter build the controller as a module or didn't built it at all
