Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRAOXDS>; Mon, 15 Jan 2001 18:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbRAOXDI>; Mon, 15 Jan 2001 18:03:08 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:34577 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129737AbRAOXCw>; Mon, 15 Jan 2001 18:02:52 -0500
Date: Mon, 15 Jan 2001 19:11:56 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Neil Brown <neilb@cse.unsw.edu.au>, Jure Pecar <pegasus@telemach.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: FS corruption on 2.4.0-ac8
In-Reply-To: <3A637E15.DDC8C38@telemach.net>
Message-ID: <Pine.LNX.4.21.0101151910130.834-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jan 2001, Jure Pecar wrote:

> Hi all,
> 
> I was running 2.4.0test10pre5 happily for months and wanted to see how
> things stand in the 'latest stuff'. Here's what i found:
> 
> I compiled 2.4.0-ac8 with nearly the same .config as test10pre5 (with
> latest gcc on rh7). Then i booted it and used X for some normal browsing
> and mp3s. Performance was poor, responsivness also, even the mouse
> stopped responding for a couple of seconds at a time, a lot of disk
> trashing & so on. I deceided to boot test10 back, and there was a nasty
> suprise: fsck found filesystem with errors, and LOTS of them ... i had
> to hold down 'y' for almost 5 minutes ... :)
> 
> Then i examined the logs for what would be the cause for this ... and
> here's what 2.4.0-ac8 left in the logs:
> 
> Jan 14 16:26:47 open kernel: ee_blocks: Freeing blocks not in datazone -
> block = 979727457, count = 1
> Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 1769096736,
> count = 1
> Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 842080300,
> count = 1
> Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 1851869728,
> count = 1
> Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 808464928,
> count = 1
> ...
> and so on for about 150 such lines in 3 seconds.
> 
> There is something not that usual about my setup: i run raid1 /boot and
> raid5 root with one disk disconnected (its simply too loud...), so the
> array is in degraded mode all the time. Other hardware is more or less
> standard, p200 classic, 430vx board, adaptec2940u, 64mb ram.
> 
> Is this a known problem? If it's not, please advise me on how to provide
> more usefull informations.

Neil, 

This is the second report of corruption with RAID5. 

Do you know if any of your recent changes can be the reason?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
