Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSEHJKw>; Wed, 8 May 2002 05:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312505AbSEHJKv>; Wed, 8 May 2002 05:10:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26630 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312498AbSEHJKu>; Wed, 8 May 2002 05:10:50 -0400
Message-ID: <3CD8DCD2.4040406@evision-ventures.com>
Date: Wed, 08 May 2002 10:07:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205070953420.2509-100000@home.transmeta.com> <20020507171946.29430@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik benh@kernel.crashing.org napisa?:
>>	/driverfs/root/pci0/00:1f.4/usb_bus/000/
>>
>>and it wouldn't be impossible (or even necessarily very hard) to make an
>>IDE controller export the "IDE device tree" the same way a USB controller
>>now exports the "USB device tree".
>>
>>For things like hotplug etc, I think driverfs is eventually the only way
>>to go, simply because it gives you the full (and unambiguous) path to
>>_any_ device, and is completely bus-agnostic.
>>
>>But there is definitely a potential backwards-compatibility-issue.
> 
> 
> One interesting thing here would be to have some optional link between
> the bus-oriented device tree and the function-oriented tree (ie. devfs
> or simply /dev). For example, an IDE node in driverfs could eventually
> hold symlinks to the entries it provides in /dev when using devfs (or
> just provide major/minor when not using devfs).
> 
> What do you think ?
> 
> One problem I've been faced with on ppc is to be able to match
> a linux device with what the firmware (Open Firmware) thinks that
> device is. The firmware view is bus-centered and it would be pretty
> easy to provide some additional entries in driverfs that give the
> OF fullpath of a given device. But then, the link between the actual
> driver in driverfs and the "device" as used by, for example, the
> filesystem isn't trivial.
> 
> Ben.
> 
> 
> 

This is the "first" IDE controller on my notebook:

./devices/root/pci0/00:07.1/01f0
./devices/root/pci0/00:07.1/01f0/0
./devices/root/pci0/00:07.1/01f0/0/power
./devices/root/pci0/00:07.1/01f0/0/name
./devices/root/pci0/00:07.1/01f0/0/status
./devices/root/pci0/00:07.1/01f0/power
./devices/root/pci0/00:07.1/01f0/name
./devices/root/pci0/00:07.1/01f0/status

Guys I have done it already!

For your convenience I will attach the ata prefix to the
currently used port number in the next patch round.

OK?

