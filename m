Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264506AbSIQTXg>; Tue, 17 Sep 2002 15:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264500AbSIQTXg>; Tue, 17 Sep 2002 15:23:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33542 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264506AbSIQTXe>; Tue, 17 Sep 2002 15:23:34 -0400
Date: Tue, 17 Sep 2002 15:41:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: lkml <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.4.20-pre7: disk statistics still buggy
In-Reply-To: <am7tv2$9d4$1@ncc1701.cistron.net>
Message-ID: <Pine.LNX.4.44.0209171541350.531-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph,

Can you look into that for me please?

Thanks

On Tue, 17 Sep 2002, Miquel van Smoorenburg wrote:

> It appears that this issue has been brought to attention earlier-
> in Juli. http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.1/0323.html
>
> "running" and "aveq" make no sense. They are negative, or very large.
>
> $ uname -a
> Linux news3 2.4.20-pre7 #3 Mon Sep 16 22:24:30 CEST 2002 i686 unknown
>
> $ cat /proc/partitions
> major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq
>
>    8     0    4455211 sda 9468 17946 168570 84970 58539 138667 1318468 2299240 0 424760 2387770
>    8     1     388988 sda1 1791 6471 16524 8770 7176 36164 86980 630690 0 121450 642610
>    8     2    1027185 sda2 2652 3510 48930 19510 5192 13422 149120 483330 0 146790 503250
>    8     3    1027185 sda3 986 6318 58066 23860 44741 81072 1006808 806890 0 326530 830750
>    8     4          1 sda4 0 0 0 0 0 0 0 0 0 0 0
>    8     5    1027154 sda5 1 0 8 10 0 0 0 0 0 10 10
>    8     6     983444 sda6 4035 1638 45018 32780 1430 8009 75560 378330 0 66560 411110
>    8    16   17921835 sdb 41833 5476 378082 695070 1538817 743210 18273672 124155110 0 5687460 124877060
>    8    17   17921008 sdb1 41832 5473 378074 695050 1538817 743210 18273672 124155110 0 5687440 124877040
>    8    32    4455211 sdc 1 3 8 10 0 0 0 0 0 10 10
>    8    33    4454018 sdc1 0 0 0 0 0 0 0 0 0 0 0
>   34     0  160086528 hdg 130366 872 262476 30290 5651 282658 576618 1264780 -2 78008350 -154744510
>   34     1   10241406 hdg1 53082 150 106464 10690 1519 77083 157204 227620 0 35260 238310
>   34     2    1028160 hdg2 7322 152 14948 4460 354 9756 20220 65410 0 27060 69870
>   34     3  148810095 hdg3 69961 567 141056 15130 3778 195819 399194 971750 0 95020 986880
>   33     0  160086528 hde 130667 907 263148 26730 5724 286473 584394 978180 -2 78010550 -155034670
>   33     1   10241406 hde1 53238 154 106784 9760 1530 77462 157984 176760 0 34360 186520
>   33     2    1028160 hde2 7340 140 14960 3010 364 9785 20298 45160 0 24770 48170
>   33     3  148810095 hde3 70088 610 141396 13950 3830 199226 406112 756260 0 88690 770210
>   22     0  160086528 hdc 131752 65445 394394 31250 5652 281531 574366 877100 -3 78008160 -233020570
>   22     1   10241406 hdc1 54333 64788 238242 14880 1531 77367 157796 134490 0 35320 149370
>   22     2    1028160 hdc2 7314 147 14922 3000 368 9734 20204 48880 0 24350 51880
>   22     3  148810095 hdc3 70104 507 141222 13360 3753 194430 396366 693730 0 86780 707090
>    3     0  160086528 hda 131753 66451 396408 37550 5706 285265 581942 897340 -3 78006620 -233002320
>    3     1   10241406 hda1 54329 64788 238234 14830 1524 77489 158026 154110 0 35810 168940
>    3     2    1028160 hda2 7363 142 15010 3640 364 9770 20268 47870 0 25190 51510
>    3     3  148810095 hda3 70060 1518 143156 19070 3818 198006 403648 695360 0 92700 714430


