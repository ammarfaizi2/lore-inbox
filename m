Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285460AbRLNTEd>; Fri, 14 Dec 2001 14:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285462AbRLNTEY>; Fri, 14 Dec 2001 14:04:24 -0500
Received: from sammy.netpathway.com ([208.137.139.2]:50826 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S285460AbRLNTEK>; Fri, 14 Dec 2001 14:04:10 -0500
Message-ID: <3C1CE37F.101F7572@netpathway.com>
Date: Sun, 16 Dec 2001 12:10:07 -0600
From: Gary White <gary@netpathway.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.17-rc1 boot problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checked through the list and cannot find where this problem has been
addressed.
Anyone else having this segmentation fault problem during boot up?
2.4.16 boots
and runs fine.

Running ...
Linux version 2.4.17-rc1 (root@station2-lnx) (gcc version 2.95.3
20010315 (release)
Reiser root fs
1GHZ Athlon w/VIA VT8363/8365 [KT133/KM133] (rev 3)
512M Memory
reiserfsprogs   3.x.0j
tune2fs            1.26-WIP
util-linux          2.11n

dmesg...
2.4.17-pre6-8 * 2.4.6-rc1
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 1100444k swap-space (priority -1)
Truncating [303762 303421 0x0 SD] to 48 ..invalid operand: 0000
CPU:    0
EIP:    0010:[<c018ec3e>]    Not tainted
EFLAGS: 00010202
eax: 00000003   ebx: 00001000   ecx: 00000000   edx: 00000000
esi: 00001000   edi: 00000000   ebp: de659c34   esp: de659b8c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 22, stackpage=de659000)
Stack: 00000000 de5a74c0 00000000 00001000 00000000 00000000 00000000
00000001
       de5a8198 00001000 00000001 00000000 de597000 de5b98c0 0004a292
0004a13d
       00000001 000001f4 00300002 00000768 0004a292 0004a13d 00000001
0000022b
Call Trace: [<c018ef1a>] [<c01130f0>] [<c011cb42>] [<c011c446>]
[<c0119c1a>]
   [<c0119b40>] [<c011994a>] [<c01083ad>] [<c010a278>] [<c018ed46>]
[<c013262e>]
   [<c0132c32>] [<c018ed30>] [<c0190d0a>] [<c018ed30>] [<c0190de0>]
[<c0197d8e>]
   [<c0195ad8>] [<c01a59f8>] [<c01963c7>] [<c0134d4e>] [<c0143c65>]
[<c0143eff>]
   [<c0143dad>] [<c0143fe4>] [<c0106e5f>]

Code: 0f 0b 83 bd 6c ff ff ff 00 75 0d 8b bd 78 ff ff ff 31 f6 8b
 <6>kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
es1371: version v0.30 time 10:45:28 Dec 14 2001

2.4.16...
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 1100444k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
es1371: version v0.30 time 10:43:16 Nov 26 2001

