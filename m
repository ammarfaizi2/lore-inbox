Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283244AbRK2OOM>; Thu, 29 Nov 2001 09:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283245AbRK2OOC>; Thu, 29 Nov 2001 09:14:02 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:21266 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S283244AbRK2ONu>; Thu, 29 Nov 2001 09:13:50 -0500
Message-ID: <3C066C57.7DA3CF5E@namesys.com>
Date: Thu, 29 Nov 2001 17:11:51 +0000
From: Edward Shushkin <edward@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac8 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Rene Rebe <rene.rebe@gmx.net>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] ReiserFS on RAID5 Linux-2.4 - speed problem
In-Reply-To: <20011129022247.43615e45.rene.rebe@gmx.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe wrote:
> 
> (Repost - since my first mail has still not arrived ...)
> 
> Hi - I need some speed tips for using ReiserFS on an RAID5 Linux-soft-raid device.
> 
> Config: AMD K6-2 350
>         3x IBM 40GB IDE discs (connected as master each to a single IDE channel)
>         Linux-2.4.1x (currently .16)
>         the discs are combined via Linux-software-RAID5
> 
> I run ReiserFS on a RAID5 (of 3 IDE disks) using the latest 2.4.(e.g.16)
> kernel for weeks. It works well except that is is painfully slow. In todays tests
> I got arround 3MB/s from ReiserFS (dd if=/home/database/some-video.avi ...) - wich
> matches exatly what I get over NFS for normal development usage, too. The IDE or
> RAID setup doesn't seem to be a problem because I get 33MB/s when I read the
> /dev/md/0 directly (dd if=/dev/md/0 ...)!

Thats odd!
I don't have three various ide-controllers to reproduce your configuration, 
but for the raid5 of 3 various scsi disks i have that the times of dd readings for 
if= /dev/sda, /dev/md0, /mnt/file_on_reiserfs_on_md0 relates approximately as 
1.5 : 1 : 1   
So the performance doesn't decrease..
What is about your speed for (dd if=/dev/hdx...)??
Can you measure this for ext2 on md0?

Thanks,
Edward.
