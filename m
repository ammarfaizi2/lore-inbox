Return-Path: <linux-kernel-owner+w=401wt.eu-S932247AbXARM1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbXARM1l (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 07:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbXARM1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 07:27:41 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:60259 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbXARM1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 07:27:40 -0500
Subject: Re: PROBLEM: writting files > 100 MB in FAT32
From: Kasper Sandberg <lkml@metanurb.dk>
To: condor@stz-bg.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <48247.82.103.71.18.1169112129.squirrel@mail.stz-bg.com>
References: <48247.82.103.71.18.1169112129.squirrel@mail.stz-bg.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 13:27:16 +0100
Message-Id: <1169123236.12968.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 11:22 +0200, Condor wrote:
> Hello,
> 
> [1.] Files if > 100 MB saving in USB memory stick 4 GB with FAT32. While
> saving all files is broken.
im sorry, i do not understand this.

you are saying that if you copy files larger than 100mb into drive, all
files die?

> [2.] I have USB memory stick A-DATA 4 GB with FAT32. When i trying to save
> files in my USB and files is > of 100 MB, all files that i save is broken.
> I put my USB in my laptop and mount it as: mount /dev/sda1 /mnt/usb-win
> While i mount it, i got in my local disk and copy one file that is 520 MB.
> The file is copying very slow (10 min). and after i see again my console i
> wait light to my usb is off and i unmount it as: umount /mnt/usb-win
> I get my USB stick and when i return to home i trying to copy file from my
> USB to my windows and linux. Both OS unable to read file.
> After some tryings i format my USB in FAT16 and now every thing is work
> fine. I copy files to my USB and back to my hard drive and all files work
> fine.

okay, i think thats what you are saying, could you please try to run
dosfsck on it so we can see 100% whats wrong?

also, try to do this:
mount, copy, run command 'sync', unmount, pull out, and see if it works.

finally, one more question. you said it does not work when you take it
home, can you try this: mount, copy, unmount, mount, check to see if
file works.


> [3.] lsmod
> # lsmod
<snip>
> nvidia               4709172  22
ohh, tainted ;P naughty. Though i dont think this affects vfat.
<snip>

> Regards,
> Condor
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

