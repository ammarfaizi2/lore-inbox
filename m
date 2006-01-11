Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWAKLlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWAKLlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWAKLlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:41:11 -0500
Received: from tornado.reub.net ([202.89.145.182]:2977 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932135AbWAKLlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:41:10 -0500
Message-ID: <43C4EEA4.3050502@reub.net>
Date: Thu, 12 Jan 2006 00:40:20 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060110)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
References: <20060110104759.GA30546@elte.hu> <43C3A85A.7000003@reub.net> <20060110044240.3d3aa456.akpm@osdl.org> <20060110131618.GA27123@elte.hu> <17348.34472.105452.831193@cse.unsw.edu.au> <43C4947C.1040703@reub.net> <20060110213001.265a6153.akpm@osdl.org> <20060110213056.58f5e806.akpm@osdl.org> <43C4E2BE.6050800@reub.net> <20060111030529.0bc03e0a.akpm@osdl.org> <20060111111313.GD3389@suse.de>
In-Reply-To: <20060111111313.GD3389@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2006 12:13 a.m., Jens Axboe wrote:
> On Wed, Jan 11 2006, Andrew Morton wrote:
>> Neil thinks that an IO got lost.  In the git2->git3 diff we have:
>>
>>  b/drivers/scsi/Kconfig                         |   10 
>>  b/drivers/scsi/ahci.c                          |    1 
>>  b/drivers/scsi/ata_piix.c                      |    5 
>>  b/drivers/scsi/libata-core.c                   |  145 +
>>  b/drivers/scsi/libata-scsi.c                   |   48 
>>  b/drivers/scsi/libata.h                        |    4 
>>  b/drivers/scsi/sata_mv.c                       |    1 
>>  b/drivers/scsi/sata_promise.c                  |    1 
>>  b/drivers/scsi/sata_sil.c                      |    1 
>>  b/drivers/scsi/sata_sil24.c                    |    1 
>>  b/drivers/scsi/sata_sx4.c                      |    1 
>>  b/drivers/scsi/scsi_lib.c                      |   50 
>>  b/drivers/scsi/scsi_sysfs.c                    |   31 
>>  b/drivers/scsi/sd.c                            |   85 -
>>  b/fs/bio.c                                     |   26 
>>
>> Jens, Jeff: were any of those changes added in the final day or two, not
>> included in the trees which I pull?
> 
> Reuben, do you have any barrier= options in your fstab for any reiser
> file system?

None whatsoever:

/dev/md0                /                       reiserfs defaults        0 0
none                    /dev/pts                devpts   gid=5,mode=620  0 0
none                    /dev/shm                tmpfs    defaults        0 0
none                    /proc                   proc     defaults        0 0
sysfs                   /sys                    sysfs    defaults        0 0
/dev/sda1               /boot                   ext3     defaults        1 2
#/dev/sdb1              /boot-2                 ext3     defaults        1 2
/dev/md1                /home                   reiserfs defaults        0 0
/dev/md2                /var                    reiserfs defaults        0 0
/dev/md3                /var/www/cgi-bin        reiserfs defaults        0 0
/dev/md4                /tmp                    reiserfs defaults        0 0
/dev/md5                /backup                 reiserfs defaults        0 0
/dev/sda8               /var/spool/squid-1      reiserfs noatime,notail  0 0
/dev/sdb8               /var/spool/squid-2      reiserfs noatime,notail  0 0
/dev/sda9               swap                    swap     defaults        0 0
/dev/sdb9               swap                    swap     defaults        0 0
/dev/sdc1               /store                  reiserfs defaults        0 0
/dev/shm                /var/spool/amavisd/tmp  tmpfs 
defaults,size=25m,mode=700,uid=508,gid=509, 0 0
/dev/fd0                /media/floppy           auto 
pamconsole,exec,noauto,managed 0 0

reuben

