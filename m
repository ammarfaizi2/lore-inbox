Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262996AbSJBHuW>; Wed, 2 Oct 2002 03:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbSJBHuW>; Wed, 2 Oct 2002 03:50:22 -0400
Received: from kim.it.uu.se ([130.238.12.178]:60596 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S262996AbSJBHuV>;
	Wed, 2 Oct 2002 03:50:21 -0400
Date: Wed, 2 Oct 2002 09:55:41 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210020755.JAA17729@kim.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, axboe@suse.de
Subject: Re: v2.6 vs v3.0
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Oct 2002 12:31:10 +0100, Alan Cox wrote:
>On Tue, 2002-10-01 at 08:54, Mikael Pettersson wrote:
>> - I have several boxes with decent PCI chipsets (BX, HX) but old disks.
>>   With 2.5.39, they tend to spew a couple of ..._intr errors on boot.
>>   (Sorry, can't be more specific right now. I won't be near those
>>   boxes until Saturday.)
>
>Thats fine. Its issuing commands the drives reject. Right now we dont do
>it quietly that is all.

Ok, thanks. I won't worry about those then.

>> - My Intel AL440LX box (440LX chipset, 20G Quantum Fireball) worked
>>   brilliantly up to 2.5.36, but hangs *hard* with 2.5.39 as soon
>>   as I tar zxf the kernel source tarball.
>>   (May or may not be IDE. I'll try a minimal 2.5.39 tonight.)
>
>Thats PIIX, which should be the most boringly stable configuration of
>the lot 8(

The bug turned out to be in INITRD not IDE or PIIX. If and only if
I boot with an initrd the kernel hangs really hard somewhere in the
middle of a tar zxf of the kernel tarball (which is why I suspected IDE).
It seems like INITRD clobbers some critical data structure. (Neither the
NMI watchdog nor SysRQ would bring it out of the hang.)

/Mikael
