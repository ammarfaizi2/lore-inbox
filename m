Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276137AbRJCM0d>; Wed, 3 Oct 2001 08:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276140AbRJCM0X>; Wed, 3 Oct 2001 08:26:23 -0400
Received: from janeway.cistron.net ([195.64.65.23]:12554 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S276137AbRJCM0I>; Wed, 3 Oct 2001 08:26:08 -0400
Date: Wed, 3 Oct 2001 14:26:33 +0200
From: Wichert Akkerman <wichert@cistron.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com
Subject: Re: [linux-lvm] Re: partition table read incorrectly
Message-ID: <20011003142633.A16089@cistron.nl>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-lvm@sistina.com
In-Reply-To: <20011002202934.G14582@wiggy.net> <E15oUUf-0005Xw-00@the-village.bc.nu> <20011002220053.H14582@wiggy.net> <20011002150820.N8954@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011002150820.N8954@turbolinux.com>; from adilger@turbolabs.com on Tue, Oct 02, 2001 at 03:08:20PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andreas Dilger wrote:
> What does the first 512 bytes of the disk show (od -Ax -tx1 /dev/)?

See below.

> Maybe there is still "0xaa55" on the disk at 0x1fe and the kernel
> thinks it is a DOS partition?

Hmm, there does seem to be a 0xaa55 there..

> Hmm, this is sda11, so you would need both a primary and extended
> partition table to get that.  What does /proc/partitions show?

It's not sda11, that output is in hex. At any rate /proc/partitions
contents is also below.

Wichert.

cloud:/home/wichert# od -Ax -tx1 /dev/discs/disc0/disc  | head -32
000000 fa ea 80 00 c0 07 4c 49 4c 4f 01 00 15 07 b5 00
000010 24 00 00 00 15 ce b5 3b e2 20 b0 00 00 e3 20 b0
000020 00 00 e1 20 b0 00 00 01 00 00 00 00 00 00 00 e5
000030 20 b0 00 00 16 0b b0 00 00 17 0b b0 00 00 18 0b
000040 b0 00 00 19 0b b0 00 00 1a 0b b0 00 00 1b 0b b0
000050 00 00 1c 0b b0 00 00 1d 0b b0 00 00 1e 0b b0 00
000060 00 1f 0b b0 00 00 20 0b b0 00 00 00 00 00 00 00
000070 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000080 8c c8 8e d0 bc 80 00 52 53 06 56 bc 00 08 fb 8e
000090 d8 b0 0d e8 6d 00 b0 0a e8 68 00 b0 4c e8 63 00
0000a0 be 34 00 cd 12 c1 e0 06 2d 60 02 50 07 31 db ad
0000b0 91 ac a8 60 75 0f 4e ad 89 c2 09 c8 74 1b ac b4
0000c0 02 cd 13 eb 0d 92 ad f6 c2 20 75 02 30 e4 97 e8
0000d0 3a 00 72 0e 80 c7 02 eb d6 b0 49 e8 25 00 06 6a
0000e0 00 cb b0 20 e8 1c 00 e8 06 00 31 c0 cd 13 eb b0
0000f0 c1 c0 04 e8 03 00 c1 c0 04 24 0f 04 30 3c 3a 72
000100 02 04 07 50 30 ff b4 0e cd 10 58 c3 56 51 53 88
000110 d3 80 e2 8f f6 c3 40 75 33 bb aa 55 b8 00 41 cd
000120 13 72 29 81 fb 55 aa 75 23 f6 c1 01 74 1e 5b 59
000130 1e 31 f6 56 56 57 51 06 53 6a 01 6a 10 89 e6 16
000140 1f b8 00 42 cd 13 8d 64 10 1f eb 44 5b 59 53 52
000150 57 51 06 b4 08 cd 13 07 72 38 51 c0 e9 06 86 e9
000160 89 cf 59 88 f0 fe c0 80 e1 3f f6 e1 96 58 5a 39
000170 f2 73 23 f7 f6 39 f8 77 1d c0 e4 06 86 e0 92 f6
000180 f1 fe c4 00 e2 89 d1 5a 5b 86 f0 b8 01 02 cd 13
000190 eb 09 59 5f eb 02 b4 40 5a 5b f9 5e c3 00 00 00
0001a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0001b0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
0001c0 01 00 83 fe 3f 03 3f 00 00 00 c5 fa 00 00 00 00
0001d0 01 04 83 fe 3f 04 04 fb 00 00 c1 3e 00 00 00 00
0001e0 01 05 8e fe ff ff c5 39 01 00 42 96 25 02 00 00
0001f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa

major minor  #blocks  name

  58     0     524288 lvma
   8     0   18051360 scsi/host0/bus0/target0/lun0/disc
   8     1      32098 scsi/host0/bus0/target0/lun0/part1
   8     2       8032 scsi/host0/bus0/target0/lun0/part2
   8     3   18008865 scsi/host0/bus0/target0/lun0/part3
   8    16   17942584 scsi/host0/bus0/target1/lun0/disc
   8    17    4194304 scsi/host0/bus0/target1/lun0/part1
   8    32    8969493 scsi/host0/bus0/target2/lun0/disc
   8    48    8969493 scsi/host0/bus0/target3/lun0/disc


-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
