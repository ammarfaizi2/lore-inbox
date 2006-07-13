Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWGMQKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWGMQKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGMQKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:10:24 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:17328 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S1751244AbWGMQKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:10:23 -0400
Date: Thu, 13 Jul 2006 18:10:19 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: 2.6.18-rc1-mm1 oom with nvidia driver + ut2004?
Message-ID: <20060713181019.2055a9f0@phoebee>
X-Mailer: Sylpheed-Claws 2.3.1cvs38 (GTK+ 2.8.19; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEUhITTZ2e7QzMp4ZjiXl6TO
 rmtPQq75iX51AAAAB3RJTUUHsQwfFzs7RBhzUQAAAgpJREFUOI1t1M+SojAQBvDUyHIP+gI0yV1J
 mLPTNJ63yGTO1hTL+z/CfknURWdTpYf+5WvzB1ReynBPQ0b1octoiEQu6ypMQq0+PICMrHksAvsH
 mH9ZH0LtHRoSe69fZJppfwP0DaUuY71IpK5AY9i+l/n2uK48zTdAIH5loFAjZT8LpMD8ifKFLTpe
 FxPLPlLARqxqsPG3Uqoim6EhtmRjqNUfG98T8JSBDMU5xnBV3zEeATueAoAQcANAqW+bQSU4NWQ4
 qN08o/sbbYDYYO1LnJF4u7fC1N6wdDU2FrcwOdULMza7xLTQJbgCI2CUCZtdQpq7uAwVY+eAdApV
 LlUlUYnvFDs5rtcaJYdKDAm8cKeiMwBV4Ff5cSHcB2BN6dyqQMXUZri+gKN058MTpLV5T7pAXogb
 3LVmfEvXtzc4JwiD82ITOM7gMtQcosM1xTiE1AngBx7TIcSAKgIxBwD9yIJWKOBGjnhscyBB5/Ov
 O9wVrsXtciABudQL3VzedQkATniaJa0LIRyvp/YGH3hsWfKFYjpTCeSnHQ8DiUsJedQz4JVJL43I
 pv54P6iMVr9CIa3/Ay9jA9RuOt1hNB5n4fr9Sev0ecDZVKYi2nU96XP/DIdK66rrxXQ/4cD7nR/P
 1Q8Q6nxlxi3sHR/8wbmuH9v9plWD42ixVtJto3X7Aq8b9Lf/JHke4184VLhUB3OxCQAAAABJRU5E
 rkJggg==
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_i5VIXmnYWxBT.Wrb+.Z9ce+;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_i5VIXmnYWxBT.Wrb+.Z9ce+
Content-Type: multipart/mixed; boundary="MP_=ui=xnlFzquGtfWAUh6Wt/R"

--MP_=ui=xnlFzquGtfWAUh6Wt/R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there!

I don't know if it's a kernel or nvidia driver issue, but maybe someone
has some clue:

I tried 2.6.18-rc1-mm1 today with the nvidia driver 1.0.8762.
I enabled CONFIG_SWAP_PREFETCH and CONFIG_ADAPTIVE_READAHEAD in kernel
config (attached).


Then I wanted to start ut2004 and got this OOM:

Jul 13 17:59:53 phoebee [  152.425748] agpgart: Detected SiS 646 chipset
Jul 13 17:59:53 phoebee [  152.443330] agpgart: AGP aperture is 64M @ 0xe00=
00000
Jul 13 18:00:07 phoebee yasuc[9267]: Transfer successful
Jul 13 18:00:17 phoebee [  176.381610] oom-killer: gfp_mask=3D0x2d1, order=
=3D0
Jul 13 18:00:17 phoebee [  176.381836]  [<c013e083>] out_of_memory+0xe9/0xf6
Jul 13 18:00:17 phoebee [  176.381923]  [<c013f1ff>] __alloc_pages+0x227/0x=
2ab
Jul 13 18:00:17 phoebee [  176.382115]  [<c013f2a0>] __get_free_pages+0x1d/=
0x33
Jul 13 18:00:17 phoebee [  176.382195]  [<f8fdb508>] nv_vm_malloc_pages+0xd=
e/0x26c [nvidia]
Jul 13 18:00:17 phoebee [  176.382476]  [<f8fda219>] nv_alloc_pages+0x1a3/0=
x25c [nvidia]
Jul 13 18:00:17 phoebee [  176.382685]  [<c01038a6>] common_interrupt+0x1a/=
0x20
Jul 13 18:00:17 phoebee [  176.382768]  [<f8d826fb>] _nv002582rm+0x47/0x4c =
[nvidia]
Jul 13 18:00:17 phoebee [  176.382979]  [<f8d82133>] _nv002500rm+0x1b/0x20 =
[nvidia]
Jul 13 18:00:17 phoebee [  176.383150]  [<f8f41463>] _nv003646rm+0x33/0x13c=
 [nvidia]
Jul 13 18:00:17 phoebee [  176.383365]  [<f8f413a6>] _nv003645rm+0x56/0xc0 =
[nvidia]
Jul 13 18:00:17 phoebee [  176.383576]  [<f8ee8c72>] _nv005475rm+0x43a/0x47=
c [nvidia]
Jul 13 18:00:17 phoebee [  176.383792]  [<f8ee9841>] _nv005436rm+0x15/0x1c =
[nvidia]
Jul 13 18:00:17 phoebee [  176.384539]  [<f8d67610>] _nv001922rm+0xe4/0x190=
 [nvidia]
Jul 13 18:00:17 phoebee [  176.384751]  [<f8d6763d>] _nv001922rm+0x111/0x19=
0 [nvidia]
Jul 13 18:00:17 phoebee [  176.384913]  [<f8ee8f9a>] _nv005203rm+0x8a/0x94 =
[nvidia]
Jul 13 18:00:17 phoebee [  176.385156]  [<f8d679a7>] _nv001927rm+0x2eb/0x5e=
8 [nvidia]
Jul 13 18:00:17 phoebee [  176.385324]  [<f8d64dbf>] _nv003371rm+0x8b/0xd8 =
[nvidia]
Jul 13 18:00:17 phoebee [  176.385486]  [<f8d8c3f3>] _nv001809rm+0x143/0x5d=
0 [nvidia]
Jul 13 18:00:17 phoebee [  176.385657]  [<f8fdc78b>] os_pci_read_dword+0x36=
/0x42 [nvidia]
Jul 13 18:00:17 phoebee [  176.385865]  [<c0304627>] bit_xfer+0x583/0x643
Jul 13 18:00:17 phoebee [  176.385958]  [<f8fd6d53>] verify_pci_bars+0x3f/0=
x134 [nvidia]
Jul 13 18:00:17 phoebee [  176.386169]  [<c025cb8f>] pci_bus_read_config_wo=
rd+0x63/0x82
Jul 13 18:00:17 phoebee [  176.386255]  [<f8d8ac4c>] rm_ioctl+0x1c/0x24 [nv=
idia]
Jul 13 18:00:17 phoebee [  176.386430]  [<c02563ab>] copy_from_user+0x3a/0x=
73
Jul 13 18:00:17 phoebee [  176.386514]  [<f8fd8feb>] nv_kern_ioctl+0x33a/0x=
38e [nvidia]
Jul 13 18:00:17 phoebee [  176.386713]  [<f8fd905a>] nv_kern_unlocked_ioctl=
+0x1b/0x23 [nvidia]
Jul 13 18:00:17 phoebee [  176.386916]  [<f8fd903f>] nv_kern_unlocked_ioctl=
+0x0/0x23 [nvidia]
Jul 13 18:00:17 phoebee [  176.387133]  [<c016afd2>] do_ioctl+0x72/0x82
Jul 13 18:00:17 phoebee [  176.387215]  [<c0304627>] bit_xfer+0x583/0x643
Jul 13 18:00:17 phoebee [  176.387291]  [<c016b160>] vfs_ioctl+0x5e/0x1a9
Jul 13 18:00:17 phoebee [  176.387368]  [<c016b2e8>] sys_ioctl+0x3d/0x65
Jul 13 18:00:17 phoebee [  176.387445]  [<c0102eb5>] sysenter_past_esp+0x56=
/0x79
Jul 13 18:00:17 phoebee [  176.387530]  [<c0304627>] bit_xfer+0x583/0x643
Jul 13 18:00:17 phoebee [  176.387607] Mem-info:
Jul 13 18:00:17 phoebee [  176.387662] DMA per-cpu:
Jul 13 18:00:17 phoebee [  176.387735] cpu 0 hot: high 0, batch 1 used:0
Jul 13 18:00:17 phoebee [  176.387799] cpu 0 cold: high 0, batch 1 used:0
Jul 13 18:00:17 phoebee [  176.387862] Normal per-cpu:
Jul 13 18:00:17 phoebee [  176.387984] cpu 0 hot: high 186, batch 31 used:1=
55
Jul 13 18:00:17 phoebee [  176.388052] cpu 0 cold: high 62, batch 15 used:47
Jul 13 18:00:17 phoebee [  176.388117] HighMem per-cpu:
Jul 13 18:00:17 phoebee [  176.388189] cpu 0 hot: high 42, batch 7 used:40
Jul 13 18:00:17 phoebee [  176.388253] cpu 0 cold: high 14, batch 3 used:12
Jul 13 18:00:17 phoebee [  176.388319] Active:79673 inactive:37272 dirty:53=
7 writeback:0 unstable:0 free:133684 slab:2446 mapped:9573 pagetables:334
Jul 13 18:00:17 phoebee [  176.388405] DMA free:68kB min:68kB low:84kB high=
:100kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclai=
mable? yes
Jul 13 18:00:17 phoebee [  176.388490] lowmem_reserve[]: 0 880 1007
Jul 13 18:00:17 phoebee [  176.388598] Normal free:515912kB min:3756kB low:=
4692kB high:5632kB active:220920kB inactive:140468kB present:901120kB pages=
_scanned:0 all_unreclaimable? no
Jul 13 18:00:17 phoebee [  176.388687] lowmem_reserve[]: 0 0 1023
Jul 13 18:00:17 phoebee [  176.388794] HighMem free:18756kB min:128kB low:2=
64kB high:400kB active:97772kB inactive:8620kB present:131008kB pages_scann=
ed:0 all_unreclaimable? no
Jul 13 18:00:17 phoebee [  176.388881] lowmem_reserve[]: 0 0 0
Jul 13 18:00:17 phoebee [  176.388993] DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64k=
B 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 68kB
Jul 13 18:00:17 phoebee [  176.389204] Normal: 726*4kB 208*8kB 131*16kB 88*=
32kB 27*64kB 15*128kB 6*256kB 3*512kB 2*1024kB 1*2048kB 121*4096kB =3D 5159=
12kB
Jul 13 18:00:17 phoebee [  176.389418] HighMem: 701*4kB 448*8kB 209*16kB 10=
2*32kB 36*64kB 11*128kB 4*256kB 2*512kB 0*1024kB 0*2048kB 0*4096kB =3D 1875=
6kB
Jul 13 18:00:17 phoebee [  176.389632] Swap cache: add 0, delete 0, find 0/=
0, race 0+0
Jul 13 18:00:17 phoebee [  176.389699] Free swap  =3D 1894132kB
Jul 13 18:00:17 phoebee [  176.389760] Total swap =3D 1894132kB
Jul 13 18:00:17 phoebee [  176.389820] Free swap:       1894132kB
Jul 13 18:00:17 phoebee [  176.395295] 262128 pages of RAM
Jul 13 18:00:17 phoebee [  176.395479] 32752 pages of HIGHMEM
Jul 13 18:00:17 phoebee [  176.395540] 6346 reserved pages
Jul 13 18:00:17 phoebee [  176.395601] 39361 pages shared
Jul 13 18:00:17 phoebee [  176.395738] 0 pages swap cached
Jul 13 18:00:17 phoebee [  176.395806] 537 pages dirty
Jul 13 18:00:17 phoebee [  176.395865] 0 pages writeback
Jul 13 18:00:17 phoebee [  176.395938] 9573 pages mapped
Jul 13 18:00:17 phoebee [  176.396000] 2446 pages slab
Jul 13 18:00:17 phoebee [  176.396059] 334 pages pagetables


.... (many oom-killer outputs, they look the same as the above one)



Jul 13 18:00:17 phoebee [  176.602051] Mem-info:
Jul 13 18:00:17 phoebee [  176.602107] DMA per-cpu:
Jul 13 18:00:17 phoebee [  176.602179] cpu 0 hot: high 0, batch 1 used:0
Jul 13 18:00:17 phoebee [  176.602243] cpu 0 cold: high 0, batch 1 used:0
Jul 13 18:00:17 phoebee [  176.602306] Normal per-cpu:
Jul 13 18:00:17 phoebee [  176.602377] cpu 0 hot: high 186, batch 31 used:1=
45
Jul 13 18:00:17 phoebee [  176.602441] cpu 0 cold: high 62, batch 15 used:47
Jul 13 18:00:17 phoebee [  176.602504] HighMem per-cpu:
Jul 13 18:00:17 phoebee [  176.602575] cpu 0 hot: high 42, batch 7 used:4
Jul 13 18:00:17 phoebee [  176.602639] cpu 0 cold: high 14, batch 3 used:12
Jul 13 18:00:17 phoebee [  176.602713] Active:64146 inactive:37266 dirty:55=
0 writeback:0 unstable:0 free:149268 slab:2446 mapped:9555 pagetables:329
Jul 13 18:00:17 phoebee [  176.602799] DMA free:68kB min:68kB low:84kB high=
:100kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclai=
mable? yes
Jul 13 18:00:17 phoebee [  176.602884] lowmem_reserve[]: 0 880 1007
Jul 13 18:00:17 phoebee [  176.602992] Normal free:577912kB min:3756kB low:=
4692kB high:5632kB active:158988kB inactive:140460kB present:901120kB pages=
_scanned:0 all_unreclaimable? no
Jul 13 18:00:17 phoebee [  176.603082] lowmem_reserve[]: 0 0 1023
Jul 13 18:00:17 phoebee [  176.603188] HighMem free:19092kB min:128kB low:2=
64kB high:400kB active:97596kB inactive:8604kB present:131008kB pages_scann=
ed:0 all_unreclaimable? no
Jul 13 18:00:17 phoebee [  176.603276] lowmem_reserve[]: 0 0 0
Jul 13 18:00:17 phoebee [  176.603379] DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64k=
B 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 68kB
Jul 13 18:00:17 phoebee [  176.603589] Normal: 1152*4kB 429*8kB 281*16kB 18=
6*32kB 103*64kB 49*128kB 33*256kB 27*512kB 12*1024kB 6*2048kB 122*4096kB =
=3D 577912kB
Jul 13 18:00:17 phoebee [  176.603810] HighMem: 27*4kB 505*8kB 248*16kB 125=
*32kB 43*64kB 13*128kB 6*256kB 2*512kB 0*1024kB 0*2048kB 0*4096kB =3D 19092=
kB
Jul 13 18:00:17 phoebee [  176.604024] Swap cache: add 0, delete 0, find 0/=
0, race 0+0
Jul 13 18:00:17 phoebee [  176.604090] Free swap  =3D 1894132kB
Jul 13 18:00:17 phoebee [  176.604150] Total swap =3D 1894132kB
Jul 13 18:00:17 phoebee [  176.604210] Free swap:       1894132kB
Jul 13 18:00:17 phoebee [  176.609701] 262128 pages of RAM
Jul 13 18:00:17 phoebee [  176.609886] 32752 pages of HIGHMEM
Jul 13 18:00:17 phoebee [  176.609948] 6346 reserved pages
Jul 13 18:00:17 phoebee [  176.610009] 53141 pages shared
Jul 13 18:00:17 phoebee [  176.610069] 0 pages swap cached
Jul 13 18:00:17 phoebee [  176.610158] 551 pages dirty
Jul 13 18:00:17 phoebee [  176.610219] 0 pages writeback
Jul 13 18:00:17 phoebee [  176.610279] 9555 pages mapped
Jul 13 18:00:17 phoebee [  176.610340] 2446 pages slab
Jul 13 18:00:17 phoebee [  176.610399] 329 pages pagetables
Jul 13 18:00:18 phoebee [  177.171196] Out of Memory: Kill process 9014 (e1=
6) score 4245 and children.
Jul 13 18:00:18 phoebee [  177.171201] Out of memory: Killed process 9056 (=
xautolock).
Jul 13 18:00:18 phoebee [  177.172203] Out of Memory: Kill process 9014 (e1=
6) score 4227 and children.
Jul 13 18:00:18 phoebee [  177.172209] Out of memory: Killed process 9109 (=
unclutter).
Jul 13 18:00:18 phoebee [  177.174287] Out of Memory: Kill process 9014 (e1=
6) score 4209 and children.
Jul 13 18:00:18 phoebee [  177.174293] Out of memory: Killed process 9112 (=
sylpheed-claws).
Jul 13 18:00:18 phoebee [  177.182186] Out of Memory: Kill process 9014 (e1=
6) score 3878 and children.
Jul 13 18:00:18 phoebee [  177.182192] Out of memory: Killed process 9115 (=
licq).
Jul 13 18:00:18 phoebee [  177.186839] Out of Memory: Kill process 9242 (ut=
2004.sh) score 3425 and children.
Jul 13 18:00:18 phoebee [  177.186845] Out of memory: Killed process 9246 (=
ut2004-bin).
Jul 13 18:00:18 phoebee [  177.187215] NVRM: VM: nv_vm_malloc_pages: failed=
 to allocate a page


To me it looks like there should be enough free RAM + SWAP ...

Regards,
Martin

--=20
MyExcuse:
bad ether in the cables

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--MP_=ui=xnlFzquGtfWAUh6Wt/R
Content-Type: application/x-bzip; name=2.6.18-rc1-mm1.config.bz2
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=2.6.18-rc1-mm1.config.bz2

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

--MP_=ui=xnlFzquGtfWAUh6Wt/R--

--Sig_i5VIXmnYWxBT.Wrb+.Z9ce+
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEtnBsmjLYGS7fcG0RAqUFAJ4vR1PQaNCN3jAOM+C4VO3IlQ69WQCfa+b4
fm1atdT/9JPfs38BFQKkXNc=
=oFHV
-----END PGP SIGNATURE-----

--Sig_i5VIXmnYWxBT.Wrb+.Z9ce+--
