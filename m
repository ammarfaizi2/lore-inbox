Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287292AbRL3BJ4>; Sat, 29 Dec 2001 20:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287282AbRL3BJs>; Sat, 29 Dec 2001 20:09:48 -0500
Received: from 237-ZARA-X33.libre.retevision.es ([62.82.234.237]:27142 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S287298AbRL3BJj>;
	Sat, 29 Dec 2001 20:09:39 -0500
Message-ID: <3C2CE995.6080503@zaralinux.com>
Date: Fri, 28 Dec 2001 22:52:21 +0100
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: es-es, en-us
MIME-Version: 1.0
To: jlladono@pie.xtec.es
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels, big ide disks and old bios
In-Reply-To: <3C285B40.91A83EC7@jep.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josep Lladonosa i Capell wrote:

> Hello,
> 
> the problem is this:
> 
> bios only supports disks up to 32 Gb.


I have a 486, bios (as i remember) does not even see the disk.


> 
> hard disk is 60 Gb.


HD is 40Gb


> 
> kernel is 2.4.17
> 

2.4.15-pre9 + tux2 patches


> hard disk reports its correct size when reading parameters from the
> disk, not from the bios
> 
> verd:/proc/ide/hdc# cat geometry
> physical     65530/16/63
> logical      119150/16/63
> 


[root@head (22:45:56) ~]# cat /proc/ide/hda/geometry
physical     77545/16/63
logical      77545/16/63
[root@head (22:46:07) ~]#


> 
> when booting (dmesg):
> 
> hdc: IC35L060AVER07-0, ATA DISK drive
> hdc: 66055247 sectors (33820 MB) w/1916KiB Cache, CHS=119150/16/63,
> UDMA(33)
> 
> 


hda: 78165360 sectors (40021 MB) w/1024KiB Cache, CHS=77545/16/63


> Linux adopts the 'false' geometry (65530/16/63) ) to bypass the bios
> boot.
> 
> 


All I can say is that I have a /boot partition of about 64 Megs, because 
I have / formated as reiser so /boot is ext2 because it's from the time 
that you cannot boot from reiser without notail.


> 
> I know that there are patches for 2.2 kernels and 2.3 kernels, so as
> linux adopts the logical geometry (a kiddy trick with lba size). They
> are very simple (a line), but 2.4 ide implementation is (a little more)
> complicated. Any patch?
> 


Well, it works for me, and as I have said, I have a 486, I'm not sure if 
the bios supports this size, but I seem to remember that it even does 
not detect it at boot, or perhaps it detects it as a strange size such 
as 8Gb or 32Gb, just don't remember.

Linux boots and works for me with no problem in this system.


> Bon Nadal - Merry Christmas
> 


Feliz Navidad.


> --
> Salutacions...Josep
> http://www.geocities.com/SiliconValley/Horizon/1065/



-- 
Jorge Nerin
<comandante@zaralinux.com>

