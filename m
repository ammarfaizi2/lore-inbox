Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbRFKPJE>; Mon, 11 Jun 2001 11:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbRFKPIr>; Mon, 11 Jun 2001 11:08:47 -0400
Received: from mail.ee.gatech.edu ([130.207.225.105]:6556 "EHLO
	mail.ee.gatech.edu") by vger.kernel.org with ESMTP
	id <S263341AbRFKPIh>; Mon, 11 Jun 2001 11:08:37 -0400
From: "Didier CONTIS" <didier@ece.gatech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Pb of __alloc_pages
Date: Mon, 11 Jun 2001 11:15:59 -0400
Message-ID: <GGEBJOIKMBAKLHABNEAPCEJCCDAA.didier@ece.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am building a Beowulf cluster using Dell PowerEdge 1400SC
(2x800Mhz, 1GB of ram, 9GB Ultra160) and using kernel 2.4.5

I several of my nodes I am getting the following errors:

Jun 10 00:19:32 grendel16 kernel: __alloc_pages: 0-order allocation
failed.
Jun 10 00:19:32 grendel16 last message repeated 12 times
Jun 10 00:19:36 grendel16 kernel: ed.
Jun 10 00:19:36 grendel16 kernel: __alloc_pages: 0-order allocation
failed.
Jun 10 00:19:55 grendel16 last message repeated 363 times
Jun 10 00:23:32 grendel16 kernel: VFS: file-max limit 8192 reached

Below is the output of cat /proc/slabinfo

I was wondering if someone could help me debug this one.

Thanks in advance for any help,

Regards - Didier

slabinfo - version: 1.1 (SMP)
kmem_cache            68     68    232    4    4    1 :  252  126
tcp_tw_bucket         80     80     96    2    2    1 :  252  126
tcp_bind_bucket      167    226     32    2    2    1 :  252  126
tcp_open_request     118    118     64    2    2    1 :  252  126
inet_peer_cache       12    118     64    2    2    1 :  252  126
ip_fib_hash           10    226     32    2    2    1 :  252  126
ip_dst_cache         192    192    160    8    8    1 :  252  126
arp_cache             90     90    128    3    3    1 :  252  126
blkdev_requests     6144   6200     96  155  155    1 :  252  126
nfs_read_data          0      0    384    0    0    1 :  124   62
nfs_write_data         0      0    384    0    0    1 :  124   62
nfs_page               0      0     96    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache       84     84     92    2    2    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache            130    226     32    2    2    1 :  252  126
skbuff_head_cache    400   2400    160   56  100    1 :  252  126
sock                 220  16605    832  107 1845    2 :  124   62
sigqueue             261    261    132    9    9    1 :  252  126
cdev_cache           137    177     64    3    3    1 :  252  126
bdev_cache             3    118     64    2    2    1 :  252  126
inode_cache         7984   7984    480  998  998    1 :  124   62
dentry_cache        8910   8910    128  297  297    1 :  252  126
filp                8192   8320     96  208  208    1 :  252  126
names_cache            7      7   4096    7    7    1 :   60   30
buffer_head       116480 116480     96 2912 2912    1 :  252  126
mm_struct            351   5280    128   18  176    1 :  252  126
vm_area_struct       701  30267     64   15  513    1 :  252  126
fs_cache             320   2832     64   13   48    1 :  252  126
files_cache          182   2637    416   22  293    1 :  124   62
signal_act            83   1155   1312   36  385    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             2      2  16384    2    2    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              1      3   8192    1    3    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             28     28   4096   28   28    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            106    106   2048   53   53    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            242   1500   1024  111  375    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             456    456    512   57   57    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             285    285    256   19   19    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128             630    630    128   21   21    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              758   2714     64   46   46    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32             3051   3051     32   27   27    1 :  252  126

- --
Didier CONTIS
Research Engineer I
School of Electrical and Computer Engineering
Georgia Tech, ECE 0250, Atlanta, GA USA 30332
Phone: (404) 894-3872
Fax:   (404) 894-4641 

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.3 for non-commercial use <http://www.pgp.com>

iQA/AwUBOyTgonqEbTtUcuwQEQJ6RACgrAteLPw33vfOK4BbsnCOkaqGSygAn17L
0tNX9EHum1rYME7YdTgBAUI0
=Xkof
-----END PGP SIGNATURE-----

