Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUGIQk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUGIQk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 12:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUGIQkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 12:40:00 -0400
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:2032 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S265054AbUGIQiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 12:38:10 -0400
Subject: Invalid paging request (cfq_get_queue)
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: linux-kernel@vger.kernel.org
Cc: arjanv@redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YvqApM0PcBft0NF4A04Y"
Organization: Cornell University
Date: Fri, 09 Jul 2004 10:42:30 -0600
Message-Id: <1089391350.7132.5.camel@localhost.bluenet>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
X-PMX-Version: 4.6.0.99824, Antispam-Core: 4.6.0.101390, Antispam-Data: 2004.7.8.106480
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YvqApM0PcBft0NF4A04Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Rawhide, 2.6.7-1.476 (and I was just trying to get to 478, but here's
what happened instead)

Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
022387e1
*pde =3D 00000000
Oops: 0000 [#1]
Modules linked in: snd_mixer_oss nvidia snd_seq_midi snd_seq_midi_event
snd_seq snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc
gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ipv6
usbserial parport_pc lp parport iptable_filter ip_tables via_rhine mii
floppy sg scsi_mod nls_ascii vfat fat ext3 jbd dm_mod usblp uhci_hcd
button battery asus_acpi ac xfs
CPU:    0
EIP:    0060:[<022387e1>]    Tainted: P
EFLAGS: 00210202   (2.6.7-1.476)
EIP is at cfq_get_queue+0x28/0x98
eax: 6b6b6b6b   ebx: 0000000b   ecx: 09e901a4   edx: 6b6b6b6b
esi: 00001b58   edi: 00000220   ebp: 09e0f1b4   esp: 08fa9ba8
ds: 007b   es: 007b   ss: 0068
Process yum (pid: 7000, threadinfo=3D08fa9000 task=3D02ab8d90)
Stack: 09e0f1b4 00000220 090e2f14 09eccb0c 02238ae1 02238ac1 090e2f14
00000000
       0222fb5b 09ea291c 02231610 09ea29a8 00000220 00000020 00000000
09ea291c
       00000020 00000008 0223250e 013fa477 00000000 00000000 00000000
00000000
Call Trace:
 [<02238ae1>] cfq_set_request+0x20/0x63
 [<02238ac1>] cfq_set_request+0x0/0x63
 [<0222fb5b>] elv_set_request+0xa/0x17
 [<02231610>] get_request+0x281/0x44e
 [<0223250e>] __make_request+0x382/0x5c3
 [<02188ff0>] mpage_end_io_read+0x0/0x5e
 [<022328dd>] generic_make_request+0x18e/0x19e
 [<02188ff0>] mpage_end_io_read+0x0/0x5e
 [<02232991>] submit_bio+0xa4/0xac
 [<0a911d23>] linvfs_get_block+0x13/0x17 [xfs]
 [<02188ff0>] mpage_end_io_read+0x0/0x5e
 [<021890bb>] mpage_bio_submit+0x19/0x1d
 [<02189408>] do_mpage_readpage+0x259/0x342
 [<022328dd>] generic_make_request+0x18e/0x19e
 [<0a910b86>] kmem_zone_alloc+0x3b/0x70 [xfs]
 [<0a8c5095>] xfs_attr_leaf_get+0x24/0x82 [xfs]
 [<02188ff0>] mpage_end_io_read+0x0/0x5e
 [<02232991>] submit_bio+0xa4/0xac
 [<02189582>] mpage_readpages+0x91/0xf9
 [<0a911d10>] linvfs_get_block+0x0/0x17 [xfs]
 [<02142180>] __rmqueue+0xbb/0x106
 [<0a911e69>] linvfs_readpages+0x12/0x14 [xfs]
 [<0a911d10>] linvfs_get_block+0x0/0x17 [xfs]
 [<0214554d>] read_pages+0x2d/0xd0
 [<0214279c>] buffered_rmqueue+0x1dd/0x200
 [<02142861>] __alloc_pages+0xa2/0x283
 [<02145b8d>] do_page_cache_readahead+0x29a/0x2ba
 [<0213f553>] filemap_nopage+0x10e/0x287
 [<0215039d>] do_no_page+0xfd/0x434
 [<021bf461>] inode_has_perm+0x57/0x5f
 [<021508c9>] handle_mm_fault+0xe4/0x21e
 [<021191f4>] do_page_fault+0x16e/0x49c
 [<02161451>] vfs_read+0xda/0xe2
 [<02119086>] do_page_fault+0x0/0x49c
Code: 8b 02 0f 18 00 90 39 ca 74 0d 39 72 14 75 04 89 d0 eb 06 8b


--=-YvqApM0PcBft0NF4A04Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7sr2eAYa0mefxhMRAqrQAJ9C4q0WcRFrge9boOCDwRVATaXjugCguRxG
Z/VBoTZeBezusQ0DgluAINs=
=FsEE
-----END PGP SIGNATURE-----

--=-YvqApM0PcBft0NF4A04Y--

