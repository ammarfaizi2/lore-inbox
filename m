Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTHaKfI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 06:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbTHaKfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 06:35:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53999 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261623AbTHaKfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 06:35:01 -0400
Date: Sun, 31 Aug 2003 12:34:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ghugh Song <ghugh@kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx_osm.c compilation failure in linux-2.4.22
Message-ID: <20030831103452.GS7038@fs.tum.de>
References: <20030828131615.A83F17497B@bellini.kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828131615.A83F17497B@bellini.kjist.ac.kr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 10:16:15PM +0900, ghugh Song wrote:
> 
> Compile failure as follows:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
> -mpreferred-stack-boundary=2 -march=pentium4
> -I/usr/src/linux-2.4.22/drivers/scsi -Werror -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=aic7xxx_osm  -c -o aic7xxx_osm.o aic7xxx_osm.c
> In file included from /usr/src/linux-2.4.22/include/linux/blk.h:4,
>                  from aic7xxx_osm.h:63,
>                  from aic7xxx_osm.c:122:
> /usr/src/linux-2.4.22/include/linux/blkdev.h: In function `blk_queue_bounce':
> /usr/src/linux-2.4.22/include/linux/blkdev.h:194: warning: comparison between
> signed and unsigned
> /usr/src/linux-2.4.22/include/linux/blkdev.h: In function
> `blk_finished_sectors':
> /usr/src/linux-2.4.22/include/linux/blkdev.h:335: warning: comparison between
> signed and unsigned
> aic7xxx_osm.c: In function `ahc_linux_setup_tag_info_global':
> aic7xxx_osm.c:1610: warning: comparison between signed and unsigned
>...
> make[4]: *** [aic7xxx_osm.o] Error 1
> make[4]: Leaving directory `/usr/src/linux-2.4.22/drivers/scsi/aic7xxx'
> make[3]: *** [first_rule] Error 2
> make[3]: Leaving directory `/usr/src/linux-2.4.22/drivers/scsi/aic7xxx'
> make[2]: *** [_subdir_aic7xxx] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.22/drivers/scsi'
> make[1]: *** [_subdir_scsi] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.22/drivers'
> make: *** [_dir_drivers] Error 2
> 
> 
> =======================================================
> 
> 
> However, I can't find the actual error message.  Strange.
>...

This driver is compiled with -Werror turning ever warning into an error.

Although you say you are using "linux-2.4.22" it seems you aren't using 
the ftp.kernel.org 2.4.22 but a modified version (the real 2.4.22 
doesn't know about -march=pentium4).

Perhaps your vendor of this modified kernel source introduced a bug 
causing this compile error?
 
> Regards,
> 
> Hugh

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

