Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbTLCPP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTLCPPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:15:25 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:36240 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S264796AbTLCPPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:15:08 -0500
Date: Wed, 3 Dec 2003 16:15:05 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-t11 /proc/<xserver pid>/status question (VmLck > 4TB)
Message-Id: <20031203161505.475f1bad.martin.zwickel@technotrend.de>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.7claws9 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.0-test4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__3_Dec_2003_16_15_05_+0100_fix1rE5z1e7lC+9L"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__3_Dec_2003_16_15_05_+0100_fix1rE5z1e7lC+9L
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi there,

I have a small question:

If I look into the "/proc/<xserver pid>/status" file, there is a VmLck with a
4TeraByte number.

Is that normal?

# cat /proc/7850/status 
Name:   X
State:  S (sleeping)
SleepAVG:       101%
Tgid:   7850
Pid:    7850
PPid:   7848
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 256
Groups: 0 
VmSize:   377396 kB
VmLck:  4294967292 kB
VmRSS:     65724 kB
VmData:   101456 kB
VmStk:       320 kB
VmExe:      1604 kB
VmLib:      6844 kB
Threads:        1
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 8000000000301000
SigCgt: 00000000518066cb
CapInh: 0000000000000000
CapPrm: 00000000fffffeff
CapEff: 00000000fffffeff


Most other processes have 0kb.

cat /proc/*/status  | grep VmLck

...
VmLck:         0 kB
VmLck:         0 kB
VmLck:      2060 kB
VmLck:         0 kB
VmLck:         0 kB
VmLck:         4 kB
VmLck:         0 kB
...

Regards,
Martin


ps.:

I'm using the nvidia driver.
# cat /proc/driver/nvidia/version 
NVRM version: NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 16
19:03:09 PDT 2003 GCC version:  gcc version 3.2.3 20030422 (Gentoo Linux 1.4
3.2.3-r2, propolice)

# cat /proc/version 
Linux version 2.6.0-test11 (root@phoebee) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r2, propolice)) #6 Thu Nov 27 13:02:23 CET 2003

-- 
MyExcuse:
SCSI's too wide.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Wed__3_Dec_2003_16_15_05_+0100_fix1rE5z1e7lC+9L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zf35mjLYGS7fcG0RAjQGAJ4lf57tVaIe66ymY7QgiqYMTImS7wCgoZWJ
I6Jr/+hEh5grMMeY83O8piI=
=xxKC
-----END PGP SIGNATURE-----

--Signature=_Wed__3_Dec_2003_16_15_05_+0100_fix1rE5z1e7lC+9L--
