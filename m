Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSJWT46>; Wed, 23 Oct 2002 15:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265203AbSJWT46>; Wed, 23 Oct 2002 15:56:58 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:15887 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S265197AbSJWT4z>;
	Wed, 23 Oct 2002 15:56:55 -0400
Date: Wed, 23 Oct 2002 22:03:05 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.43] Bug on Alpha: 'Trying to free free buffer'
Message-ID: <20021023200305.GE24969@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Reading/writing from/to an ext3 filesystem causes some BUG() which asks
for being reported. The box is a NoName (aka AXPpci33), 128MB RAM, some
SCSI HDDs on a 'LSI Logic / Symbios Logic (formerly NCR) 53c810 (rev 01)'.
Here's the ksymoopsed dmesg:

VFS: brelse: Trying to free free buffer
buffer layer error at fs/buffer.c:1164
Pass this trace through ksymoops for reporting


ksymoops 2.4.6 on alpha 2.5.43.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.43/ (default)
     -m /boot/System.map-2.5.43--00 (specified)

Warning (compare_maps): ksyms_base symbol __start___kallsyms not found in S=
ystem.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __stop___kallsyms not found in Sy=
stem.map.  Ignoring ksyms_base entry
depmod(41): unaligned trap at 000000012000e750: 00000001201349ac 29 1
depmod(41): unaligned trap at 000000012000e758: 00000001201349ac 2d 1
depmod(41): unaligned trap at 000000012000e750: 0000000120147a84 29 1
depmod(41): unaligned trap at 000000012000e758: 0000000120147a84 2d 1
modprobe(94): unaligned trap at 0000000120011750: 000000012005db24 29 1
modprobe(94): unaligned trap at 0000000120011758: 000000012005db24 2d 1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
fffffc0003b3bc68 0000000000000000 fffffc0000860984 0000000000000003=20
       fffffc0000862630 fffffc0003b3bd14 fffffc00008b32c0 fffffc00031decc0=
=20
       fffffc00008b3648 fffffc0004b9b000 fffffc00008aafe0 fffffc00034bbb20=
=20
       fffffc0000eeb6a0 fffffc00027180f8 fffffc0000876c60 fffffc0003b3bee8=
=20
       fffffc0000876c60 000000011ffff450 21a6d5f53639d8ba fffffc0000000002=
=20
       fffffc0007ee8b50 fffffffe00000002 fffffc0000eeb6a0 000000002f0e092c=
=20
Trace:fffffc0000860984 fffffc0000862630 fffffc00008b32c0 fffffc00008b3648 f=
ffffc00008aafe0 fffffc0000876c60 fffffc0000876c60 fffffc00008aa4fc fffffc00=
00876778 fffffc0000876c60 fffffc0000870890 fffffc000086ecd8 fffffc000087111=
8 fffffc0000871848 fffffc0000832b98 fffffc0000876c60 fffffc0000876ec8 fffff=
c0000810c84 fffffc0000810c98 fffffc0000810be0=20
fffffc0006977a38 0000000000000000 fffffc0000860984 0000000000000003=20
       fffffc0000862630 0000000000000001 fffffc000086295c fffffc0000aef500=
=20
       fffffc0000862a9c fffffc0000aef500 fffffc0000336380 000000000006028e=
=20
       0000000000001000 fffffc0001c6cc78 fffffc0006977c68 0000000000000000=
=20
       fffffc0000aef500 fffffc000283e660 fffffc0005da6ba0 fffffc0000aefe60=
=20
       fffffc0002b0b620 fffffc000326ff80 fffffc0004edb020 fffffc0003fc2de0=
=20
Trace:fffffc0000860984 fffffc0000862630 fffffc000086295c fffffc0000862a9c f=
ffffc0000862af0 fffffc00008ae4d0 fffffc00008b3c0c fffffc00008be830 fffffc00=
008b422c fffffc00008b1a40 fffffc00008b1ad4 fffffc000086efcc fffffc000086f55=
0 fffffc000086ffe0 fffffc0000870890 fffffc0000870b0c fffffc0000870b30 fffff=
c000086a5ec fffffc000086a860 fffffc000086ede4 fffffc0000810c84 fffffc000085=
e328 fffffc0000810be0=20
fffffc0003b3bc68 0000000000000000 fffffc0000860984 0000000000000003=20
       fffffc0000862630 fffffc0003b3bd14 fffffc00008b32c0 fffffc0003198c00=
=20
       fffffc00008b3648 fffffc00031a5000 fffffc00008aafe0 fffffc0006c1aae0=
=20
       fffffc0006f01e40 fffffc00043583d8 fffffc0000876c60 fffffc0003b3bee8=
=20
       fffffc0000876c60 000000011ffff450 ca11e44355ff522e fffffc0000000002=
=20
       fffffc0007ee8b50 fffffffe00000002 fffffc0006f01e40 00000000530dbb22=
=20
Trace:fffffc0000860984 fffffc0000862630 fffffc00008b32c0 fffffc00008b3648 f=
ffffc00008aafe0 fffffc0000876c60 fffffc0000876c60 fffffc00008aa4fc fffffc00=
00876778 fffffc0000876c60 fffffc0000870890 fffffc000086eb9c fffffc000086ecd=
8 fffffc0000871118 fffffc0000871848 fffffc0000832b98 fffffc0000876c60 fffff=
c0000876ec8 fffffc0000810c84 fffffc0000810c98 fffffc0000810be0=20
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; fffffc0000860984 <__buffer_error+64/80>
Trace; fffffc0000862630 <__brelse+50/60>
Trace; fffffc00008b32c0 <dx_release+60/80>
Trace; fffffc00008b3648 <ext3_htree_fill_tree+1e8/240>
Trace; fffffc00008aafe0 <ext3_dx_readdir+1a0/200>
Trace; fffffc0000876c60 <filldir64+0/200>
Trace; fffffc0000876c60 <filldir64+0/200>
Trace; fffffc00008aa4fc <ext3_readdir+7c/500>
Trace; fffffc0000876778 <vfs_readdir+d8/160>
Trace; fffffc0000876c60 <filldir64+0/200>
Trace; fffffc0000870890 <path_lookup+150/180>
Trace; fffffc000086ecd8 <permission+58/a0>
Trace; fffffc0000871118 <may_open+98/380>
Trace; fffffc0000871848 <open_namei+448/660>
Trace; fffffc0000832b98 <update_process_times+58/80>
Trace; fffffc0000876c60 <filldir64+0/200>
Trace; fffffc0000876ec8 <sys_getdents64+68/120>
Trace; fffffc0000810c84 <entSys+a4/b8>
Trace; fffffc0000810c98 <ret_from_sys_call+0/10>
Trace; fffffc0000810be0 <entSys+0/b8>
Trace; fffffc0000860984 <__buffer_error+64/80>
Trace; fffffc0000862630 <__brelse+50/60>
Trace; fffffc000086295c <bh_lru_install+19c/1e0>
Trace; fffffc0000862a9c <__find_get_block+fc/120>
Trace; fffffc0000862af0 <__getblk+30/80>
Trace; fffffc00008ae4d0 <ext3_getblk+f0/380>
Trace; fffffc00008b3c0c <ext3_find_entry+18c/4e0>
Trace; fffffc00008be830 <do_get_write_access+6f0/740>
Trace; fffffc00008b422c <ext3_lookup+4c/160>
Trace; fffffc00008b1a40 <ext3_do_update_inode+4a0/5a0>
Trace; fffffc00008b1ad4 <ext3_do_update_inode+534/5a0>
Trace; fffffc000086efcc <real_lookup+cc/240>
Trace; fffffc000086f550 <do_lookup+130/360>
Trace; fffffc000086ffe0 <link_path_walk+860/da0>
Trace; fffffc0000870890 <path_lookup+150/180>
Trace; fffffc0000870b0c <__user_walk+2c/a0>
Trace; fffffc0000870b30 <__user_walk+50/a0>
Trace; fffffc000086a5ec <vfs_lstat+2c/80>
Trace; fffffc000086a860 <sys_newlstat+20/40>
Trace; fffffc000086ede4 <path_release+24/80>
Trace; fffffc0000810c84 <entSys+a4/b8>
Trace; fffffc000085e328 <sys_close+a8/e0>
Trace; fffffc0000810be0 <entSys+0/b8>
Trace; fffffc0000860984 <__buffer_error+64/80>
Trace; fffffc0000862630 <__brelse+50/60>
Trace; fffffc00008b32c0 <dx_release+60/80>
Trace; fffffc00008b3648 <ext3_htree_fill_tree+1e8/240>
Trace; fffffc00008aafe0 <ext3_dx_readdir+1a0/200>
Trace; fffffc0000876c60 <filldir64+0/200>
Trace; fffffc0000876c60 <filldir64+0/200>
Trace; fffffc00008aa4fc <ext3_readdir+7c/500>
Trace; fffffc0000876778 <vfs_readdir+d8/160>
Trace; fffffc0000876c60 <filldir64+0/200>
Trace; fffffc0000870890 <path_lookup+150/180>
Trace; fffffc000086eb9c <vfs_permission+dc/1c0>
Trace; fffffc000086ecd8 <permission+58/a0>
Trace; fffffc0000871118 <may_open+98/380>
Trace; fffffc0000871848 <open_namei+448/660>
Trace; fffffc0000832b98 <update_process_times+58/80>
Trace; fffffc0000876c60 <filldir64+0/200>
Trace; fffffc0000876ec8 <sys_getdents64+68/120>
Trace; fffffc0000810c84 <entSys+a4/b8>
Trace; fffffc0000810c98 <ret_from_sys_call+0/10>
Trace; fffffc0000810be0 <entSys+0/b8>


3 warnings issued.  Results may not be reliable.
MfG, JBG

--=20
   - Eine Freie Meinung in einem Freien Kopf f=FCr
   - einen Freien Staat voll Freier B=FCrger
   						Gegen Zensur im Internet
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9twB4Hb1edYOZ4bsRAp/JAJ9oNnUq03RYFW7psk18S2NUgGgNTgCfdECF
TqyL4+ssYZOZzK4wOEp0t1I=
=iebz
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
