Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTASBAc>; Sat, 18 Jan 2003 20:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbTASBAc>; Sat, 18 Jan 2003 20:00:32 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4832
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S265250AbTASBA3>; Sat, 18 Jan 2003 20:00:29 -0500
Date: Sat, 18 Jan 2003 17:09:07 -0800
To: Peter Karlsson <peter@softwolves.pp.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel crashes while scanning partition list
Message-ID: <20030119010907.GA28476@ludicrus.ath.cx>
References: <Pine.LNX.4.43.0301181344200.32727-100000@perkele>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0301181344200.32727-100000@perkele>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I ran your oops log through ksymoops, doesn't look like you made an=20
error writing it down :)

I have no clue what is going on, though - I'm just attaching it and see=20
if the list can make any sense of it.

Attached (ksymoops.log) is the aforementioned file

Regards
Josh

On Sat, Jan 18, 2003 at 02:02:40PM +0100, Peter Karlsson wrote:
> I am installing Debian Linux on my new Athlon XP PC, and I have
> problems with the 2.4.20 kernel crashing on boot. I can successfully
> boot using the 2.4.18 kernel build that is included with the Debian 3.0
> install cds.
>=20
> The problems seems to stem from my use of Promise FastTrak133 RAID
> controller (yes, I know they say it sucks, but it's what is integrated
> on the MB). In 2.4.18, I can get ataraid working, although I have to
> specify the address to the IDE controller manually. 2.4.20 picks that
> up automatically, but crashes when enumerating the HD partitions
> (reproducible every time).
>=20
> The crash output looks like this (I had to write it down by hand, hopeful=
ly
> there will be no typos):
>=20
> {{{output from enumerating partitions on /dev/ataraid/d0}}}
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
00
> printing eip: 00000000
> *pde =3D 00000000
> Oops: 00000000
> CPU: 0
> EIP: 0010:[<00000000>] Not tainted
> EFLAGS: 00010282
> eax: 00000000 ebx: 00000000 ecx: c038c740 edx: 00000000
> esi: f7e80f40 edi: 0040f5c8 ebp: 06ed3cf9 esp: c1c17d94
> ds: 0018 es: 0018 ss: 0018
> Process swapper (pid: 1, stackpage=3Dc1c17000)
> Stack: c01e5ddc c038c740 00000000 f7e80f40 00000002 00000000 f7e80dc0 c1a=
7b3d0
>        c01e5e3e 00000000 f7e80f40 00000000 00000006 c01351b0 00000000 f7e=
80f40
>        c1a7b3d0 d7fbcdb4 00000000 f7ed0d30 00001000 00000004 00000400 f7e=
80f40
> Call trace: [<c01e5ddc>] [<c01e5e3e>] [<c01351b0>] [<c012580c>] [<c0137d6=
f>]
>             [<c0137cd0>] [<c0127c75>] [<c0152162>] [<c0137d60>] [<c01522a=
3>]
>             [<c0116315>] [<c015278b>] [<c014538e>] [<c013811d>] [<c0151f8=
4>]
>             [<c01345f8>] [<c0296373>] [<c02093a8>] [<c02094ac>] [<c020943=
7>]
>             [<c01520f7>] [<c0152036>] [<c0208af4>] [<c0105037>] [<c01055b=
8>]
> Code: Bad EIP value.
> <0>Kernel panic: Attempted to kill init!
>=20
> The corresponding System.map file can be downloaded at
> <URL:http://www.softwolves.pp.se/tmp/2.4.20/System.map-2.4.20> and a
> partition list from sfdisk -l can be found at
> <URL:http://www.softwolves.pp.se/tmp/2.4.20/partlist.txt>.
>=20
> The motherboard is a MSI KT3Ultra2 ("VIA KT333 chipset based"), the CPU
> is an Athlon XP2200+, and the machine has 1 Gbyte of RAM.
>=20
> Any help in getting this resolved would be greatly appreciated! I
> really would like to move on from my old K6 machine...
>=20
> Please Cc replies to me, I do not subscribe to the list due to its
> volume.
> --=20
> \\//
> Peter - http://www.softwolves.pp.se/
>=20
>   I do not read or respond to mail with HTML attachments.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
=2E-`-.-`-.-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D----->
Joshua Kwan	joshk@ludicrus.ath.cx
		joshk@mspencer.net

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops.log"

ksymoops 2.4.8 on i586 2.4.20-ck2-kanoe.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map-2.4.20 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000000
*pde = 00000000
Oops: 00000000
CPU: 0
EIP: 0010:[<00000000>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000 ebx: 00000000 ecx: c038c740 edx: 00000000
esi: f7e80f40 edi: 0040f5c8 ebp: 06ed3cf9 esp: c1c17d94
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, stackpage=c1c17000)
Stack: c01e5ddc c038c740 00000000 f7e80f40 00000002 00000000 f7e80dc0 c1a7b3d0
       c01e5e3e 00000000 f7e80f40 00000000 00000006 c01351b0 00000000 f7e80f40
       c1a7b3d0 d7fbcdb4 00000000 f7ed0d30 00001000 00000004 00000400 f7e80f40
Call trace: [<c01e5ddc>] [<c01e5e3e>] [<c01351b0>] [<c012580c>] [<c0137d6f>]
            [<c0137cd0>] [<c0127c75>] [<c0152162>] [<c0137d60>] [<c01522a3>]
            [<c0116315>] [<c015278b>] [<c014538e>] [<c013811d>] [<c0151f84>]
            [<c01345f8>] [<c0296373>] [<c02093a8>] [<c02094ac>] [<c0209437>]
            [<c01520f7>] [<c0152036>] [<c0208af4>] [<c0105037>] [<c01055b8>]
Code: Bad EIP value.


>>EIP; 00000000 Before first symbol

>>ecx; c038c740 <blk_dev+0/9780>

Trace; c01e5ddc <generic_make_request+11c/130>
Trace; c01e5e3e <submit_bh+4e/70>
Trace; c01351b0 <block_read_full_page+230/250>
Trace; c012580c <add_to_page_cache_unique+6c/80>
Trace; c0137d6f <blkdev_readpage+f/20>
Trace; c0137cd0 <blkdev_get_block+0/40>
Trace; c0127c75 <read_cache_page+85/120>
Trace; c0152162 <read_dev_sector+32/90>
Trace; c0137d60 <blkdev_readpage+0/20>
Trace; c01522a3 <extended_partition+c3/210>
Trace; c0116315 <printk+105/120>
Trace; c015278b <msdos_partition+19b/2f0>
Trace; c014538e <get_empty_inode+8e/a0>
Trace; c013811d <bdget+fd/150>
Trace; c0151f84 <check_partition+104/180>
Trace; c01345f8 <bread+18/70>
Trace; c0296373 <_mmx_memcpy+53/160>
Trace; c02093a8 <calc_pdcblock_offset+18/70>
Trace; c02094ac <read_disk_sb+ac/e0>
Trace; c0209437 <read_disk_sb+37/e0>
Trace; c01520f7 <grok_partitions+b7/f0>
Trace; c0152036 <register_disk+26/30>
Trace; c0208af4 <ataraid_register_disk+24/28>
Trace; c0105037 <init+7/110>
Trace; c01055b8 <kernel_thread+28/40>


--zhXaljGHf11kAtnf--

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Kfqz6TRUxq22Mx4RAmfVAJ0dBFcYoijmT0ntrlrYFMKeeWhncQCgmVLM
bD4ME2ntY5ReXsjo93QVoo4=
=Zx9K
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
