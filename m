Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281242AbRKUBIF>; Tue, 20 Nov 2001 20:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281554AbRKUBHp>; Tue, 20 Nov 2001 20:07:45 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:27821 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S281242AbRKUBHh>; Tue, 20 Nov 2001 20:07:37 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: [REISERFS TESTING] new patches on ftp.namesys.com: 2.4.15-pre7
Date: Wed, 21 Nov 2001 02:06:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: ReiserFS List <reiserfs-list@Namesys.COM>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011121010744Z281242-17408+16783@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 21. November 2001 01:47 schrieb Dieter Nützel:
> Am Mittwoch, 21. November 2001 01:07 schrieb Dieter Nützel:
> > Sorry Nikita,
> >
> > but kernel 2.4.15-pre7 + preempt + ReiserFS A-N do _NOT_ boot for me.
> > I've tried it with "old" and "new" (current) N-inode-attrs.patch. But
> > that doesn't matter.
> >
> > [-]
> > IP: routing cache hash table of 8192 buckets, 64Kbytes
> > TCP: Hash tables configured (established 262144 bind 65536)
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > reiserfs: checking transaction log (device 08:03) ...
> > Using r5 hash to sort names
> > ReiserFS version 3.6.25
> > VFS: Mounted root (reiserfs filesystem) readonly.
> > Freeing unused kernel memory: 208k freed
> > "Warning: unable to open an initial console."
> >
> OK, I've found it.
>
> N-inode-attrs.patch (both versions) is broken. After I've backed it out
> 2.4.15-pre7 + preempt + ReiserFS A-M is up and running.

Apart from the above problems with the new N-inode-attrs.patch
2.4.15-pre7 + preempt + ReiserFS patches A-M flies.

dbench/dbench> time ./dbench 32
32 clients started
...........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+....++.......+........+....+...++...++++.++.++++...++..++++++++++.++********************************
Throughput 43.2101 MB/sec (NB=54.0126 MB/sec  432.101 MBit/sec)
13.880u 51.700s 1:38.77 66.3%   0+0k 0+0io 937pf+0w

Dbench 32 is 10 seconds and nearly 3 MB/sec faster then all kernels I've 
tried before.

Thanks Andrea, Linus and the whole ReiserFS team.

-Dieter

BTW If only the little MP3 playback (Noatun, KDE-2.2.2) hiccup after 9-10 
seconds of the dbench test would disappear. I think we need IO reservation or 
priority, no?

BTW2 Dear ReiserFS team have you read the thread about ACLs/extended file 
attributes on LKML lately?
