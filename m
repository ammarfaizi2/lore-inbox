Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293063AbSB1LHg>; Thu, 28 Feb 2002 06:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293309AbSB1LFR>; Thu, 28 Feb 2002 06:05:17 -0500
Received: from unicef.org.yu ([194.247.200.148]:34316 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S293216AbSB1LDJ>;
	Thu, 28 Feb 2002 06:03:09 -0500
Date: Thu, 28 Feb 2002 12:02:54 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Pavel Machek <pavel@ucw.cz>
cc: Alexander Viro <viro@math.psu.edu>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/mounts: two different loop devices mounted on same
 mountpoint?!
In-Reply-To: <20020228095948.GG774@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0202281200230.15246-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that is normal behaviour in 2.4.X
that one can mount more than once
on same mount point.

Zoran

On Thu, 28 Feb 2002, Pavel Machek wrote:

> Date: Thu, 28 Feb 2002 10:59:48 +0100
> From: Pavel Machek <pavel@ucw.cz>
> To: Alexander Viro <viro@math.psu.edu>
> Cc: kernel list <linux-kernel@vger.kernel.org>
> Subject: /proc/mounts: two different loop devices mounted on same
>     mountpoint?!
>
> Hi!
>
> Kernel 2.4.17:
>
> pavel@amd:~/misc$ cat /proc/mounts
> /dev/root / ext2 rw 0 0
> /dev/hda3 /suse ext2 rw 0 0
> none /proc proc rw 0 0
> none /proc/bus/usb usbdevfs rw 0 0
> /dev/cfs0 /overlay coda rw 0 0
> /dev/loop0 /mnt ext2 rw 0 0
> /dev/loop1 /mnt ext2 rw 0 0
> pavel@amd:~/misc$
>
> Both /dev/loop0 *and* /dev/loop1 mounted on /mnt at same time? Oops?
> What's the semantics of that? [And I guess it should not be allowed)
>
> 									Pavel
> --
> (about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
> no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

