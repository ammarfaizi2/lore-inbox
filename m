Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbTFUVXG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 17:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTFUVXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 17:23:06 -0400
Received: from kuwiserv.folkwang-hochschule.de ([193.175.156.250]:29141 "EHLO
	kuwiserv.folkwang-hochschule.de") by vger.kernel.org with ESMTP
	id S265341AbTFUVXA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 17:23:00 -0400
Message-ID: <3EF4DDF1.2010101@folkwang-hochschule.de>
Date: Sun, 22 Jun 2003 00:36:33 +0200
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: severe FS corruption w/ reiserfs and 2.5.72-bk3
References: <3EF4C0CC.6090100@folkwang-hochschule.de> <200306212021.h5LKLGdv004822@car.linuxhacker.ru>
In-Reply-To: <200306212021.h5LKLGdv004822@car.linuxhacker.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello oleg !

thanks for your quick reply!

Oleg Drokin wrote:
> Joern Nettingsmeier <nettings@folkwang-hochschule.de> wrote:
> 
> JN> i just completely and utterly trashed my filesystems with 2.5.72-bk2 and 
> JN> reiserfs. there are metric shitloads of errors on journal replay and i 
> JN> end up in repair mode. did a couple of --rebuild-tree's, but new errors 
> JN> cropped up after every reboot.
> JN> happens both on scsi and ide drives and ate almost all of my machine...
> 
> Hm. Can I ask for your kernel config, and kernel logs (if possible),
> reiserfsck /dev/device -l /somewhere/device.log , and send those logs to
> me too.

sorry, i can't really get anything in and out of that box.
i've been able to extract some parts of the fsck log, they look like this:

vpf-10680: The file [2406 26400] has the wrong block count in the 
StatData (8), should be (1)
vpf-10680: The file [2406 49744] has the wrong block count in the 
StatData (8), should be (1)
vpf-10680: The file [2406 30103] has the wrong block count in the 
StatData (8), should be (1)
vpf-10680: The file [2406 47443] has the wrong block count in the 
StatData (8), should be (1)
vpf-10680: The file [2406 55026] has the wrong block count in the 
StatData (8), should be (1)
vpf-10680: The file [2406 28681] has the wrong block count in the 
StatData (8), should be (1)
vpf-10680: The file [2406 21611] has the wrong block count in the 
StatData (8), should be (1)
vpf-10680: The file [2406 21610] has the wrong block count in the 
StatData (8), should be (1)
vpf-10680: The file [10 33567] has the wrong block count in the StatData 
(8), should be (1)
vpf-10680: The file [10 33568] has the wrong block count in the StatData 
(8), should be (1)

it tells me it can fix it with the --fixable option, done that a couple 
of times, new errors after that.

i can't send you my kernel config, because the kernel tree was one of 
the first things that got eaten.... the entire tree ended up in 
lost+found all in pieces. unfortunately i deleted it. :(

it's an smp box with 2 p3s, intel bx chipset, aic7xxx scsi, ide and scsi 
compiled into the kernel, reiserfs too. tagged queuing enabled, ignore 
word validation bits enabled, use dma by default enabled. it has 3 scsi 
discs, 2 of which are striped, and one ide which has one huge partition 
of 175G. the scsi discs are 4, 9 and 9 gig.
no atapi devices, only a scsi cdrom and a burner.

the box is so f&%$ed up, when i try to cat a logfile i get:
vpf-10640: the on-disk and the correct bitmaps differs.
nothing else.
:(


> JN> unfortunately i did a number of things at once: upgrade the kernel from 
> JN> .72 (which has worked for me quite well), add an ide drive (i didn't 
> JN> have ide in my kernel before, and geez! is that module code broken :)) 
> JN> and shuffle partitions around. which makes the problem hard to pinpoint.
> 
> Not sure what bk3 is for, I have yesterday's bk snapshot and it works for me,
> I seem to be unable to reach bkbits.net for today.
> 
> JN> if anyone wants me to do some forensics on the machine, speak up. 
> JN> otherwise i'll swipe it clean and start over from scratch.
> 
> I wonder if you can create clean fs, copy some stuff there with 2.5.72-mm2
> and see what happens?

/var is totally FUBAR, the system won't boot into my fallback kernel. i 
don't have a second machine around to compile another kernel on... sorry.

i might be able to put the ide disk into another box tomorrow and try 
another reiserfsck with proper logging, but i have no place to check the 
scsi disks. i'll keep you posted when i get it done.

best,

jörn





-- 
All Members shall refrain in their international relations from
the threat or use of force against the territorial integrity or
political independence of any state, or in any other manner
inconsistent with the Purposes of the United Nations.
	-- Charter of the United Nations, Article 2.4


Jörn Nettingsmeier
Kurfürstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)




