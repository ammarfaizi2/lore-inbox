Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSHAUXb>; Thu, 1 Aug 2002 16:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSHAUXb>; Thu, 1 Aug 2002 16:23:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60169 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317037AbSHAUXa>; Thu, 1 Aug 2002 16:23:30 -0400
Message-ID: <3D499862.6070305@evision.ag>
Date: Thu, 01 Aug 2002 22:21:54 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.29 IDE 110
References: <C917933AE2@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Petr Vandrovec napisa?:
> On  1 Aug 02 at 2:40, Marcin Dalecki wrote:
> 
>>- Eliminate support for "sector remapping". loop devices can handle
>>    stuff like that. All the custom DOS high system memmory loaded
>>    BIOS workaround tricks are obsolete right now. If anywhere it should
>>    be the FAT filesystem code which should be clever enough to deal with
>>    it by adjusting it's read/write methods.
> 
> 
> Hi Marcin,
>   I'm using this on one system here - it has BIOS without LBA32, and
> without support for >30GB disks, but I needed to put large disk with
> already existing system to it, and using some disk manager was only
> choice (EZDrive, using 0_to_1 remap)... I know that 0_to_1 remap
> is broken for nr_sectors > 1, but it is hard to use loop device if
> system does not come up without boot manager at all.

Maybe not a loop device? But how about handling this at partition scan
time then? Partitions are after all nothing else then devices
with remapped sectors in first place. Could you manage to insert
at the proper place in paritions/*.c the magical + 1.
It could then be turned in no instant in to a global kernel
option - whch it what it is after all.


