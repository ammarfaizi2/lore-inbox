Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310727AbSCHIOL>; Fri, 8 Mar 2002 03:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310730AbSCHIOB>; Fri, 8 Mar 2002 03:14:01 -0500
Received: from [195.63.194.11] ([195.63.194.11]:45584 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310729AbSCHINt>; Fri, 8 Mar 2002 03:13:49 -0500
Message-ID: <3C88727A.5020108@evision-ventures.com>
Date: Fri, 08 Mar 2002 09:12:42 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Hank Yang <hanky@promise.com.tw>
CC: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
In-Reply-To: <014701c1c5b6$a0dfb620$59cca8c0@hank> <3C873F96.C91E3591@redhat.com> <00b901c1c642$e7b6e9b0$59cca8c0@hank>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hank Yang wrote:
> Hello.
> 
>     That's because the linux-kernel misunderstand the raid controller
> to IDE controller. If do so, The raid driver will be unstable when
> be loaded.
> 
>     So we must to prevent the raio controller to be as IDE controller
> here.

Dear Hank. Please let me elaborate a bit on this, to see whatever
I understand the issues.

The Promise controlled is NOT a true self hosted RAID controller.
It is just a bunch of ATA host chips, which a software add on
in some ROM exposed as BIOS to Win32 systems, making it possible
for them to view multiple configurations of the disks as once single
nice RAID.

However under linux we have the nice ataraid.c driver, which is
allowing one to use whichever ATA disks one wan't on whichever
channels as RAID. The overhead of running the RAID functionality code
from true nice RAMBUS RAM, in comparision to stincking flash RAM
on some PCI card behind two bridges is in fact negative ;-).

It doesn't therefore make any sense for a linux user to use
the PDC as something elese then a bunch of host chennel chips.

Or what are your concerns?

