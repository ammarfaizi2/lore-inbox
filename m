Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290454AbSAQUl2>; Thu, 17 Jan 2002 15:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290457AbSAQUlW>; Thu, 17 Jan 2002 15:41:22 -0500
Received: from webmail.koenigsnet.RWTH-Aachen.DE ([134.130.53.212]:64128 "EHLO
	atlantis.koenigsnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S290454AbSAQUlM>; Thu, 17 Jan 2002 15:41:12 -0500
Message-ID: <006701c19f97$5531f520$fd358286@koenigsnet.rwthaachen.de>
From: "Patrick Scharrenberg" <pittipatti@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.17 strange ext2 error
Date: Thu, 17 Jan 2002 21:40:56 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005C_01C19F9F.A5238730"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_005C_01C19F9F.A5238730
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

yesterday I got a very strange ext2 error on my linux machine..
The system has a 5-disk raid-5-software-raid and on top of this there is one
ext2 fs which was clean when mounted 1 week ago..

kernel 2.4.17 (since 1 week)
before it was 2.4.10

suddenly some directories were hidden and so I looked at the logs:

here is a part of /var/log/warn (because it was about 50k I put it on the
websrv):
http://webmail.koenigsnet.rwth-aachen.de/a/warn

after rebooting with kernel 2.4.10 and starting an fsck there were 10,8
billion errors
and now files are gone :-(((((((

..patrick

------=_NextPart_000_005C_01C19F9F.A5238730
Content-Type: application/octet-stream;
	name="warn"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="warn"

Jan 15 19:03:56 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks in system zones - Block =3D 71, count =
=3D 1
Jan 15 19:14:45 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_new_block: Allocating block in system zone - block =3D 71
Jan 16 00:16:18 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #11: rec_len is smaller than =
minimal - offset=3D12288, inode=3D0, rec_len=3D0, name_len=3D0
Jan 16 00:16:18 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #22: rec_len is smaller than =
minimal - offset=3D0, inode=3D1441814, rec_len=3D0, name_len=3D12
Jan 16 00:16:18 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #27: rec_len is smaller than =
minimal - offset=3D0, inode=3D1769499, rec_len=3D0, name_len=3D12
Jan 16 00:16:18 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #131073: rec_len is smaller than =
minimal - offset=3D0, inode=3D65537, rec_len=3D2, name_len=3D12
Jan 16 00:16:18 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2752528: directory entry across =
blocks - offset=3D212, inode=3D3510350, rec_len=3D3900, name_len=3D3
Jan 16 00:16:19 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6946848: unaligned directory =
entry - offset=3D0, inode=3D2097184, rec_len=3D106, name_len=3D12
Jan 16 00:16:19 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #212993: inode out of bounds - =
offset=3D24, inode=3D1073954818, rec_len=3D28, name_len=3D18
Jan 16 00:16:19 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #376833: inode out of bounds - =
offset=3D24, inode=3D2147860482, rec_len=3D28, name_len=3D17
Jan 16 00:16:19 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #458753: unaligned directory =
entry - offset=3D0, inode=3D458753, rec_len=3D15, name_len=3D13
Jan 16 00:16:19 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #524289 is not a multiple of chunk =
size
Jan 16 00:16:19 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #540673: directory entry across =
blocks - offset=3D44, inode=3D1074479107, rec_len=3D4060, name_len=3D220
Jan 16 00:16:19 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #704513: directory entry across =
blocks - offset=3D44, inode=3D1074487297, rec_len=3D4060, name_len=3D95
Jan 16 00:16:20 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #786433: rec_len is too small =
for name_len - offset=3D0, inode=3D65537, rec_len=3D12, name_len=3D12
Jan 16 00:16:20 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #868353: unaligned directory =
entry - offset=3D0, inode=3D1073823745, rec_len=3D13, name_len=3D12
Jan 16 00:16:20 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #950273: rec_len is too small =
for name_len - offset=3D44, inode=3D2148462611, rec_len=3D28, =
name_len=3D30
Jan 16 00:16:20 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #1343489 is not a multiple of chunk =
size
Jan 16 00:16:20 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1359873: inode out of bounds - =
offset=3D0, inode=3D3221340161, rec_len=3D20, name_len=3D12
Jan 16 00:16:20 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1441793: unaligned directory =
entry - offset=3D0, inode=3D65537, rec_len=3D22, name_len=3D12
Jan 16 00:16:20 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1490945: unaligned directory =
entry - offset=3D4096, inode=3D3233923265, rec_len=3D22, name_len=3D20
Jan 16 00:16:21 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1687553: unaligned directory =
entry - offset=3D0, inode=3D3221340161, rec_len=3D25, name_len=3D12
Jan 16 00:16:21 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1769473: unaligned directory =
entry - offset=3D0, inode=3D65537, rec_len=3D27, name_len=3D12
Jan 16 00:16:21 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1851393: inode out of bounds - =
offset=3D0, inode=3D1073823745, rec_len=3D28, name_len=3D12
Jan 16 00:16:21 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1933313: unaligned directory =
entry - offset=3D0, inode=3D2147581953, rec_len=3D29, name_len=3D12
Jan 16 00:16:21 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2015233: unaligned directory =
entry - offset=3D0, inode=3D3221340161, rec_len=3D30, name_len=3D12
Jan 16 00:16:21 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2097153: directory entry across =
blocks - offset=3D32, inode=3D808452612, rec_len=3D14128, name_len=3D1
Jan 16 00:16:21 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2179073: unaligned directory =
entry - offset=3D0, inode=3D1075920897, rec_len=3D45, name_len=3D13
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #2244609 is not a multiple of chunk =
size
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2260993: unaligned directory =
entry - offset=3D0, inode=3D2147581953, rec_len=3D34, name_len=3D12
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2342913: directory entry across =
blocks - offset=3D48, inode=3D2342915, rec_len=3D4080, name_len=3D10
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2424833: unaligned directory =
entry - offset=3D0, inode=3D2424833, rec_len=3D45, name_len=3D13
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2506753: unaligned directory =
entry - offset=3D0, inode=3D1073823745, rec_len=3D38, name_len=3D12
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2588673: rec_len is smaller =
than minimal - offset=3D12, inode=3D131072, rec_len=3D2, name_len=3D12
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2670593: inode out of bounds - =
offset=3D0, inode=3D3221340161, rec_len=3D44, name_len=3D12
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #2736129 is not a multiple of chunk =
size
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2834433: inode out of bounds - =
offset=3D0, inode=3D1076576257, rec_len=3D12, name_len=3D1
Jan 16 00:16:22 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2998273: inode out of bounds - =
offset=3D24, inode=3D2150481922, rec_len=3D4072, name_len=3D14
Jan 16 00:16:23 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3063809: rec_len is smaller =
than minimal - offset=3D0, inode=3D0, rec_len=3D0, name_len=3D0
Jan 16 00:16:23 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3080193: unaligned directory =
entry - offset=3D0, inode=3D3080193, rec_len=3D47, name_len=3D13
Jan 16 00:16:23 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3817473: unaligned directory =
entry - offset=3D0, inode=3D1073823745, rec_len=3D58, name_len=3D12
Jan 16 00:16:23 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3899393: unaligned directory =
entry - offset=3D0, inode=3D2147581953, rec_len=3D59, name_len=3D12
Jan 16 00:16:23 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4063233: unaligned directory =
entry - offset=3D0, inode=3D65537, rec_len=3D62, name_len=3D12
Jan 16 00:16:23 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4145153: unaligned directory =
entry - offset=3D0, inode=3D1077886977, rec_len=3D63, name_len=3D13
Jan 16 00:16:23 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4227073: rec_len is too small =
for name_len - offset=3D12, inode=3D3225272321, rec_len=3D12, =
name_len=3D10
Jan 16 00:16:24 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4390913: unaligned directory =
entry - offset=3D0, inode=3D4390913, rec_len=3D71, name_len=3D12
Jan 16 00:16:24 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4472833: unaligned directory =
entry - offset=3D12, inode=3D3225272321, rec_len=3D61, name_len=3D14
Jan 16 00:16:24 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4554753: unaligned directory =
entry - offset=3D0, inode=3D2147581953, rec_len=3D69, name_len=3D12
Jan 16 00:16:24 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5128193: unaligned directory =
entry - offset=3D0, inode=3D1073823745, rec_len=3D78, name_len=3D12
Jan 16 00:16:24 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5210113: unaligned directory =
entry - offset=3D52, inode=3D2152693763, rec_len=3D94, name_len=3D30
Jan 16 00:16:24 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1605634: inode out of bounds - =
offset=3D104, inode=3D2147965013, rec_len=3D24, name_len=3D16
Jan 16 00:16:24 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2097154: directory entry across =
blocks - offset=3D56, inode=3D2112572, rec_len=3D4072, name_len=3D159
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3080194: unaligned directory =
entry - offset=3D100, inode=3D262144047, rec_len=3D266, name_len=3D115
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3325954: unaligned directory =
entry - offset=3D0, inode=3D3224551426, rec_len=3D62, name_len=3D13
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5128194: unaligned directory =
entry - offset=3D48, inode=3D1296976207, rec_len=3D19807, name_len=3D95
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8159234: inode out of bounds - =
offset=3D0, inode=3D2155773954, rec_len=3D124, name_len=3D13
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8323074: unaligned directory =
entry - offset=3D0, inode=3D131074, rec_len=3D127, name_len=3D12
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8486914: unaligned directory =
entry - offset=3D72, inode=3D2156263022, rec_len=3D185, name_len=3D62
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8568834: inode out of bounds - =
offset=3D12, inode=3D2155839490, rec_len=3D12, name_len=3D2
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8650754: directory entry across =
blocks - offset=3D132, inode=3D1852397394, rec_len=3D11808, name_len=3D2
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9142274: unaligned directory =
entry - offset=3D0, inode=3D2147647490, rec_len=3D139, name_len=3D12
Jan 16 00:16:25 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #9207810 is not a multiple of chunk =
size
Jan 16 00:16:26 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9306114: rec_len is too small =
for name_len - offset=3D56, inode=3D9334788, rec_len=3D28, name_len=3D27
Jan 16 00:16:26 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9469954: inode out of bounds - =
offset=3D0, inode=3D2147647490, rec_len=3D144, name_len=3D12
Jan 16 00:16:26 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #9617410 is not a multiple of chunk =
size
Jan 16 00:16:26 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9633794: unaligned directory =
entry - offset=3D0, inode=3D131074, rec_len=3D147, name_len=3D12
Jan 16 00:16:26 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9797634: unaligned directory =
entry - offset=3D0, inode=3D2147647490, rec_len=3D149, name_len=3D12
Jan 16 00:16:27 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9846787: inode out of bounds - =
offset=3D56, inode=3D1083595790, rec_len=3D156, name_len=3D12
Jan 16 00:16:27 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #8470532 is not a multiple of chunk =
size
Jan 16 00:16:27 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7307267: inode out of bounds - =
offset=3D24, inode=3D2154790916, rec_len=3D28, name_len=3D9
Jan 16 00:16:28 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8208387: directory entry across =
blocks - offset=3D40, inode=3D8208389, rec_len=3D4088, name_len=3D8
Jan 16 00:16:28 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8699907: inode out of bounds - =
offset=3D0, inode=3D3221471235, rec_len=3D132, name_len=3D12
Jan 16 00:16:28 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9191427: inode out of bounds - =
offset=3D0, inode=3D1073954819, rec_len=3D140, name_len=3D12
Jan 16 00:16:28 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9355267: inode out of bounds - =
offset=3D24, inode=3D3230580740, rec_len=3D156, name_len=3D30
Jan 16 00:16:28 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9682947: inode out of bounds - =
offset=3D100, inode=3D3230908424, rec_len=3D20, name_len=3D11
Jan 16 00:16:29 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #5849093 is not a multiple of chunk =
size
Jan 16 00:16:29 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8634373: unaligned directory =
entry - offset=3D0, inode=3D3221602309, rec_len=3D131, name_len=3D12
Jan 16 00:16:29 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3850244: unaligned directory =
entry - offset=3D0, inode=3D3225337860, rec_len=3D62, name_len=3D13
Jan 16 00:16:29 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5406726: unaligned directory =
entry - offset=3D0, inode=3D2147909638, rec_len=3D82, name_len=3D12
Jan 16 00:16:29 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4177926: unaligned directory =
entry - offset=3D0, inode=3D3221667846, rec_len=3D63, name_len=3D12
Jan 16 00:16:29 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6225926: unaligned directory =
entry - offset=3D0, inode=3D6225926, rec_len=3D95, name_len=3D13
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8978437: unaligned directory =
entry - offset=3D0, inode=3D327685, rec_len=3D137, name_len=3D12
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4784133: unaligned directory =
entry - offset=3D0, inode=3D1071156497, rec_len=3D33629, name_len=3D111
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2883588: directory entry across =
blocks - offset=3D84, inode=3D3211750251, rec_len=3D45340, name_len=3D20
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7127083: inode out of bounds - =
offset=3D0, inode=3D3224092715, rec_len=3D108, name_len=3D12
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5505067: unaligned directory =
entry - offset=3D84, inode=3D2036693349, rec_len=3D17453, name_len=3D67
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5423159: inode out of bounds - =
offset=3D12, inode=3D3230908460, rec_len=3D12, name_len=3D2
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8388657: unaligned directory =
entry - offset=3D128, inode=3D1718176863, rec_len=3D10597, name_len=3D95
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #5816372 is not a multiple of chunk =
size
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5718062: unaligned directory =
entry - offset=3D0, inode=3D1076772910, rec_len=3D87, name_len=3D12
Jan 16 00:16:30 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6570031: inode out of bounds - =
offset=3D0, inode=3D1076838447, rec_len=3D100, name_len=3D12
Jan 16 00:16:31 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8355860: unaligned directory =
entry - offset=3D0, inode=3D2148827156, rec_len=3D127, name_len=3D12
Jan 16 00:16:31 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6537275: unaligned directory =
entry - offset=3D0, inode=3D3225141307, rec_len=3D99, name_len=3D12
Jan 16 00:16:31 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #704575: rec_len is smaller than =
minimal - offset=3D0, inode=3D3225403455, rec_len=3D10, name_len=3D12
Jan 16 00:16:31 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4620331: unaligned directory =
entry - offset=3D0, inode=3D2150334507, rec_len=3D70, name_len=3D12
Jan 16 00:16:31 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3833880: unaligned directory =
entry - offset=3D68, inode=3D2151330682, rec_len=3D58, name_len=3D63
Jan 16 00:16:31 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8552499: unaligned directory =
entry - offset=3D0, inode=3D2150858803, rec_len=3D130, name_len=3D12
Jan 16 00:16:32 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #9207835 is not a multiple of chunk =
size
Jan 16 00:16:32 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8749081: inode out of bounds - =
offset=3D24, inode=3D2156232730, rec_len=3D4072, name_len=3D12
Jan 16 00:16:32 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9928752: unaligned directory =
entry - offset=3D0, inode=3D2150662192, rec_len=3D151, name_len=3D12
Jan 16 00:16:32 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6438918: unaligned directory =
entry - offset=3D56, inode=3D1080741160, rec_len=3D126, name_len=3D29
Jan 16 00:16:32 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4964400: unaligned directory =
entry - offset=3D0, inode=3D3224420400, rec_len=3D75, name_len=3D12
Jan 16 00:16:32 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8486926: unaligned directory =
entry - offset=3D0, inode=3D2148433934, rec_len=3D129, name_len=3D12
Jan 16 00:16:33 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1474567: directory entry across =
blocks - offset=3D24, inode=3D1474568, rec_len=3D4088, name_len=3D16
Jan 16 00:16:33 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8142891: inode out of bounds - =
offset=3D12, inode=3D1078149124, rec_len=3D12, name_len=3D2
Jan 16 00:16:33 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4407301: inode out of bounds - =
offset=3D0, inode=3D1078149125, rec_len=3D76, name_len=3D9
Jan 16 00:16:33 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #720917: directory entry across =
blocks - offset=3D116, inode=3D9666592, rec_len=3D3996, name_len=3D5
Jan 16 00:16:34 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8699975: inode out of bounds - =
offset=3D196, inode=3D3234720239, rec_len=3D164, name_len=3D63
Jan 16 00:16:34 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8486938: unaligned directory =
entry - offset=3D0, inode=3D2149220378, rec_len=3D129, name_len=3D12
Jan 16 00:16:34 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9044003: rec_len is too small =
for name_len - offset=3D76, inode=3D2148171784, rec_len=3D56, =
name_len=3D56
Jan 16 00:16:34 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9682999: unaligned directory =
entry - offset=3D0, inode=3D3233267767, rec_len=3D159, name_len=3D13
Jan 16 00:16:35 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1949731: inode out of bounds - =
offset=3D0, inode=3D3223568419, rec_len=3D12, name_len=3D1
Jan 16 00:16:35 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5783593: inode out of bounds - =
offset=3D0, inode=3D1076445225, rec_len=3D12, name_len=3D1
Jan 16 00:16:35 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4653134: unaligned directory =
entry - offset=3D24, inode=3D5177423, rec_len=3D86, name_len=3D24
Jan 16 00:16:35 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9535520: inode out of bounds - =
offset=3D0, inode=3D2157019168, rec_len=3D12, name_len=3D1
Jan 16 00:16:35 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2375712: rec_len is too small =
for name_len - offset=3D96, inode=3D1076052003, rec_len=3D52, =
name_len=3D52
Jan 16 00:16:35 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4603954: unaligned directory =
entry - offset=3D0, inode=3D1081491506, rec_len=3D78, name_len=3D13
Jan 16 00:16:35 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9683006: rec_len is too small =
for name_len - offset=3D24, inode=3D9683007, rec_len=3D64, =
name_len=3D120
Jan 16 00:16:35 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9764871: unaligned directory =
entry - offset=3D0, inode=3D9895943, rec_len=3D157, name_len=3D13
Jan 16 00:16:36 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5111895: unaligned directory =
entry - offset=3D0, inode=3D6160471, rec_len=3D78, name_len=3D13
Jan 16 00:16:36 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4489229: inode out of bounds - =
offset=3D0, inode=3D2148368397, rec_len=3D68, name_len=3D12
Jan 16 00:16:36 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8486947: unaligned directory =
entry - offset=3D0, inode=3D2149810211, rec_len=3D129, name_len=3D12
Jan 16 00:16:36 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6832187: inode out of bounds - =
offset=3D0, inode=3D1077624891, rec_len=3D104, name_len=3D12
Jan 16 00:16:36 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1277960: unaligned directory =
entry - offset=3D0, inode=3D2148040712, rec_len=3D19, name_len=3D12
Jan 16 00:16:36 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5783613: rec_len is too small =
for name_len - offset=3D104, inode=3D5789555, rec_len=3D76, =
name_len=3D123
Jan 16 00:16:36 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5079099: unaligned directory =
entry - offset=3D8192, inode=3D1093354571, rec_len=3D12354, =
name_len=3D72
Jan 16 00:16:36 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #5079099 is not a multiple of chunk =
size
Jan 16 00:16:37 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4407327: unaligned directory =
entry - offset=3D0, inode=3D1079984159, rec_len=3D79, name_len=3D13
Jan 16 00:16:37 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1540146: unaligned directory =
entry - offset=3D0, inode=3D2151120946, rec_len=3D30, name_len=3D13
Jan 16 00:16:37 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5275698: inode out of bounds - =
offset=3D0, inode=3D2150793266, rec_len=3D80, name_len=3D12
Jan 16 00:16:38 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5308463: unaligned directory =
entry - offset=3D92, inode=3D1764897652, rec_len=3D25902, name_len=3D120
Jan 16 00:16:38 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5324888: unaligned directory =
entry - offset=3D0, inode=3D1079591000, rec_len=3D93, name_len=3D13
Jan 16 00:16:38 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5292129: inode out of bounds - =
offset=3D64, inode=3D3228879204, rec_len=3D84, name_len=3D31
Jan 16 00:16:38 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9502833: unaligned directory =
entry - offset=3D0, inode=3D7405681, rec_len=3D145, name_len=3D12
Jan 16 00:16:38 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3965041: inode out of bounds - =
offset=3D60, inode=3D2155093613, rec_len=3D60, name_len=3D20
Jan 16 00:16:38 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1998961: inode out of bounds - =
offset=3D108, inode=3D2149493878, rec_len=3D20, name_len=3D11
Jan 16 00:16:39 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6422642: unaligned directory =
entry - offset=3D0, inode=3D7471218, rec_len=3D98, name_len=3D12
Jan 16 00:16:39 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8323186: directory entry across =
blocks - offset=3D96, inode=3D4735090, rec_len=3D4064, name_len=3D4
Jan 16 00:16:39 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8880242: unaligned directory =
entry - offset=3D0, inode=3D2154987634, rec_len=3D135, name_len=3D12
Jan 16 00:16:40 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9338994: rec_len is too small =
for name_len - offset=3D144, inode=3D2161021048, rec_len=3D24, =
name_len=3D24
Jan 16 00:16:40 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8470643: unaligned directory =
entry - offset=3D0, inode=3D1081294963, rec_len=3D129, name_len=3D12
Jan 16 00:16:40 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1966195: unaligned directory =
entry - offset=3D0, inode=3D8323187, rec_len=3D30, name_len=3D13
Jan 16 00:16:40 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3752051: directory entry across =
blocks - offset=3D24, inode=3D3752052, rec_len=3D4088, name_len=3D12
Jan 16 00:16:41 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6258803: unaligned directory =
entry - offset=3D0, inode=3D2155053171, rec_len=3D95, name_len=3D12
Jan 16 00:16:41 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6520948: unaligned directory =
entry - offset=3D0, inode=3D2155184244, rec_len=3D103, name_len=3D13
Jan 16 00:16:42 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2031732: unaligned directory =
entry - offset=3D44, inode=3D8374142, rec_len=3D4062, name_len=3D220
Jan 16 00:16:42 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6111349: unaligned directory =
entry - offset=3D0, inode=3D1081426037, rec_len=3D93, name_len=3D12
Jan 16 00:16:42 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9142389: unaligned directory =
entry - offset=3D0, inode=3D2155184245, rec_len=3D139, name_len=3D12
Jan 16 00:16:42 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5406837: unaligned directory =
entry - offset=3D0, inode=3D2155184245, rec_len=3D82, name_len=3D12
Jan 16 00:16:42 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4718673: unaligned directory =
entry - offset=3D72, inode=3D2138535294, rec_len=3D32627, name_len=3D127
Jan 16 00:16:42 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9158691: unaligned directory =
entry - offset=3D0, inode=3D3223568419, rec_len=3D139, name_len=3D12
Jan 16 00:16:43 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2015274: unaligned directory =
entry - offset=3D0, inode=3D3224027178, rec_len=3D30, name_len=3D12
Jan 16 00:16:43 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8683538: inode out of bounds - =
offset=3D0, inode=3D2148696082, rec_len=3D132, name_len=3D12
Jan 16 00:16:43 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8323116: unaligned directory =
entry - offset=3D0, inode=3D2883628, rec_len=3D127, name_len=3D12
Jan 16 00:16:43 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7929879: directory entry across =
blocks - offset=3D44, inode=3D7929881, rec_len=3D4092, name_len=3D86
Jan 16 00:16:43 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8437789: directory entry across =
blocks - offset=3D44, inode=3D8323127, rec_len=3D4092, name_len=3D6
Jan 16 00:16:43 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4833309: unaligned directory =
entry - offset=3D0, inode=3D3223175197, rec_len=3D73, name_len=3D12
Jan 16 00:16:43 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7159872: inode out of bounds - =
offset=3D0, inode=3D1080901696, rec_len=3D108, name_len=3D13
Jan 16 00:16:44 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2326595: unaligned directory =
entry - offset=3D0, inode=3D2151907395, rec_len=3D35, name_len=3D12
Jan 16 00:16:44 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5062696: inode out of bounds - =
offset=3D184, inode=3D1082875936, rec_len=3D16, name_len=3D6
Jan 16 00:16:44 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9420869: unaligned directory =
entry - offset=3D0, inode=3D3225796677, rec_len=3D143, name_len=3D12
Jan 16 00:16:44 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4735046: inode out of bounds - =
offset=3D0, inode=3D1078345798, rec_len=3D72, name_len=3D12
Jan 16 00:16:44 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2506785: inode out of bounds - =
offset=3D12, inode=3D1082867764, rec_len=3D12, name_len=3D2
Jan 16 00:16:45 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7176220: inode out of bounds - =
offset=3D48, inode=3D2154663966, rec_len=3D24, name_len=3D13
Jan 16 00:16:45 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9125950: unaligned directory =
entry - offset=3D12288, inode=3D1120879311, rec_len=3D139, name_len=3D16
Jan 16 00:16:45 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #5406783 is not a multiple of chunk =
size
Jan 16 00:16:45 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6406211: unaligned directory =
entry - offset=3D0, inode=3D3225665603, rec_len=3D97, name_len=3D12
Jan 16 00:16:46 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2342927: unaligned directory =
entry - offset=3D0, inode=3D3222257679, rec_len=3D35, name_len=3D12
Jan 16 00:16:46 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8781885: rec_len is too small =
for name_len - offset=3D40, inode=3D26130379, rec_len=3D20, =
name_len=3D31
Jan 16 00:16:46 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #7618619 is not a multiple of chunk =
size
Jan 16 00:16:46 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8880186: unaligned directory =
entry - offset=3D0, inode=3D2151317562, rec_len=3D135, name_len=3D12
Jan 16 00:16:46 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2342944: rec_len is too small =
for name_len - offset=3D180, inode=3D3224420400, rec_len=3D16, =
name_len=3D16
Jan 16 00:16:47 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8126517: rec_len is too small =
for name_len - offset=3D52, inode=3D9240613, rec_len=3D16, name_len=3D16
Jan 16 00:16:47 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9420891: unaligned directory =
entry - offset=3D0, inode=3D3227238491, rec_len=3D143, name_len=3D12
Jan 16 00:16:47 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4571200: unaligned directory =
entry - offset=3D0, inode=3D3225468992, rec_len=3D69, name_len=3D12
Jan 16 00:16:47 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7635005: inode out of bounds - =
offset=3D0, inode=3D2151514173, rec_len=3D116, name_len=3D12
Jan 16 00:16:47 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7618652: inode out of bounds - =
offset=3D0, inode=3D1081884764, rec_len=3D116, name_len=3D12
Jan 16 00:16:48 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7684136: directory entry across =
blocks - offset=3D72, inode=3D7696428, rec_len=3D4088, name_len=3D3
Jan 16 00:16:48 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7684148: unaligned directory =
entry - offset=3D0, inode=3D1077166132, rec_len=3D117, name_len=3D12
Jan 16 00:16:48 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2687069: unaligned directory =
entry - offset=3D0, inode=3D6094941, rec_len=3D41, name_len=3D12
Jan 16 00:16:48 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4358237: unaligned directory =
entry - offset=3D104, inode=3D2153954928, rec_len=3D102, name_len=3D60
Jan 16 00:16:48 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7880797: inode out of bounds - =
offset=3D0, inode=3D1079853149, rec_len=3D120, name_len=3D12
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #9060435 is not a multiple of chunk =
size
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9060436: unaligned directory =
entry - offset=3D0, inode=3D1079263316, rec_len=3D138, name_len=3D12
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5734416: unaligned directory =
entry - offset=3D0, inode=3D2148565008, rec_len=3D87, name_len=3D12
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3948581: inode out of bounds - =
offset=3D0, inode=3D1076183077, rec_len=3D60, name_len=3D12
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3948597: inode out of bounds - =
offset=3D0, inode=3D1077231669, rec_len=3D60, name_len=3D12
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8110174: inode out of bounds - =
offset=3D0, inode=3D2155593822, rec_len=3D12, name_len=3D1
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7077962: directory entry across =
blocks - offset=3D108, inode=3D3451386430, rec_len=3D28640, =
name_len=3D208
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7077982: directory entry across =
blocks - offset=3D68, inode=3D7107690, rec_len=3D4092, name_len=3D191
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7520287: unaligned directory =
entry - offset=3D0, inode=3D3223306271, rec_len=3D114, name_len=3D12
Jan 16 00:16:49 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7520306: unaligned directory =
entry - offset=3D0, inode=3D3224551474, rec_len=3D114, name_len=3D12
Jan 16 00:16:50 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7520344: unaligned directory =
entry - offset=3D0, inode=3D3227041880, rec_len=3D114, name_len=3D12
Jan 16 00:16:50 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9617466: inode out of bounds - =
offset=3D68, inode=3D3233477695, rec_len=3D4028, name_len=3D191
Jan 16 00:16:50 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9617476: unaligned directory =
entry - offset=3D0, inode=3D3235299396, rec_len=3D158, name_len=3D13
Jan 16 00:16:50 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8044639: unaligned directory =
entry - offset=3D0, inode=3D3227500639, rec_len=3D122, name_len=3D12
Jan 16 00:16:50 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2539615: unaligned directory =
entry - offset=3D0, inode=3D3227500639, rec_len=3D38, name_len=3D12
Jan 16 00:16:51 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2359371: rec_len is too small =
for name_len - offset=3D56, inode=3D7209038, rec_len=3D12, name_len=3D12
Jan 16 00:16:51 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2359376: unaligned directory =
entry - offset=3D36, inode=3D1702065267, rec_len=3D30322, name_len=3D101
Jan 16 00:16:51 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5095470: unaligned directory =
entry - offset=3D0, inode=3D3228549166, rec_len=3D77, name_len=3D13
Jan 16 00:16:51 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5095500: unaligned directory =
entry - offset=3D0, inode=3D3226255436, rec_len=3D77, name_len=3D12
Jan 16 00:16:51 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5095515: directory entry across =
blocks - offset=3D68, inode=3D5095519, rec_len=3D4092, name_len=3D7
Jan 16 00:16:51 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5570583: unaligned directory =
entry - offset=3D0, inode=3D1507351, rec_len=3D85, name_len=3D12
Jan 16 00:16:51 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9109596: unaligned directory =
entry - offset=3D0, inode=3D6029404, rec_len=3D139, name_len=3D12
Jan 16 00:16:52 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2064427: unaligned directory =
entry - offset=3D12, inode=3D2151645226, rec_len=3D30, name_len=3D14
Jan 16 00:16:52 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2064447: unaligned directory =
entry - offset=3D0, inode=3D2151645247, rec_len=3D31, name_len=3D13
Jan 16 00:16:52 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2064457: unaligned directory =
entry - offset=3D0, inode=3D2152300617, rec_len=3D31, name_len=3D12
Jan 16 00:16:52 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5849184: directory entry across =
blocks - offset=3D52, inode=3D3228811360, rec_len=3D4092, name_len=3D9
Jan 16 00:16:52 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4096096: unaligned directory =
entry - offset=3D0, inode=3D2153807968, rec_len=3D62, name_len=3D12
Jan 16 00:16:52 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2064480: rec_len is too small =
for name_len - offset=3D0, inode=3D2151645280, rec_len=3D12, =
name_len=3D9
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5668916: unaligned directory =
entry - offset=3D40, inode=3D4252925814, rec_len=3D58430, name_len=3D118
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5668921: directory entry across =
blocks - offset=3D60, inode=3D5668928, rec_len=3D4052, name_len=3D10
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5668950: unaligned directory =
entry - offset=3D0, inode=3D2153152598, rec_len=3D86, name_len=3D12
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2244658: directory entry across =
blocks - offset=3D52, inode=3D1917002, rec_len=3D4060, name_len=3D9
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #1917016: rec_len is too small =
for name_len - offset=3D0, inode=3D1079525464, rec_len=3D12, =
name_len=3D12
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #7045162 is not a multiple of chunk =
size
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7045209: unaligned directory =
entry - offset=3D0, inode=3D2153349209, rec_len=3D107, name_len=3D12
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2572372: inode out of bounds - =
offset=3D0, inode=3D1076314196, rec_len=3D12, name_len=3D1
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7848033: unaligned directory =
entry - offset=3D0, inode=3D3227631713, rec_len=3D119, name_len=3D12
Jan 16 00:16:53 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8306785: unaligned directory =
entry - offset=3D0, inode=3D3229597793, rec_len=3D126, name_len=3D13
Jan 16 00:16:54 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7012427: unaligned directory =
entry - offset=3D0, inode=3D4915275, rec_len=3D107, name_len=3D12
Jan 16 00:16:54 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3653672: unaligned directory =
entry - offset=3D0, inode=3D3225403432, rec_len=3D62, name_len=3D13
Jan 16 00:16:54 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3653686: inode out of bounds - =
offset=3D36, inode=3D3224879164, rec_len=3D16, name_len=3D7
Jan 16 00:16:54 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6226018: unaligned directory =
entry - offset=3D12, inode=3D8257634, rec_len=3D62, name_len=3D14
Jan 16 00:16:54 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9633890: unaligned directory =
entry - offset=3D0, inode=3D6422626, rec_len=3D147, name_len=3D12
Jan 16 00:16:55 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4489289: inode out of bounds - =
offset=3D0, inode=3D2152562761, rec_len=3D76, name_len=3D13
Jan 16 00:16:55 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5226551: inode out of bounds - =
offset=3D24, inode=3D1078968376, rec_len=3D12, name_len=3D3
Jan 16 00:16:55 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5226565: unaligned directory =
entry - offset=3D0, inode=3D3225796677, rec_len=3D79, name_len=3D12
Jan 16 00:16:55 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9961474: unaligned directory =
entry - offset=3D152, inode=3D1127704446, rec_len=3D40831, =
name_len=3D108
Jan 16 00:16:55 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9961479: unaligned directory =
entry - offset=3D152, inode=3D18284696, rec_len=3D16711, name_len=3D87
Jan 16 00:16:55 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3752035: directory entry across =
blocks - offset=3D60, inode=3D1869377387, rec_len=3D28536, =
name_len=3D120
Jan 16 00:16:55 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7209059: unaligned directory =
entry - offset=3D0, inode=3D6488163, rec_len=3D110, name_len=3D12
Jan 16 00:16:55 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8732771: unaligned directory =
entry - offset=3D60, inode=3D1088778855, rec_len=3D4037, name_len=3D206
Jan 16 00:16:56 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9896035: unaligned directory =
entry - offset=3D0, inode=3D16187491, rec_len=3D159, name_len=3D13
Jan 16 00:16:56 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8749155: unaligned directory =
entry - offset=3D0, inode=3D2154004579, rec_len=3D133, name_len=3D12
Jan 16 00:16:56 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: size of directory #6078563 is not a multiple of chunk =
size
Jan 16 00:16:56 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7077987: unaligned directory =
entry - offset=3D108, inode=3D1203164081, rec_len=3D17811, =
name_len=3D234
Jan 16 00:16:57 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3653731: unaligned directory =
entry - offset=3D0, inode=3D3227762787, rec_len=3D55, name_len=3D12
Jan 16 00:16:58 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3637299: unaligned directory =
entry - offset=3D0, inode=3D2150858803, rec_len=3D55, name_len=3D12
Jan 16 00:16:58 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3637314: unaligned directory =
entry - offset=3D0, inode=3D2151841858, rec_len=3D55, name_len=3D12
Jan 16 00:16:58 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3637343: directory entry across =
blocks - offset=3D36, inode=3D3637349, rec_len=3D4092, name_len=3D14
Jan 16 00:16:58 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5210127: inode out of bounds - =
offset=3D24, inode=3D2152693776, rec_len=3D20, name_len=3D10
Jan 16 00:16:58 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5210137: unaligned directory =
entry - offset=3D0, inode=3D2149154841, rec_len=3D79, name_len=3D12
Jan 16 00:16:58 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5210167: inode out of bounds - =
offset=3D0, inode=3D2152693815, rec_len=3D12, name_len=3D1
Jan 16 00:16:58 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6586468: inode out of bounds - =
offset=3D44, inode=3D2154203511, rec_len=3D108, name_len=3D15
Jan 16 00:16:58 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5652580: unaligned directory =
entry - offset=3D0, inode=3D1080311908, rec_len=3D86, name_len=3D12
Jan 16 00:16:58 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #213048: inode out of bounds - =
offset=3D0, inode=3D1073954872, rec_len=3D12, name_len=3D1
Jan 16 00:16:59 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #4587631: unaligned directory =
entry - offset=3D0, inode=3D7274607, rec_len=3D78, name_len=3D13
Jan 16 00:16:59 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #2441327: unaligned directory =
entry - offset=3D0, inode=3D1081032815, rec_len=3D45, name_len=3D13
Jan 16 00:16:59 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9863279: unaligned directory =
entry - offset=3D0, inode=3D2164162671, rec_len=3D158, name_len=3D13
Jan 16 00:16:59 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3686511: inode out of bounds - =
offset=3D0, inode=3D1081032815, rec_len=3D56, name_len=3D12
Jan 16 00:16:59 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #6586480: inode out of bounds - =
offset=3D0, inode=3D2154856560, rec_len=3D100, name_len=3D12
Jan 16 00:17:00 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #5849200: unaligned directory =
entry - offset=3D0, inode=3D1081098352, rec_len=3D89, name_len=3D12
Jan 16 00:17:00 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8683632: inode out of bounds - =
offset=3D0, inode=3D2154856560, rec_len=3D132, name_len=3D12
Jan 16 00:17:00 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8372336: directory entry across =
blocks - offset=3D24, inode=3D8372337, rec_len=3D4088, name_len=3D10
Jan 16 00:17:00 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3899504: unaligned directory =
entry - offset=3D0, inode=3D2155577456, rec_len=3D63, name_len=3D13
Jan 16 00:17:00 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9470064: unaligned directory =
entry - offset=3D12, inode=3D1081819248, rec_len=3D94, name_len=3D14
Jan 16 00:17:00 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #8585328: unaligned directory =
entry - offset=3D0, inode=3D7340144, rec_len=3D131, name_len=3D12
Jan 16 00:17:00 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #9584752: unaligned directory =
entry - offset=3D0, inode=3D1081098352, rec_len=3D146, name_len=3D12
Jan 16 00:17:00 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7864432: directory entry across =
blocks - offset=3D24, inode=3D7864433, rec_len=3D4088, name_len=3D10
Jan 16 00:17:01 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #3768432: unaligned directory =
entry - offset=3D0, inode=3D2154856560, rec_len=3D57, name_len=3D12
Jan 16 00:17:01 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #112: rec_len is smaller than =
minimal - offset=3D0, inode=3D7340144, rec_len=3D0, name_len=3D1
Jan 16 00:17:01 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #262194: rec_len is smaller than =
minimal - offset=3D0, inode=3D3276850, rec_len=3D4, name_len=3D12
Jan 16 00:17:01 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_check_page: bad entry in directory #7553072: inode out of bounds - =
offset=3D0, inode=3D1081294896, rec_len=3D12, name_len=3D1
Jan 16 12:22:40 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks in system zones - Block =3D 70, count =
=3D 1
Jan 16 12:26:38 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_new_block: Allocating block in system zone - block =3D 70
Jan 16 12:32:10 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks not in datazone - block =3D 2330394624, =
count =3D 1
Jan 16 12:32:10 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks in system zones - Block =3D 164, count =
=3D 1
Jan 16 12:32:10 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks not in datazone - block =3D 58064896, =
count =3D 1
Jan 16 12:32:10 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks not in datazone - block =3D 58130563, =
count =3D 1
Jan 16 12:32:10 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks not in datazone - block =3D 58196099, =
count =3D 1
Jan 16 12:32:10 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks not in datazone - block =3D 58261635, =
count =3D 1
Jan 16 12:32:10 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks not in datazone - block =3D 58327171, =
count =3D 1
Jan 16 12:32:10 atlantis kernel: EXT2-fs error (device md(9,0)): =
ext2_free_blocks: Freeing blocks in system zones - Block =3D 131, count =
=3D 1

------=_NextPart_000_005C_01C19F9F.A5238730--

