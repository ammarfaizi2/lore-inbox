Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSE3OBA>; Thu, 30 May 2002 10:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316650AbSE3OA7>; Thu, 30 May 2002 10:00:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11279 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316629AbSE3OA6>; Thu, 30 May 2002 10:00:58 -0400
Message-ID: <3CF622F0.4050304@evision-ventures.com>
Date: Thu, 30 May 2002 15:02:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <UTC200205300019.g4U0JtH24034.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>     Ahhh... wait a moment you are the one who is responsible for
>     util-linux - wouldn't you care to take a bunch of patches?!
> 
> Of course - improvements are always welcome.
> (But I try to be slightly more careful than you are.
> Util-linux runs on all libc's and all kernels, from libc4 to glibc2
> and from 0.99 to 2.5. So, changes must be compatible.)

Having them compatible acroess an insane range of kernels
is a nice but futile exercise.
Perhaps this partly explains why:

1. util-linux doesn't cover half of the system utilities needed on
    a sanely actual Linux system.

2. The Linux vendors have to apply insane number of patches to it
    util it's moderately usable.

>     No need to inevent here. No need to do the book keeping in kernel.
> 
> Some need. Things like mount-by-label want to know what partitions
> exist in order to look at the labels on each.
> Yes, we really need a list of disk-like devices.
> The gendisk chain.

No I don't see that point. Data which has to be persistant across
reboots is simple data which has to reside on disk. That's the
way it is in UNIX (PalmOS to name an example).
And after all it's rather trivial to iterate *all* disks present at boot
by hand and just going through /dev/sdaxxx chains. SCSI allocates
them consecutively anyway and there are typically not many ATA diskst around
there.
After all kudzu is performing nearly the whole job for anything else
except disks anyway for example.

