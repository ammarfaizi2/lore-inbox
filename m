Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTEFPGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTEFPGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:06:45 -0400
Received: from mail0.ewetel.de ([212.6.122.10]:42704 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S263792AbTEFPGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:06:43 -0400
Date: Tue, 6 May 2003 17:19:08 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <20030506140751.GA25817@suse.de>
Message-ID: <Pine.LNX.4.44.0305061715150.965-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Jens Axboe wrote:

> It barfs at a lot of commands, not surprisingly. ide-cd really has no
> concept of devices other than cd/dvd.

I'm not complaining about those messages. ;)

> You need to patch cdrom.c as well:
> 
> 	if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
> 		return -EROFS;
> 

Simply removing that test doesn't get me working write support,
I still get:

# mount -t ext2 /dev/hde /mnt/mo
mount: block device /dev/hde is write-protected, mounting read-only

The disk is not write-protected, I checked.

>> What can I do to help get this drive supported under 2.5/ide-cd?
> I'm tempted to say ide-scsi + sd, but that goes against my principles...
> It shouldn't be too much work to make ide-cd work gracefully.

Well, I'm not familiar with the code at all, so I don't know where
to look.

-- 
Ciao,
Pascal

