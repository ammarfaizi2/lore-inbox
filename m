Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUAWNk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 08:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266556AbUAWNk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 08:40:58 -0500
Received: from srv1a-cta.bs2.com.br ([200.203.183.35]:33040 "EHLO
	srv1a-cta.bs2.com.br") by vger.kernel.org with ESMTP
	id S261974AbUAWNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 08:40:56 -0500
Message-ID: <40112465.8040801@gardenali.biz>
Date: Fri, 23 Jan 2004 11:40:53 -0200
From: Evaldo Gardenali <evaldo@gardenali.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: buggy raid checksumming selection?
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Uhh. correct me if I am wrong, but shouldnt it select the fastest algorithm?

md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
~   8regs     :  2747.600 MB/sec
~   32regs    :  1702.000 MB/sec
~   pIII_sse  :  1997.200 MB/sec
~   pII_mmx   :  4216.400 MB/sec
~   p5_mmx    :  5408.000 MB/sec
raid5: using function: pIII_sse (1997.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
~ [events: 00000036]
~ [events: 00000036]
~ [events: 00000036]
md: autorun ...

Linux server1 2.4.25-pre6-athlonxp #1 Tue Jan 20 11:49:48 BRST 2004 i686
unknown unknown GNU/Linux
"-athlonxp" was added by me, just for identification purposes. NO other
sources except vanilla 2.4.24 and official 2.4.25-pre6 patch were involved

evaldo@server1:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 2200+
stepping        : 1
cpu MHz         : 1800.109
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3591.37

root@server1:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:0b.0 Ethernet controller: Macronix, Inc. [MXIC] MX987x5 (rev 20)
00:0c.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
(rev 44)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 74)
root@server1:~#

Thanks
Evaldo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAESRl5121Y+8pAbIRAk8XAKClylSbg+Sht0lhWrIP9i1cjtb56gCeKBpv
ErxCiL4p5wrnAr4e4iEqU8M=
=wkDl
-----END PGP SIGNATURE-----
