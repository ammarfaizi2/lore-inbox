Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbTABHlg>; Thu, 2 Jan 2003 02:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbTABHlg>; Thu, 2 Jan 2003 02:41:36 -0500
Received: from mail.mediaways.net ([193.189.224.113]:23670 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S265513AbTABHlf>; Thu, 2 Jan 2003 02:41:35 -0500
Subject: Re: ide harddisk freeze WDC WD1800JB vs VIA VT8235
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1041493699.958.0.camel@sun>
Mime-Version: 1.0
Date: 02 Jan 2003 08:48:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-01 at 18:37, Mark Hahn wrote:


> ide cables are <= 18", PERIOD.  if only one connnector is used,
> it must be the end one.  this is all quite clear in the ATA spec.

the flat cables I tried were all ~24cm < 18"  (tried two different
sets)... I have not measured the length of the round cables...

> the original poster should consider simplifying his system first:
> for instance, don't load all the random IO devices, especially not 
> the NVidia module, consider testing with ext2/3, etc.

I don't see the point with this. This system (with a K7- and older via
chipset) was working reliably. All that changed is 180G harddisks +
mainboard + processor. 

Anyway the kernel is not crashing and it is very unlikely that a bug in
whatever io device will cause this specific problem reproducably with
different kernel versions isn't it ?

Especially changing the file system type will not gain anything....

However it *might* be that this is some 48bit ide-access problem as both
disks are 180G in size.

Unfortunately I failed to trigger the problem, i.e. I could run
badblocks -p 0 /dev/hda and at the same time for /dev/hdc for more then
a day (>16 passes) without any trouble.

So it sounds as if the problem to occur is very very unlikely... IMHO
this is some 'failure of transfer' between disk and controller... and
this error condition is not properly handled...

Not the slightest idea what that could be....
Soeren.

