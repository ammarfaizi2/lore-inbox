Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313027AbSDTSsE>; Sat, 20 Apr 2002 14:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSDTSsD>; Sat, 20 Apr 2002 14:48:03 -0400
Received: from [137.112.40.22] ([137.112.40.22]:2554 "EHLO
	hermes.cs.rose-hulman.edu") by vger.kernel.org with ESMTP
	id <S313027AbSDTSsD>; Sat, 20 Apr 2002 14:48:03 -0400
Date: Sat, 20 Apr 2002 13:46:38 -0500 (EST)
From: "Leslie F. Donaldson" <donaldlf@cs.rose-hulman.edu>
X-X-Sender: <donaldlf@voodoo>
To: <axp-kernel-list@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <ldonald@nw.verizonwireless.com>
Subject: Re: Booting on a raid/lvm combination?
In-Reply-To: <Pine.GSO.4.33.0204180909540.17436-100000@voodoo>
Message-ID: <Pine.GSO.4.33.0204201343130.2981-100000@voodoo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still can't seem to make it work sigh. The raid
seems to initialize but the lvm wacks.

boot sda1:/vmlinux.ga root=/dev/lvm00/idsk0 initrd=initrd.gz

It appears my problem is the kerenl is trying to load
initrd off of the lvm volume but in order for the
lvm volume to be activated the initrd needs to go first.

sda1 is a msdos disk with the kernel and the initrd,gz ball.

Any suggestions or manuals out there?

Leslie Donaldson

On Thu, 18 Apr 2002, Leslie F. Donaldson wrote:

> Hello,
>   After loseing my hard drive to e2fs corruption I decided
> to build the drive system up, so I am laying out an
>
> raid-5 --> LVM --> reiserfs
>
> Distribution is 7.1 (soon to be upgraded to rawhide)
>
> My problem is I boot with milo and I can't get it to work.
> I have my kernel on a dos part at sda1 and I have added
> a file initrd.gz to that disk. My real root system is sda3
> which is the raid.
>
> I boot using (or try to boot)
>
> boot sda1:/vmlinux.gz root=/dev/sda3 initrd=/initrd.gz
>
> but it can't find the file because it's on the lvm drive which
> is no active yet. I tried something along the lines of
>
> boot sda1:/vmlinux.gz root=/dev/sda3 initrd=sda1:/initrd.gz
>
> Does anyone have a clue I can use?
>
> Please reply to me directly ad without my drives working
> it's a terminal session to my email account <sigh>
>
> Leslie Donaldson
>
>
>
>
> _______________________________________________
> Axp-kernel-list mailing list
> Axp-kernel-list@redhat.com
> https://listman.redhat.com/mailman/listinfo/axp-kernel-list
>

