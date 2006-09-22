Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbWIVWp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbWIVWp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWIVWp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:45:26 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:5542 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S965247AbWIVWpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:45:25 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: linux-kernel@vger.kernel.org
Subject: [BUG] warning at kernel/cpu.c:38/lock_cpu_hotplug()
Date: Sat, 23 Sep 2006 01:45:16 +0300
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5567875.WOyW2eIIkT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609230145.21997.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5567875.WOyW2eIIkT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi;

With kernel-2.6.18, "modprobe cpufreq_stats" always (i can reproduce) gaves=
=20
following;

=2E..
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
 [<b0134a42>] lock_cpu_hotplug+0x42/0x65
 [<b02f8af1>] cpufreq_update_policy+0x25/0xad
 [<b0358756>] kprobe_flush_task+0x18/0x40
 [<b0355aab>] schedule+0x63f/0x68b
 [<b01377c2>] __link_module+0x0/0x1f
 [<b0119e7d>] __cond_resched+0x16/0x34
 [<b03560bf>] cond_resched+0x26/0x31
 [<b0355b0e>] wait_for_completion+0x17/0xb1
 [<f965c547>] cpufreq_stat_cpu_callback+0x13/0x20 [cpufreq_stats]
 [<f9670074>] cpufreq_stats_init+0x74/0x8b [cpufreq_stats]
 [<b0137872>] sys_init_module+0x91/0x174
 [<b0102c81>] sysenter_past_esp+0x56/0x79

on=20

zangetsu ~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.73GHz
stepping        : 8
cpu MHz         : 1733.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up est tm2
bogomips        : 3460.58

If needed i can gave more info/config etc.

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart5567875.WOyW2eIIkT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFFGeBy7E6i0LKo6YRAgWrAJ9lkJISItUkqILKjnqQL9o3SIdxpwCgycfD
RTODT9Ue9lkDkR1epkzFsOM=
=lwiU
-----END PGP SIGNATURE-----

--nextPart5567875.WOyW2eIIkT--
