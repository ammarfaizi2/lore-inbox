Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSE3O7a>; Thu, 30 May 2002 10:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSE3O73>; Thu, 30 May 2002 10:59:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36367 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316677AbSE3O72>; Thu, 30 May 2002 10:59:28 -0400
Message-ID: <3CF630A5.40002@evision-ventures.com>
Date: Thu, 30 May 2002 16:01:09 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <UTC200205301443.g4UEhvn20167.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>     > Of course - improvements are always welcome.
>     > (But I try to be slightly more careful than you are.
>     > Util-linux runs on all libc's and all kernels, from libc4 to glibc2
>     > and from 0.99 to 2.5. So, changes must be compatible.)
> 
>     Having them compatible acroess an insane range of kernels
>     is a nice but futile exercise.
>     Perhaps this partly explains why:
> 
>     1. util-linux doesn't cover half of the system utilities needed on
>         a sanely actual Linux system.
> 
>     2. The Linux vendors have to apply insane number of patches to it
>         util it's moderately usable.
> 
> If you do the kernel ATA stuff, I'll take care of util-linux.

Well that's actually a deal :-).

> (Does it need more utilities? Probably those are in some other package.
> Sometimes stuff is added, but not very often. However, your suggestions
> are welcome.
> Do the vendors add patches? Half of that is vendor extensions, that is
> their business. Half of that is their stupidity. They blindly copy the
> patches other vendors apply "it is a patch - must be an improvement";
> sometimes I have to reject the same buggy patch more than a dozen times.
> When I ask for the reason of a patch, they don't know themselves.)

Well somehow I have partly to agree. But however having a way to
exclude network devices from mounting during mount -a is *very* usefull,
becouse failing NFS servers will sometines prohibit your watchdog
triggered reboot to happen for example!

Or not doing swapon twice and beeing silent about it - just good
UNIX habit the user requested it to go on - well it's on, so all
is fine, no error in this.

I can stuff together what I think is usefull however...

> 
>     >     No need to invent here. No need to do the book keeping in kernel.
>     > 
>     > Some need. Things like mount-by-label want to know what partitions
>     > exist in order to look at the labels on each.
>     > Yes, we really need a list of disk-like devices.
>     > The gendisk chain.
> 
>     No I don't see that point. Data which has to be persistant across
>     reboots is simple data which has to reside on disk. That's the
>     way it is in UNIX (PalmOS to name an example).
> 
> Maybe you never heard of mount-by-label?
> 
> Andries


Urhg? I did of course hear about them!


~# ssh kozaczek
root@kozaczek's password:
Last login: Thu May 30 14:37:32 2002 from 10.0.0.1
cd [root@kozaczek root]# cd /etc
[root@kozaczek etc]# cat fstab
LABEL=/                 /                       ext3    defaults        1 1
LABEL=/boot             /boot                   ext3    defaults        1 2
/dev/fd0                /mnt/floppy             auto    noauto,owner    0 0
# /dev/loop1            /mnt/1                  auto    noauto,owner    0 0
# /dev/loop2            /mnt/2                  auto    noauto,owner    0 0
none                    /proc                   proc    defaults        0 0
none                    /tmp                    tmpfs   defaults        0 0
none                    /dev/pts                devpts  gid=5,mode=620  0 0
/dev/hda6               swap                    swap    defaults        0 0
[root@kozaczek etc]#


Hmm I didn't check whatever they can be used on swap partitions too.
If not I will fix it right away.

