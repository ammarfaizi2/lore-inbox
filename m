Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315858AbSEMGyD>; Mon, 13 May 2002 02:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315859AbSEMGyD>; Mon, 13 May 2002 02:54:03 -0400
Received: from violet.setuza.cz ([194.149.118.97]:34566 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S315858AbSEMGyB>;
	Mon, 13 May 2002 02:54:01 -0400
Subject: Re: Reiserfs has killed my root FS!?!
From: Frank Schaefer <frank.schafer@setuza.cz>
To: Becki Minich <bminich@earthlink.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CDEDEA5.2020002@earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 May 2002 08:54:02 +0200
Message-Id: <1021272842.254.2.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-12 at 23:29, Becki Minich wrote:
> Firstly, I haven't subscribed to this list since 2.3 so please also copy 
> me on repsonses.
> Secondly, I am e-mailing from my Mother's place as it IS Mother's Day 
> AND my home PC will no longer boot Linux (my primary OS), so please send 
> responses to johnnyo@mindspring.com
> TIA :-)
> 
> Now the problem.
> I use reiserfs on all my filesystems.  I have noticed some minor 
> corruption of files in the past when I didnt shut down Linux properly 
> (lockups, etc).  I experiment alot with my computer.
> 
> Anyway lately I was havin a problem that required frequent reboots.  Now 
> I believe my root filesystem is corrupted?!?  Linux 2.4.18 boots till it 
> gets to
> 
> reiserfs: checking transaction log (device 08:12)
> attempt to access beyond end of device
> 08:12: rw=0 want=268574776 limit=8747392
> vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat 
> data of [1 2 0x0 SD]
> Using r5 hash to sort names
> Reiserfs version 3.6.25
> VFS: Mounted root (reiserfs filesystem) readonly.
> Warning: unable to mount devfs, err: -5
> Freeing unused kernel memory: 224k freed
> Warning: unable to open an initial console.
> Kernel panic: No init found.
> 
> If someone can get me to the point where I can just get to read my 
> filesystem read-only, so I get get all my data off of it, I would be 
> EXTREMELY GRATEFUL!  I have some very important data on that FS.  I went 
> to the reiserfs web site to discover I'd get charged $25 for asking for 
> help, so unless someone convinces me otherwise, I will be converting to 
> EXT3 when this disaster is over...
> 
> Slackware Linux 8.1b2
> Linux 2.4.18
> ReiserFS 3.6.25
> GLIBC 2.2.5
> GCC 2.95.3

Hi John,

you have root mounted read-only, and devfs enabled. I think you get into
trouble because of devfs. Without the devices you can't get the console
and thus you can't do anything with the computer. Furtheron init will
try to create the .initctl pipe in /dev, which is due to the not mounted
devfs in a directory of the READ-ONLY root.

My guess: Your flesystem is readable and (mostly) correct. As some
others before me mentioned -- we don't know what you did of course.

My hint: Take your recovery floppies to get into your host. For the case
you don't have some, take the installation floppies from some distro.

Best wishes
Frank

