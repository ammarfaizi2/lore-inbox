Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263264AbREWVgW>; Wed, 23 May 2001 17:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263265AbREWVgN>; Wed, 23 May 2001 17:36:13 -0400
Received: from cr845378-a.rchrd1.on.wave.home.com ([24.157.76.7]:25360 "EHLO
	mielke.cc") by vger.kernel.org with ESMTP id <S263264AbREWVf7>;
	Wed, 23 May 2001 17:35:59 -0400
Date: Wed, 23 May 2001 17:34:22 -0400 (EDT)
From: Dave Mielke <dave@mielke.cc>
To: Guest section DW <dwguest@win.tue.nl>
cc: "Linux Kernel (mailing list)" <linux-kernel@vger.kernel.org>
Subject: Re: nfs mount by label not working.
In-Reply-To: <20010523231213.A11564@win.tue.nl>
Message-ID: <Pine.LNX.4.30.0105231728430.995-100000@dave.private.mielke.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[quoted lines by Guest section DW on May 23, 2001, at 23:12]

>(i) Your version is ancient, but it might be good enough.

    mount -V
    mount: mount-2.9u

>(ii) Labels as used in "mount -L label" are ext2 labels only
>(well, xfs also works if I recall correctly)

I set the labels with e2label.

>(iii) I forgot to implement a crystal ball, so mount is not
>very good in divining [yes, that is related to the old
>indoeuropean words for god] where the devices are with a
>given label. However, it will try everything mentioned in /proc/partitions.
>In your case that is a very short list.

I presume that you're assuming that my /proc/partitions is empty because its
size shows as 0:

    ls -l /proc/partitions
    -r--r--r--   1 root     root            0 May 23 17:31 /proc/partitions

It does, however, have several lines in it.

    cat /proc/partitions
    major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq

       3     0    6297480 hda      119 141 520 1790 0 0 0 0 0 1180 1790
       3     1    1534176 hda1     0 0 0 0 0 0 0 0 0 0 0
       3     2          1 hda2     1 0 2 20 0 0 0 0 0 20 20
       3     3      96358 hda3     0 0 0 0 0 0 0 0 0 0 0
       3     4    1534207 hda4     0 0 0 0 0 0 0 0 0 0 0
       3     5    1052226 hda5     0 0 0 0 0 0 0 0 0 0 0
       3     6    1052226 hda6     1 0 2 10 0 0 0 0 0 10 10
       3     7     208813 hda7     1 0 2 20 0 0 0 0 0 20 20
       3     8     819283 hda8     115 141 512 1730 0 0 0 0 0 1120 1730
      22    64    6297480 hdd      29218 300606 783536 808790 42553 89013 382004 2952210 0 599630 3763620
      22    65     522081 hdd1     0 0 0 0 0 0 0 0 0 0 0
      22    66          1 hdd2     1 0 2 10 0 0 0 0 0 10 10
      22    69      80293 hdd5     0 0 0 0 0 0 0 0 0 0 0
      22    70     401593 hdd6     161 30 382 2570 55 6 122 10590 0 7470 13160
      22    71    1004031 hdd7     3000 54712 115428 76420 213 34 520 25520 0 60270 101940
      22    72     200781 hdd8     1 0 2 20 0 0 0 0 0 20 20
      22    73     120456 hdd9     1 0 2 10 0 0 0 0 0 10 10
      22    74     883543 hdd10    4320 35159 78992 101950 8704 20252 59014 838820 0 149590 943220
      22    75     128488 hdd11    2943 17697 165114 91090 2662 16775 155496 212510 0 143130 303600
      22    76     208813 hdd12    1 0 2 10 0 0 0 0 0 10 10
      22    77    1542208 hdd13    17758 192335 420202 515170 16930 5075 44786 1281640 0 363310 1796970
      22    78     514048 hdd14    1031 673 3408 21500 13989 46871 122066 583130 0 166600 604640

Might my problem be that the kernel is showing its size as 0 even though it
actually does contain data?

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.

