Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287521AbRLaOId>; Mon, 31 Dec 2001 09:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287519AbRLaOIY>; Mon, 31 Dec 2001 09:08:24 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47368
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287521AbRLaOID>; Mon, 31 Dec 2001 09:08:03 -0500
Date: Mon, 31 Dec 2001 06:05:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org
Subject: ATA RAID-0 FYI-Did the Impossible.
Message-ID: <Pine.LNX.4.10.10112310558030.4280-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


TIOBENCH

No size specified, using 1792 MB
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/sec

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     1792   4096    1  153.6 98.1% 0.897 0.91% 85.59 51.2% 3.399 1.95%
   .     1792   4096    2  104.7 67.8% 1.080 1.00% 79.63 58.4% 3.437 3.29%
   .     1792   4096    4  91.57 61.2% 1.292 1.24% 76.45 59.3% 3.471 3.40%
   .     1792   4096    8  83.55 57.3% 1.480 1.39% 73.80 59.2% 3.455 3.26%


File './Bonnie.1089', size: 1073741824, volumes: 1
Writing with putc()...  done:   9854 kB/s 100.0 %CPU
Rewriting...            done:  65537 kB/s  52.2 %CPU
Writing intelligently...done: 109124 kB/s  51.0 %CPU
Reading with getc()...  done:   9821 kB/s  99.9 %CPU
Reading intelligently...done: 167240 kB/s  97.6 %CPU
Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
              ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
       1*1024  9854 100.0 109124 51.0 65537 52.2  9821 99.9 167240 97.6 1504.4
6.4

hdparm -t /dev/md0

/dev/md0:
 Timing buffered disk reads:  64 MB in  0.47 seconds =136.17 MB/sec


hde: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
hdg: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
hdi: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
hdk: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)

/etc/raidtab

raiddev /dev/md0
        raid-level              0
        nr-raid-disks           4
        persistent-superblock   0
        chunk-size              <snipped>

        device                  /dev/hd<snipped>1
        raid-disk               0
        device                  /dev/hd<snipped>1
        raid-disk               1
        device                  /dev/hd<snipped>1
        raid-disk               2
        device                  /dev/hd<snipped>1
        raid-disk               3


If you want your system to have this kind of performance, that raise hell
to get the patches adopted into the main kernel.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

