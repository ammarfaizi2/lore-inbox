Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282097AbRLDFyW>; Tue, 4 Dec 2001 00:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282096AbRLDFyM>; Tue, 4 Dec 2001 00:54:12 -0500
Received: from ieee.uow.edu.au ([130.130.88.183]:10710 "EHLO
	klystron.ieee.uow.edu.au") by vger.kernel.org with ESMTP
	id <S282103AbRLDFyF>; Tue, 4 Dec 2001 00:54:05 -0500
Subject: serious filesystem corruption (2.4.16/MediaGX/ext2/CF card)
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Dec 2001 16:54:20 +1100 (EST)
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E16B8X6-00077H-00@klystron.ieee.uow.edu.au>
From: Daniel Robert Franklin <daniel@ieee.uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I have an embedded box which is having an absolute fit at the moment. I have
a 48 MB Sandisk Compact Flash card with a single ext2 partition, running on
a Lippert Cyrix MediaGX-based PC-104 board. Certain activities cause it to
explode, for example find / will do it nicely - the following is a condensed
dmesg output (full thing on http://ieee.uow.edu.au/~daniel/explosion.log)

VFS: Disk change detected on device 16:00
/dev/ide/host0/bus1/target0/lun0: p1
VFS: Disk change detected on device 16:01
VFS: busy inodes on changed media..
/dev/ide/host0/bus1/target0/lun0: p1
VFS: Disk change detected on device 16:00
invalidate: busy buffer
 
 [repeated many times]

/dev/ide/host0/bus1/target0/lun0:hdc1: bad access: block=12222, count=2
end_request: I/O error, dev 16:01 (hdc), sector 12222
hdc1: bad access: block=32840, count=2
end_request: I/O error, dev 16:01 (hdc), sector 32840
IO error syncing ext2 inode [ide1(22,1):00001049]
hdc1: bad access: block=12222, count=2
end_request: I/O error, dev 16:01 (hdc), sector 32840
IO error syncing ext2 inode [ide1(22,1):00001049]
hdc1: bad access: block=12222, count=2
end_request: I/O error, dev 16:01 (hdc), sector 12222
hdc1: bad access: block=12236, count=2
end_request: I/O error, dev 16:01 (hdc), sector 12236
hdc1: bad access: block=32838, count=2
end_request: I/O error, dev 16:01 (hdc), sector 32838
EXT2-fs error (device ide1(22,1)): ext2_write_inode: unable to read inode block
Remounting filesystem read-only

The disk-change thing doesn't sound real healthy.

kernel is 2.4.16 (compiled with MediaGX optimisations - .config is on
http://ieee.uow.edu.au/~daniel/kernel.config)

gcc is 2.95.4

binutils is 2.11.90.0.24

Please CC me as I'm not currently on LKML.

Thanks,

- Daniel

-- 
******************************************************************************
*      Daniel Franklin - Postgraduate student in Electrical Engineering
*      University of Wollongong, NSW, Australia  *  d.franklin@ieee.org
******************************************************************************
