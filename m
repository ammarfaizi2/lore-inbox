Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSG2Mdt>; Mon, 29 Jul 2002 08:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSG2Mds>; Mon, 29 Jul 2002 08:33:48 -0400
Received: from gzp11.gzp.hu ([212.40.96.53]:42253 "EHLO gzp11.gzp.hu")
	by vger.kernel.org with ESMTP id <S316709AbSG2Mdq>;
	Mon, 29 Jul 2002 08:33:46 -0400
Date: Mon, 29 Jul 2002 14:37:06 +0200
From: "Gabor Z. Papp" <gzp@myhost.mynet>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.19-rc3-ac3 and ext3 problems
Message-ID: <20020729123706.GC463@gzp2.gzp.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: gzp.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extreme usage of a IC35L060AVVA07-0 ATA DISK drive,
120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(100)
on a PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode
Secondary MASTER Mode controller ends up with:

EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #4325599: directory entry across blocks - offset=0, inode=4082854266, rec_len=55184, name_len=162
Aborting journal on device ide2(33,1).
Remounting filesystem read-only
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #4391169: rec_len % 4 != 0 - offset=0, inode=2583923720, rec_len=30815, name_len=118
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #5914810: rec_len % 4 != 0 - offset=0, inode=3706019706, rec_len=39806, name_len=198
EXT3-fs error (device ide2(33,1)) in start_transaction: Journal has aborted
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #6553840: directory entry across blocks - offset=0, inode=501681528, rec_len=34100, name_len=165
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #6537472: rec_len % 4 != 0 - offset=0, inode=3987959021, rec_len=25889, name_len=144
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #4325597: rec_len % 4 != 0 - offset=0, inode=2071797251, rec_len=48853, name_len=133
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #5701833: inode out of bounds - offset=0, inode=11406299, rec_len=3036, name_len=174
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #4391167: rec_len % 4 != 0 - offset=0, inode=2583923720, rec_len=30815, name_len=118
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #6324474: rec_len % 4 != 0 - offset=0, inode=1687223295, rec_len=207, name_len=3
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #6553838: directory entry across blocks - offset=0, inode=3580267195, rec_len=59804, name_len=52
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #4620448: rec_len % 4 != 0 - offset=0, inode=1646798880, rec_len=26229, name_len=102
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #4767991: rec_len is smaller than minimal - offset=0, inode=3963995904, rec_len=0, name_len=0
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #4767992: rec_len % 4 != 0 - offset=0, inode=39302671, rec_len=35666, name_len=69

Same heavy usage (untargzipping several tarballs in total
size of over 2GB) on 2.4.18 show up no error.
