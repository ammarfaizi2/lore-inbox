Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbUJaNQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbUJaNQs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 08:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUJaNQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 08:16:47 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:51432 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261621AbUJaNPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 08:15:12 -0500
Date: Sun, 31 Oct 2004 15:15:06 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac5
Message-ID: <20041031131506.GB7501@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1099060831.13098.33.camel@localhost.localdomain> <20041030090308.GA6060@m.safari.iki.fi> <20041030110414.GA3130@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030110414.GA3130@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 01:04:15PM +0200, Vojtech Pavlik wrote:

> No, the patch from me (included in -ac) is completely bogus. The correct
> patch is attached.

I made little accident: /mnt/usb was mounted but I had removed the
CF from the USB CF-reader device... 
then I ran ls, but to my surprise dir listing contained data from a file
I had just written to /tmp.
Where did them get pulled from? 

Oct 31 14:44:43 safari kernel: Current sdb: sense key No Sense
Oct 31 14:44:43 safari last message repeated 32 times
Oct 31 14:44:43 safari kernel: FAT: Filesystem panic (dev sdb1)
Oct 31 14:44:43 safari kernel:     fat_get_cluster: invalid cluster chain (i_pos 0)
Oct 31 14:44:43 safari kernel:     File system has been set read-only
Oct 31 14:44:43 safari kernel: Current sdb: sense key No Sense
Oct 31 14:44:43 safari kernel: FAT: Filesystem panic (dev sdb1)
Oct 31 14:44:43 safari kernel:     fat_get_cluster: invalid cluster chain (i_pos 0)
Oct 31 14:44:43 safari kernel: Current sdb: sense key No Sense
Oct 31 14:44:43 safari kernel: FAT: Filesystem panic (dev sdb1)
Oct 31 14:44:43 safari kernel:     fat_get_cluster: invalid cluster chain (i_pos 0)
Oct 31 14:44:43 safari kernel: Current sdb: sense key No Sense
Oct 31 14:44:44 safari kernel: FAT: Filesystem panic (dev sdb1)
Oct 31 14:44:44 safari kernel:     fat_get_cluster: detected the cluster chain loop (i_pos 0)
Oct 31 14:44:44 safari kernel: Current sdb: sense key No Sense
...

0 [/mnt/usb]# l
total 63353084
-rwxr-xr-x   1 root root  812935539 1985-01-16 03:01:00.000000000 +0200      0
-rwxr-xr-x   1 root root  812935539 1985-01-16 03:01:00.000000000 +0200      0
-rwxr-xr-x   1 root root  812935539 1985-01-16 03:01:00.000000000 +0200      0
-rwxr-xr-x   1 root root  812935539 1985-01-16 03:01:00.000000000 +0200      0
-rwxr-xr-x   1 root root  812935539 1985-01-16 03:01:00.000000000 +0200      0
-rwxr-xr-x   1 root root  812935539 1985-01-16 03:01:00.000000000 +0200      0
-rwxr-xr-x   1 root root  812935539 1985-01-16 03:01:00.000000000 +0200      0
-rwxr-xr-x   1 root root  812935539 1985-01-16 03:01:00.000000000 +0200      0
?---------   ? ?    ?             ?                                   ?     0 19.169
?---------   ? ?    ?             ?                                   ?     0 19.169
?---------   ? ?    ?             ?                                   ?     0 19.169
?---------   ? ?    ?             ?                                   ?     0 19.169
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200     0.  0
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200     0.  0
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200     0.  0
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200     0.  0
-rwxr-xr-x   1 root root  538976288 1995-12-31 03:01:00.000000000 +0200     0. 0
-rwxr-xr-x   1 root root  538976288 1995-12-31 03:01:00.000000000 +0200     0. 0
-rwxr-xr-x   1 root root  538976288 1995-12-31 03:01:00.000000000 +0200     0. 0
-rwxr-xr-x   1 root root  538976288 1995-12-31 03:01:00.000000000 +0200     0. 0
?---------   ? ?    ?             ?                                   ?    0
?---------   ? ?    ?             ?                                   ?    0
?---------   ? ?    ?             ?                                   ?    0
?---------   ? ?    ?             ?                                   ?    0
-rwxr-xr-x   1 root root  540024864 1995-12-31 03:01:00.000000000 +0200    0.0
-rwxr-xr-x   1 root root  540024864 1995-12-31 03:01:00.000000000 +0200    0.0
-rwxr-xr-x   1 root root  540024864 1995-12-31 03:01:00.000000000 +0200    0.0
-rwxr-xr-x   1 root root  540024864 1995-12-31 03:01:00.000000000 +0200    0.0
-rwxr-xr-x   1 root root  540024864 1995-12-31 03:01:00.000000000 +0200    0.0
-rwxr-xr-x   1 root root  540024864 1995-12-31 03:01:00.000000000 +0200    0.0
-rwxr-xr-x   1 root root  540024864 1995-12-31 03:01:00.000000000 +0200    0.0
-rwxr-xr-x   1 root root  540024864 1995-12-31 03:01:00.000000000 +0200    0.0
-rwxr-xr-x   1 root root 1762275360 1995-12-31 03:01:00.000000000 +0200    12.  0
-rwxr-xr-x   1 root root 1762275360 1995-12-31 03:01:00.000000000 +0200    12.  0
-rwxr-xr-x   1 root root 1762275360 1995-12-31 03:01:00.000000000 +0200    12.  0
-rwxr-xr-x   1 root root 1762275360 1995-12-31 03:01:00.000000000 +0200    12.  0
?---------   ? ?    ?             ?                                   ?  |  tran.smi
?---------   ? ?    ?             ?                                   ?  |  tran.smi
?---------   ? ?    ?             ?                                   ?  |  tran.smi
?---------   ? ?    ?             ?                                   ?  |  tran.smi
drwxr-xr-x   3 root root      16384 1970-01-01 02:00:00.000000000 +0200 .
drwxr-xr-x  14 root root        336 2004-10-30 11:18:41.604136432 +0300 ..
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200 .0
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200 .0
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200 .0
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200 .0
?---------   ? ?    ?             ?                                   ? .149.+rb.lsm
-rwxr-xr-x   1 root root 1970105711 1902-02-06 04:54:50.000000000 +0139 .153.119..+r
-rwxr-xr-x   1 root root 1970105711 1902-02-06 04:54:50.000000000 +0139 .254.151..+r
?---------   ? ?    ?             ?                                   ? / as1663.1 b
-rwxr-xr-x   1 root root          0 1979-12-31 23:00:00.000000000 +0200 0.0
-rwxr-xr-x   1 root root          0 1979-12-31 23:00:00.000000000 +0200 0.0
-rwxr-xr-x   1 root root          0 1979-12-31 23:00:00.000000000 +0200 0.0
-rwxr-xr-x   1 root root          0 1979-12-31 23:00:00.000000000 +0200 0.0
-r-xr-xr-x   1 root root  778400629 2002-11-12 12:11:02.000000000 +0200 1 banned., s
-rwxr-xr-x   1 root root 1650535788 2034-09-15 05:57:52.000000000 +0300 16631 ba.nne
-rwxr-xr-x   1 root root 1769234787 1902-10-08 05:55:06.000000000 +0139 48.+rbls.mtp
?---------   ? ?    ?             ?                                   ? 53.118.+.rbl
?---------   ? ?    ?             ?                                   ? 54.150.+.rbl
-rwxr-xr-x   1 root root 1937072737 2032-11-01 12:41:30.000000000 +0200 631 bann.ed,
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200 :.0
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200 :.0
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200 :.0
-rwxr-xr-x   1 root root  807411744 1995-12-31 03:01:00.000000000 +0200 :.0
?---------   ? ?    ?             ?                                   ? ://mail-.abu
?---------   ? ?    ?             ?                                   ? ://mail-.abu
?---------   ? ?    ?             ?                                   ? abuse.or.g/r
-r-xr-xr-x   1 root root  838860800 1980-01-01 00:32:00.000000000 +0200 acy.html.#by
-r-xr-xr-x   1 root root  838860800 1980-01-01 00:32:00.000000000 +0200 acy.html.#by
?---------   ? ?    ?             ?                                   ? ail-abus.e.o
-rwxr-xr-x   1 root root 1919888997 2029-03-01 04:43:24.000000000 +0200 banned,.see
?---------   ? ?    ?             ?                                   ? candidac.y.h
?---------   ? ?    ?             ?                                   ? cations./ a
?---------   ? ?    ?             ?                                   ? cations./ a
?---------   ? ?    ?             ?                                   ? cogent c.omm
?---------   ? ?    ?             ?                                   ? e.org/rb.l/c
?---------   ? ?    ?             ?                                   ? ed, see.htt
?---------   ? ?    ?             ?                                   ? g/rbl/ca.ndi
-r-xr-xr-x   1 root root  825112368 1980-01-01 12:48:00.000000000 +0200 html#bya.sso
-r-xr-xr-x   1 root root  825112368 1980-01-01 12:48:00.000000000 +0200 html#bya.sso
-rwxr-xr-x   1 root root      28160 1985-12-31 12:51:30.000000000 +0200 idacy.ht.ml#
-rwxr-xr-x   1 root root      28160 1985-12-31 12:51:30.000000000 +0200 idacy.ht.ml#
-r-xr-xr-x   1 root root  538976288 1995-12-31 03:01:00.000000000 +0200 inter-|.  r
-r-xr-xr-x   1 root root  538976288 1995-12-31 03:01:00.000000000 +0200 inter-|.  r
-r-xr-xr-x   1 root root  538976288 1995-12-31 03:01:00.000000000 +0200 inter-|.  r
-r-xr-xr-x   1 root root  538976288 1995-12-31 03:01:00.000000000 +0200 inter-|.  r
?---------   ? ?    ?             ?                                   ? kets err.s d
?---------   ? ?    ?             ?                                   ? kets err.s d
?---------   ? ?    ?             ?                                   ? kets err.s d
?---------   ? ?    ?             ?                                   ? kets err.s d
-r-xr-xr-x   1 root root  539959411 2032-11-20 11:11:06.000000000 +0200 lsmtpd=-.cog
...

I didn't try to read the files...  but it might have been interesting :p
After I unmounted /mnt/usb I didn't notice anything odd (like Oopses).

-- 
