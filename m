Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSJWUAU>; Wed, 23 Oct 2002 16:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265176AbSJWUAU>; Wed, 23 Oct 2002 16:00:20 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:9940 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S265171AbSJWUAS>; Wed, 23 Oct 2002 16:00:18 -0400
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared
	forvarious  fs.
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3DB6FF24.9B50A7C0@digeo.com>
References: <1035402133.13140.251.camel@spc9.esa.lanl.gov> 
	<3DB6FF24.9B50A7C0@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Oct 2002 14:05:31 -0600
Message-Id: <1035403531.13083.261.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 13:57, Andrew Morton wrote:
> Steven Cole wrote:
> > 
> > ext3
> > tar zxf linux-2.5.44.tar.gz     2.5.44-mm3      2.5.44-ac2
> > user                            4.42            4.39
> > system                          4.09            4.05
> > elapsed                         00:53.17        00:34.05
> > % CPU                           16              24
> 
> The smaller fifo_batch setting hurts when there are competing
> reads and writes on the same disk.
> 
> > reiserfs
> > xfs
> > jfs
> 
> ext2?
OK, if ext2 would be of interest. 
Here is the result of df -T:

Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda1     ext3    236M   77M  148M  35% /
/dev/hda9     ext3     20G  8.0G   12G  41% /home
/dev/hda11     jfs    3.9G  1.8G  2.2G  46% /share_jfs
/dev/hda10
          reiserfs    4.0G   73M  3.9G   2% /share_reiser
/dev/hda12     xfs    4.8G  290M  4.5G   6% /share_xfs
/dev/hda8     ext3    236M  4.7M  219M   3% /tmp
/dev/hda6     ext3    2.9G  1.3G  1.5G  47% /usr
/dev/hda7     ext3    479M   63M  392M  14% /var

I'll do the test on /tmp remounted as ext2.
Back in a while,

Steven

