Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWCEKID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWCEKID (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 05:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWCEKID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 05:08:03 -0500
Received: from 213-205-70-171.net.novis.pt ([213.205.70.171]:37522 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751029AbWCEKIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 05:08:01 -0500
Message-ID: <440AB878.7070401@artenumerica.com>
Date: Sun, 05 Mar 2006 10:07:52 +0000
From: J M Cerqueira Esteves <jmce@artenumerica.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, support@artenumerica.com, ngalamba@fc.ul.pt,
       Jens Axboe <axboe@suse.de>
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
References: <4405D383.5070201@artenumerica.com>	<20060302011735.55851ca2.akpm@osdl.org>	<440865A9.4000102@artenumerica.com>	<4409B8DC.9040404@artenumerica.com> <20060304161519.6e6fbe2c.akpm@osdl.org> <440A531D.9050009@artenumerica.com>
In-Reply-To: <440A531D.9050009@artenumerica.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig619B75C249E1D48F2228A98D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig619B75C249E1D48F2228A98D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

J M Cerqueira Esteves wrote:
> I'll test it in a few hours, after a short "barbaric" test
> inspired (perhaps naively) by those call traces: running with a 2.6.15.4
> without SCSI cd-rom support (with multiple Gaussian processes, no
> oom-killings until now (3 hours)).

And still running after 10 hours, but now I increased the load adding
another Gaussian run (still not requiring swap) and oom-killer
manifested itself again, although no killings were reported:

[35948.126969] Call Trace:<ffffffff8015efcb>{out_of_memory+23}
<ffffffff80161177>{__alloc_pages+572}
[35948.127018]        <ffffffff8017fc25>{bio_copy_user+219}
<ffffffff801debbf>{blk_rq_map_user+133}
[35948.127073]        <ffffffff801e1b61>{sg_io+351}
<ffffffff801e1ff8>{scsi_cmd_ioctl+494}
[35948.127135]        <ffffffff80130465>{__wake_up+56}
<ffffffff80265aac>{sock_def_readable+52}
[35948.127162]        <ffffffff802c5d68>{unix_dgram_sendmsg+1085}
<ffffffff88077e35>{:sd_mod:sd_ioctl+371}
[35948.127231]        <ffffffff801e0058>{blkdev_driver_ioctl+93}
<ffffffff801e0726>{blkdev_ioctl+1613}
[35948.127277]        <ffffffff8018ce76>{do_select+1137}
<ffffffff8026321e>{sys_sendto+251}
[35948.127334]        <ffffffff8018c941>{__pollwait+0}
<ffffffff801813d2>{block_ioctl+27}
[35948.127367]        <ffffffff8018c091>{do_ioctl+33}
<ffffffff8018c36c>{vfs_ioctl+643}
[35948.127383]        <ffffffff8018c3e0>{sys_ioctl+91}
<ffffffff8010fa46>{system_call+126}
[35948.127419]
[35948.127453] oom-killer: gfp_mask=0xd1, order=0
[35948.127456] Mem-info:
[35948.127458] DMA per-cpu:
[35948.127461] cpu 0 hot: low 0, high 0, batch 1 used:0
[35948.127464] cpu 0 cold: low 0, high 0, batch 1 used:0
[35948.127468] cpu 1 hot: low 0, high 0, batch 1 used:0
[35948.127471] cpu 1 cold: low 0, high 0, batch 1 used:0
[35948.127474] cpu 2 hot: low 0, high 0, batch 1 used:0
[35948.127478] cpu 2 cold: low 0, high 0, batch 1 used:0
[35948.127481] cpu 3 hot: low 0, high 0, batch 1 used:0
[35948.127484] cpu 3 cold: low 0, high 0, batch 1 used:0
[35948.127487] DMA32 per-cpu:
[35948.127490] cpu 0 hot: low 0, high 186, batch 31 used:173
[35948.127494] cpu 0 cold: low 0, high 62, batch 15 used:55
[35948.127497] cpu 1 hot: low 0, high 186, batch 31 used:64
[35948.127501] cpu 1 cold: low 0, high 62, batch 15 used:10
[35948.127504] cpu 2 hot: low 0, high 186, batch 31 used:148
[35948.127508] cpu 2 cold: low 0, high 62, batch 15 used:5
[35948.127511] cpu 3 hot: low 0, high 186, batch 31 used:157
[35948.127515] cpu 3 cold: low 0, high 62, batch 15 used:11
[35948.127517] Normal per-cpu:
[35948.127521] cpu 0 hot: low 0, high 186, batch 31 used:144
[35948.127524] cpu 0 cold: low 0, high 62, batch 15 used:50
[35948.127528] cpu 1 hot: low 0, high 186, batch 31 used:24
[35948.127531] cpu 1 cold: low 0, high 62, batch 15 used:7
[35948.127535] cpu 2 hot: low 0, high 186, batch 31 used:30
[35948.127538] cpu 2 cold: low 0, high 62, batch 15 used:15
[35948.127541] cpu 3 hot: low 0, high 186, batch 31 used:17
[35948.127545] cpu 3 cold: low 0, high 62, batch 15 used:14
[35948.127548] HighMem per-cpu: empty
[35948.127552] Free pages:       84424kB (0kB HighMem)
[35948.127557] Active:827765 inactive:133975 dirty:283294 writeback:0
unstable:0 free:21106 slab:20548 mapped:432093 pagetables:1441
[35948.127563] DMA free:20kB min:24kB low:28kB high:36kB active:0kB
inactive:0kB present:12464kB pages_scanned:2 all_unreclaimable? yes
[35948.127568] lowmem_reserve[]: 0 3255 4013 4013
[35948.127576] DMA32 free:82028kB min:6564kB low:8204kB high:9844kB
active:2587856kB inactive:511984kB present:3333792kB pages_scanned:0
all_unreclaimable? no
[35948.127580] lowmem_reserve[]: 0 0 757 757
[35948.127587] Normal free:2376kB min:1528kB low:1908kB high:2292kB
active:723204kB inactive:23916kB present:775680kB pages_scanned:0
all_unreclaimable? no
[35948.127592] lowmem_reserve[]: 0 0 0 0
[35948.127598] HighMem free:0kB min:128kB low:128kB high:128kB
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[35948.127602] lowmem_reserve[]: 0 0 0 0
[35948.127606] DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB
0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
[35948.127619] DMA32: 931*4kB 664*8kB 216*16kB 169*32kB 94*64kB 6*128kB
36*256kB 0*512kB 1*1024kB 19*2048kB 2*4096kB = 82028kB
[35948.127632] Normal: 8*4kB 51*8kB 1*16kB 0*32kB 4*64kB 1*128kB 0*256kB
1*512kB 1*1024kB 0*2048kB 0*4096kB = 2376kB
[35948.127644] HighMem: empty
[35948.127648] Swap cache: add 120, delete 120, find 14/25, race 0+1
[35948.127651] Free swap  = 3517904kB
[35948.127654] Total swap = 3518152kB
[35948.127656] Free swap:       3517904kB
[35948.146970] 1245184 pages of RAM
[35948.146974] 232833 reserved pages
[35948.146977] 424256 pages shared
[35948.146980] 0 pages swap cached

I'll now test the x86_64-mm-blk-bounce.patch (with CONFIG_FRAME_POINTER
enabled).

Best regards
                           J Esteves


-- 
+351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce

--------------enig619B75C249E1D48F2228A98D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFECrh/esWiVDEbnjYRAg8oAKDG9EDZhaQBIQNL6yKa6o3DOShI4ACdFdso
GlxesPt0Qgk9+wAKZ1yimzA=
=B43/
-----END PGP SIGNATURE-----

--------------enig619B75C249E1D48F2228A98D--
