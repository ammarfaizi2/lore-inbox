Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130257AbRB1QYW>; Wed, 28 Feb 2001 11:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130253AbRB1QYM>; Wed, 28 Feb 2001 11:24:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33552 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130257AbRB1QX7>;
	Wed, 28 Feb 2001 11:23:59 -0500
Date: Wed, 28 Feb 2001 17:23:45 +0100
From: Jens Axboe <axboe@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Holluby István <holluby@interware.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: mke2fs /dev/loop0
Message-ID: <20010228172345.K21518@suse.de>
In-Reply-To: <20010228164151.H21518@suse.de> <Pine.LNX.3.95.1010228111048.5030A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1010228111048.5030A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Feb 28, 2001 at 11:16:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28 2001, Richard B. Johnson wrote:
> Wrong. The report showed a response to a command. Nothing was reported
> to have been mounted through the loop device. Instead, the raw command
> `mke2fs /dev/loop0` was reported. Performing such a command on early
> linux versions resulted in this:
> 
> Script started on Wed Feb 28 11:10:11 2001
> mke2fs /dev/loop0
> mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> mke2fs: Device size reported to be zero.  Invalid partition specified, or
> 	partition table wasn't reread after running fdisk, due to
> 	a modified partition being busy and in use.  You may need to reboot
> 	to re-read your partition table.
> 
> # exit
> exit

This was the report:

	[on mke2fs]
	This command hangs my system. It works for a 100K file, but it
	hangs my system, if the file is 470M. It does not matter, if the
	disk is SCSI or ide.

so you pretty much have to assume that he's losetup the files first.
How else could he state that it works for a 100k file, but not for
a 470m one?

BLKGETSIZE will return the device size, nothing unexpected here.

-- 
Jens Axboe

