Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276864AbRJKUdn>; Thu, 11 Oct 2001 16:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276883AbRJKUde>; Thu, 11 Oct 2001 16:33:34 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:62008 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S276864AbRJKUdT>; Thu, 11 Oct 2001 16:33:19 -0400
Date: Thu, 11 Oct 2001 22:32:31 +0200
From: Christian Ullrich <chris@chrullrich.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Can't mount reiserfs with 2.4.11, 2.4.10 works fine
Message-ID: <20011011223231.A730@christian.chrullrich.de>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20011011200349.A3818@christian.chrullrich.de> <Pine.GSO.4.21.0110111414000.24742-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.4.21.0110111414000.24742-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Oct 11, 2001 at 02:16:08PM -0400
X-Current-Uptime: 0 d, 00:02:05 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Viro wrote on Thursday, 2001-10-11:

> fdisk output, please.

The disk contains the one Linux reiserfs partition, one
swap partition and a Windows 2000 installation, which works
as fine as it can be expected to work.

While writing this mail, I found that the swap partition
had somehow acquired partition type 83. I changed it to
82, but the behaviour of 2.4.11 didn't change. 
I haven't yet gotten to test 2.4.12. I will do that asap
and report the results.

fdisk output:

christian:~ # fdisk -l /dev/hdb

Disk /dev/hdb: 16 heads, 63 sectors, 79428 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdb1   *         1      9921   5000152+   7  HPFS/NTFS
/dev/hdb2          9922     77444  34031592    f  Win95 Ext'd (LBA)
/dev/hdb3         77445     79428    999936   82  Linux swap
/dev/hdb5          9922     30728  10486444+   7  HPFS/NTFS
/dev/hdb6         47683     77444  15000016+  83  Linux

christian:~ # fdisk -ul /dev/hdb

Disk /dev/hdb: 16 heads, 63 sectors, 79428 cylinders
Units = sectors of 1 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdb1   *        63  10000367   5000152+   7  HPFS/NTFS
/dev/hdb2      10000368  78063551  34031592    f  Win95 Ext'd (LBA)
/dev/hdb3      78063552  80063423    999936   82  Linux swap
/dev/hdb5      10000431  30973319  10486444+   7  HPFS/NTFS
/dev/hdb6      48063519  78063551  15000016+  83  Linux

Expert command (m for help): p

Disk /dev/hdb: 16 heads, 63 sectors, 79428 cylinders

Nr AF  Hd Sec  Cyl  Hd Sec  Cyl    Start     Size ID
 1 80   1   1    0  15  63 1023       63 10000305 07
 2 00  15  63 1023  15  63 1023 10000368 68063184 0f
 3 00  15  63 1023  15  63 1023 78063552  1999872 82
 4 00   0   0    0   0   0    0        0        0 00
 5 00  15  63 1023  15  63 1023       63 20972889 07
 6 00  15  63 1023  15  63 1023       63 30000033 83

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
